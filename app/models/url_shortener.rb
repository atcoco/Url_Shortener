class UrlShortener < ApplicationRecord
	def generate_shorten_url(pattern)
		password = Digest::SHA1.hexdigest(pattern)
  		url = password[rand(1..10)] + password[rand(1..10)] + password[rand(1..10)] + password[rand(1..10)] + password[rand(1..10)]
  		return url
 	end
 	def display_domain
  		return "localhost:3000"
 	end
end
