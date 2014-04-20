class HomeController < ApplicationController
  def index
    hide_breadcrumbs = true
    @images = Image.all
    @hits = Impression.count('id')
  end
end
