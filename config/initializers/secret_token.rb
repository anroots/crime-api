# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
MyApp::Application.config.secret_token = if Rails.env.development? or Rails.env.test?
                                           'aa79975ceac09291266d0949ba4e9301c73adbd3435160d5ac66b576d348eadc275468dd5b4408227e37008f89dd9c36e901514393ee0f30a134367f27f0ddda'
                                         else
                                           ENV['SECRET_TOKEN']
                                         end