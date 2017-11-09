class UrlShortenersController < ApplicationController
	def index
		@urls = UrlShortener.all
	end

	def show
		m_url = params[:shorten]
		#if url is not a shorten URL, root page is loaded.
		if m_url == ""
			redirect_to new_url_shortener_url
		end

		prefix = ""
		# get https or http
		if m_url.include? "https://"
			prefix = "https://"
		elsif m_url.include? "http://"
			prefix = "http://"
		end

		m_url = m_url.remove(prefix)
		# get main domain
		m_main_domain = m_url.split("/")[0]
		#get url
		m_url = m_url.remove( m_main_domain + "/" )
		@url = UrlShortener.find_by(temp_url: m_url)

		redirect_to @url.url
	end

	def new
		@inputurl = UrlShortener.new
	end

	def create

		@url = UrlShortener.new

		@url.url = url_params[:input_url]
		# we can set Server Name after project is deployed to AWS or Heroku. First we will use 'localhost:3000/' 
		domain = "localhost:3000"
		@url.main_domain = domain
		# generate short url
		pattern = url_params[:input_url]		
		shorten_url = @url.generate_shorten_url(pattern)

		#check if this shorten url was already generated.
		begin
			shorten_url = @url.generate_shorten_url(pattern)
		end while UrlShortener.exists?(temp_url: shorten_url)

		@url.temp_url = shorten_url

		if @url.save()
			redirect_to url_shorteners_url
		else
			redirect_to new_url_shortener_url
		end			
	end

	private
	def url_params
		params.require(:url_shortener).permit(:input_url)
	end

end
