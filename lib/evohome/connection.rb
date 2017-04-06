module Evohome
  class Connection

    API_HOST = 'https://tccna.honeywell.com'
    URLS = {
      auth:  '/Auth/OAuth/Token',
      account: '/WebAPI/emea/api/v1/userAccount',
      installations:  '/WebAPI/emea/api/v1/location/installationInfo',
      gateway: '/WebAPI/emea/api/v1/gateway'
    }

    attr_reader :faraday

    def initialize
      @faraday = Faraday.new(API_HOST) do |builder|
        builder.use Middleware::ParseJson
        builder.use Middleware::Status
        builder.request :url_encoded
        builder.adapter Faraday.default_adapter        
      end
    end

    def authenticate(username, password)
      headers = {
        'Authorization':	'Basic YjAxM2FhMjYtOTcyNC00ZGJkLTg4OTctMDQ4YjlhYWRhMjQ5OnRlc3Q=',
        'Accept': 'application/json, application/xml, text/json, text/x-json, text/javascript, text/xml'
      }
      data = {
        'Content-Type':	'application/x-www-form-urlencoded; charset=utf-8',
        'Host':	'rs.alarmnet.com/',
        'Cache-Control':'no-store no-cache',
        'Pragma':	'no-cache',
        'grant_type':	'password',
        'scope':	'EMEA-V1-Basic EMEA-V1-Anonymous EMEA-V1-Get-Current-User-Account',
        'Username':	username,
        'Password':	password,
        'Connection':	'Keep-Alive'
      }

      response = faraday.post URLS[:auth], data, headers
      @access_token = response.body['access_token']
      puts response.status
      puts response.body
    end
    
    def get(endpoint, params = {})
      uri = Addressable::URI.new
      uri.path = URLS[endpoint]
      uri.query_values = params
      puts @access_token
      puts uri.to_s
      raise Errors::NotAuthorised.new(nil) if @access_token.to_s.empty?
      response = faraday.get URLS[endpoint], params, authenticated_headers
      response.body
    end

    private

    def authenticated_headers
      {
        'Authorization': "bearer #{@access_token}",
        'applicationId': 'b013aa26-9724-4dbd-8897-048b9aada249',
        'Accept': 'application/json, application/xml, text/json, text/x-json, text/javascript, text/xml'
      }
    end

  end
end