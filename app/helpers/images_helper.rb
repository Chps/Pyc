module ImagesHelper
  def tag_images_count(images, tag)
    image_plural = pluralize(@images.length, 'image')
    haml_tag("p", "#{image_plural} with tag #{tag}")
  end

  def download_link(image)
    link_to(
      "Download",
      download_image_path(image),
      target: '_blank',
      class:  'btn btn-primary'
    )
  end
end
