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
    content = Content.new(type: 'text/html', value:"
    <p><strong> Thank you for subscribing to our catalog! Below is a list of our products:</strong></p>
    <p>Cakes(price per cake):</p>
    <ul>
        <li>Cheesecake - $20</li>
        <li>Chocolate Cake - $25</li>
        <li>Vanilla Cake - $20</li>
        <li>Red Velvet Cake - $20</li>
        <li>Strawberry Shortcake - $20</li>
        <li>Carrot Cake - $18</li>
    </ul>
    <br>
    <p>Cookies(price per dozen)</p>
    <ul>
        <li>Snickerdoodle - $15</li>
        <li>Peanut Butter - $15</li>
        <li>White Chocolate - $10</li>
        <li>M&M - $15</li>
        <li>Caramel - $10</li>
        <li>Oatmeal - $15</li>
    </ul>
    <p>Muffins(price per dozen)</p>
    <ul>
        <li>Blueberry - $15</li>
        <li>Coffee Cake - $20</li>
        <li>Chocolate Chip - $15</li>
        <li>Bran - $20</li>
        <li>Double Chocolate - $20</li>
        <li>Cranberry - $15</li>
    </ul>
    ")
    mail = Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV["SENDGRID"])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    redirect "/"
end


