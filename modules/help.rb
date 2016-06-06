require "sinatra/base"
require "oj"


module NoPhoneWeek
  class HelpRoutes < Sinatra::Base
    help = {
      modules: [
        {
          name: "Auth",
          routes: ["/auth", "/authform"],
          description: "The authentication service",
          actions: [
            {
              URL: "/auth",
              method: "POST",
              input: "username, password",
              output: "{\"success\": bool, message: \"message\": \"Invalid credentials\"/\"Authentication successful\"[, token: JWT string]}",
            }, {
              URL: "/authform",
              method: "GET",
              input: "none",
              output: "A form for testing the auth class"
            }
          ]
        }, {
          name: "Help",
          routes: ["/help[/module]", "/pretty_help[/module]"],
          description: "API help page",
          actions: [
            {
              URL: "/help",
              method: "GET",
              input: "none",
              output: "A JSON string of the API docs"
            }, {
              URL: "/help/module",
              method: "GET",
              input: "module",
              output: "A JSON string of the API docs of the specified module"
            }, {
              URL: "/pretty_help",
              method: "GET",
              input: "none",
              output: "A HTML page of the API docs"
            }, {
              URL: "/pretty_help/module",
              method:"GET",
              input: "module",
              output: "A HTML page of the API docs of the specified module"
            }
          ]
        }
      ]
    }
    
    get "/help" do
      Oj.dump(help)
    end

    get "/help/:module" do
      Oj.dump(help[:modules].select do |m| m[:name] == params[:module] end)
    end
    
    get "/help/" do redirect "/help" end
    get "/pretty_help/" do redirect "/pretty_help" end

    get "/pretty_help" do
      content_type "text/html"
      result = "<h1>Modules:</h1>"
      help[:modules].each do |m|
        result = result + "<h2>#{m[:name]}</h2><p>#{m[:description]}</p>Actions:"\
                        + "<code><table cellpadding=5><tr><td>URL</td><td>Method</td><td>Input</td><td>Output</td></tr>"
        m[:actions].each do |a|
          result = result + "<tr><td>#{a[:URL]}</td><td>#{a[:method]}</td><td>#{a[:input]}</td><td>#{a[:output]}</td></tr>"
        end
        result = result + "</table></code>"
      end
      result
    end

    get "/pretty_help/:module" do
      content_type "text/html"
      selected = (help[:modules].select do |m| m[:name] == params[:module] end)[0]
      return "<h1> Module not found! </h1>" if selected.nil?
      result =  "<h1>#{selected[:name]}</h1><p>#{selected[:description]}</p>Actions:"\
              + "<code><table cellpadding=5><tr><td>URL</td><td>Method</td><td>Input</td><td>Output</td></tr>"
      selected[:actions].each do |a|
          result = result + "<tr><td>#{a[:URL]}</td><td>#{a[:method]}</td><td>#{a[:input]}</td><td>#{a[:output]}</td></tr>"
      end
      return result
    end
  end
end

