class HomeController < ApplicationController
  def index
    hide_breadcrumbs = true
   #@images = Image.all
	@images = Image.paginate(:page => params[:page], :per_page => 10)
    @hits = Impression.count('id')

  end
end
