module ActiveRecord
  module Enum
    def enum(definitions)
      klass = self
      definitions.each do |name, values|
        # statuses = { }
        enum_values = ActiveSupport::HashWithIndifferentAccess.new
        name        = name.to_sym
        plural_name = name.to_s.pluralize

        # def self.statuses statuses end
        detect_enum_conflict!(name, plural_name, true)
        klass.singleton_class.send(:define_method, plural_name) { enum_values }

        # def self.statuses_by_sym statuses(:active, :offline) end
        detect_enum_conflict!(name, "#{plural_name}_by_sym", true)
        klass.singleton_class.send(:define_method, "#{plural_name}_by_sym") { |*values|
          raise ArgumentError, 'Values should be String or Symbol' if values.any? { |val| val.is_a?(Array) }
          klass.send(plural_name).values_at(*values).compact
        }

        _enum_methods_module.module_eval do
          # def status=(value) self[:status] = statuses[value] end
          klass.send(:detect_enum_conflict!, name, "#{name}=")
          define_method("#{name}=") { |value|
            if enum_values.has_key?(value) || value.blank?
              self[name] = enum_values[value]
            elsif enum_values.has_value?(value)
              # Assigning a value directly is not a end-user feature, hence it's not documented.
              # This is used internally to make building objects from the generated scopes work
              # as expected, i.e. +Conversation.archived.build.archived?+ should be true.
              self[name] = value
            else
              raise ArgumentError, "'#{value}' is not a valid #{name}"
            end
          }

          # def status() statuses.key self[:status] end
          klass.send(:detect_enum_conflict!, name, name)
          define_method(name) { enum_values.key self[name] }

          # def status_before_type_cast() statuses.key self[:status] end
          klass.send(:detect_enum_conflict!, name, "#{name}_before_type_cast")
          define_method("#{name}_before_type_cast") { enum_values.key self[name] }

          pairs = values.respond_to?(:each_pair) ? values.each_pair : values.each_with_index
          pairs.each do |value, i|
            enum_values[value] = i

            # def active?() status == 0 end
            klass.send(:detect_enum_conflict!, name, "#{value}?")
            define_method("#{value}?") { self[name] == i }

            # def active!() update! status: :active end
            klass.send(:detect_enum_conflict!, name, "#{value}!")
            define_method("#{value}!") { update! name => value }

            # scope :active, -> { where status: 0 }
            klass.send(:detect_enum_conflict!, name, value, true)
            klass.scope value, -> { klass.where name => i }
          end
        end
        defined_enums[name.to_s] = enum_values
      end
    end

    def enum_hash
      klass = self

      if klass.defined_enums.present?
        klass.defined_enums.keys.each do |enum_name|
          plural_name = enum_name.to_s.pluralize

          klass.singleton_class.send(:define_method, "#{plural_name}_by_sym") do |*values|
            raise ArgumentError, 'Values should be String or Symbol' if values.any? { |val| val.is_a?(Array) }
            klass.send(plural_name).values_at(*values)
          end
        end
      end
    end
  end
end