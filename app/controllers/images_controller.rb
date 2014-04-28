class ImagesController < ApplicationController
  require 'will_paginate/array'
  include StatisticsHelper

  before_action :set_image, except: [:index, :create]
  before_filter :user_must_be_signed_in, except: [:index, :download, :show]
  before_filter(
    :image_user_must_be_current_user,
    except: [:index, :show, :download]
  )

  impressionist actions: [:show] #, unique: [:session_hash]

  # GET /images
  # GET /images.json
  def index
    @hits = Impression.image_impressions.count
    if params[:tag]
      @images = Image.tagged_with(params[:tag])
    elsif params[:image_caption]
      @images = Image.search(params[:image_caption])
    else
      @images = Image.all
    end
    @images = @images.sort_by!(&:impressionist_count).reverse.paginate(page: params[:page], per_page: 10)
  end

  # GET /images/1
  # GET /images/1.json
  def show
    @user = User.find(@image.user_id)
    @comments = @image.comments.paginate(page: params[:page])
    @comment = Comment.new
  end

  # GET /images/1/edit
  def edit
  end

  # POST /images
  # POST /images.json
  def create
    @image = Image.new(image_params)
    puts current_user if user_signed_in?
    @image.user = current_user if user_signed_in?
    respond_to do |format|
      if @image.save
        format.json { render json: { url: image_path(@image) } }
      else
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /images/1
  # PATCH/PUT /images/1.json
  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to images_url }
      format.json { head :no_content }
    end
  end

  def download
    send_data(
      open(@image.content.url).read,
      filename: @image.content_file_name,
      type:     @image.content_content_type
    )
  end

  def statistics
    options = { width: 500, height: 200, is3D: true }

    @visits_chart = visits_line_chart(@image.visits_by_day, options)
    @country_pie_chart = country_pie_chart(@image.visits_by_country, options)
    @age_pie_chart = age_pie_chart(@image.visits_by_age, options)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:image).permit(:caption, :content_file_name, :content, :tag_list)
    end
end
