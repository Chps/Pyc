$(function () {
  $('#new_image').fileupload({
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
