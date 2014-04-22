module Requests
  module JsonHelpers
    def json
      @json ||= JSON.parse(response.body)
    end

    def request_headers
      @request_headers ||= { "Accept" => "application/json",
                       "Content-Type" => "application/json" }
    end
  end
end
