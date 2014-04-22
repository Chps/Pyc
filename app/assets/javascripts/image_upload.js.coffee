ready = ->
  # For drag and drop
  $('#global-form').fileupload
    uploadTemplateId: null,
    downloadTemplateId: null,
    add: (e, data) ->
      data.submit();
      $('#progress-hull').css('display', 'block')
    progress: (e, data) ->
      progress = parseInt( (data.loaded / data.total) * 100, 10)
      $('#progress-bar').css('width', progress + '%')
    done: (e, data) ->
      window.location = data.result.url + '/edit';

  # For upload button
  $('#upload-btn').click ->
    $('#image_content').click();

  $('#image_content').change ->
      $('#global_form').submit();

$(document).ready(ready)
$(document).on('page:load', ready)
