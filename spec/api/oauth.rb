require 'oauth2'
client_id = "1d4777bc9655a23577c9b48f6cafb9434a0f5ada3eb00b5aa8c3de4d381cfeb5"
client_secret = "4b834ec0000156dff884c9d8f5c6d7b468caabaf2571ddb53c0b37be0f241548"
redirect_uri = "urn:ietf:wg:oauth:2.0:oob"
site = "http://localhost:8088"

client = OAuth2::Client.new(client_id, client_secret, :site => site)
# authorize_url = client.auth_code.authorize_url(:redirect_uri => redirect_uri)
# puts authorize_url
code = "c1919994ff89b0334ff23e2565e88ce0a61f5531c5294f0d5d5b1c53408545a9" # 从浏览器得到的
access_token = client.auth_code.get_token(code, :redirect_uri => redirect_uri)
puts access_token.token
response = access_token.get('/api/v1/articles.json')
puts JSON.parse(response.body)
