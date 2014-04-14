class HomeController < ApplicationController
  def index
    @images = Image.all
	@hits = Impression.count('id')
  end
end
