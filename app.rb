require 'sinatra'
require 'sinatra/reloader'
require 'sendgrid-ruby'
include SendGrid

from = Email.new(email: 'minhal.gardezi@gmail.com')
to = Email.new(email: 'minhal.gardezi@gmail.com')


get "/" do
    erb :index
end

post "/" do
    puts params[:comment]
    puts ENV["SENDGRID"]
    subject = 'Comment From ' + params[:name]
    content = Content.new(type: 'text/plain', value: params[:comment])
    mail = Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV["SENDGRID"])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    redirect "/"
end


