module ImagesHelper
  def tag_images_count(images, tag)
    image_plural = pluralize(@images.length, 'image')
    haml_tag("p", "#{image_plural} with tag #{tag}")
  end
end
