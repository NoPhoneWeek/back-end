require "sinatra/base"

require_relative "modules/login"

module NoPhoneWeek
    class Main < Sinatra::Base
        before do                               # defualts
            content_type "application/json"     # JSON
        end

        # Modules
        use NoPhoneWeek::LoginRoutes

        run!                                    # Start the server
    end
end

