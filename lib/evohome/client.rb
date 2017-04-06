module Evohome
  class Client

    attr_reader :access_token, :account_info, :locations

    def initialize(options = {})
      username = options.fetch(:username)
      password = options.fetch(:password)
      @connection = Connection.new
      @connection.authenticate(username,password)
      
      @account_info = AccountInfo.new(user_account)
      @locations = installation.map { |i| Location.new(i) }
    end

    private

    def installation
      result = @connection.get(:installations, userId: account_info.userId, includeTemperatureControlSystems: 'True')
      puts result
      result
    end
    
    def user_account
      result = @connection.get(:account)
      puts result
      result
    end
    

  end
end