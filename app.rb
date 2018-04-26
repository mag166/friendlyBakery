require 'sinatra'
require 'sinatra/reloader'
require 'sendgrid-ruby'
include SendGrid




get "/" do
    erb :index
end

get "/cakes" do
    erb :cakes
end

get "/cookies" do
    erb :cookies
end

get "/muffins" do
    erb :muffins
end

post "/" do
    from = Email.new(email: 'minhal@bakery.com')
    to = Email.new(email: params[:email])
    puts params[:comment]
    puts ENV["SENDGRID"]
    subject = 'Bakery Catalog for ' + params[:name]
    content = Content.new(type: 'text/html', value:"hello<br>goodbye" )
    mail = Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV["SENDGRID"])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    redirect "/"
end


