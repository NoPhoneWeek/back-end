require "sinatra/base"

require_relative "lib/env"
raise if Env.setup.nil?

require_relative "modules/help"
require_relative "modules/auth"

module NoPhoneWeek
    class Main < Sinatra::Base
        before do                               # defualts
            content_type "application/json"     # JSON
        end

        get "/" do
          redirect "/pretty_help"
        end
        
        # Modules
        use NoPhoneWeek::HelpRoutes
        use NoPhoneWeek::AuthRoutes

        run!                                    # Start the server
    end
end

