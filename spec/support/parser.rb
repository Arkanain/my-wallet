module Support
  module Parser
    def body
      JSON.parse(last_response.body, symbolize_names: true)
    end
  end
end