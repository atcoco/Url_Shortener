class UrlShortenersController < ApplicationController
	def index		
		@urls = UrlShortener.all
		@domain = @urls.first.display_domain
	end

	def show
		m_url = params[:shorten]
		#if url is not a shorten URL, root page is loaded.
		if m_url == ""
			redirect_to new_url_shortener_url
		end

		@url = UrlShortener.find_by(temp_url: m_url)
		redirect_to @url.url
	end

	def new
		@inputurl = UrlShortener.new
	end

	def create
		m_url = url_params[:input_url]
		@url = UrlShortener.new

		@url.url = m_url
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
