/* For drag and drop */
$(function () {
  $('#global-form').fileupload({
    uploadTemplateId: null,
    downloadTemplateId: null,
    add: function(e, data) {
      data.submit();
    },
    done: function(e, data) {
      window.location = data.result.url + '/edit';
    }
  });
});

/* For upload button */
$(function() {
  $('#upload-btn').click(function() {
    $('#image_content').click();
  });
});

$(function() {
  $('#image_content').change(function() {
    $('#global_form').submit();
  });
});
