require "sinatra/base"

require_relative "../lib/user_funcs"

module NoPhoneWeek
  class UserRoutes < Sinatra::Base
    @@user_funcs = UserFuncs.new()

    get "/users" do
      # FIXME: What we really want here is a function in user_funcs that queries the db directly so that we don't have to load the whole table just for a few users
      Oj.dump(
        @@user_funcs.load_all.select do |user|
          good = true
          params.each do |key, value|
            if user[key].to_s != value.to_s
              good = false
            end
          end
          good
        end
      )
    end
  end
end

