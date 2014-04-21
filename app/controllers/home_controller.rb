class HomeController < ApplicationController
  def index
   
   #@images = Image.all
	@images = Image.paginate(:page => params[:page], :per_page => 10)

    @hits = Impression.count('id')

  end
end
