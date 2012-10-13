jQuery ->
  csrf_token = $('meta[name=csrf-token]').attr 'content'
  csrf_param = $('meta[name=csrf-param]').attr 'content'

  if csrf_param? && csrf_token?
    params = csrf_param + "=" + encodeURIComponent(csrf_token)

  $('.redactor').redactor {
    "imageUpload": "/admin/redactor_rails/pictures?" + params,
    "imageGetJson": "/admin/redactor_rails/pictures",
    "path": "/assets/redactor-rails",
    "css": "style.css"
  }
  # $('.fupload').each () ->
  #   obj_params = {
  #     assetable_id: $(this).data('assetable_id'),
  #     assetable_type: $(this).data('assetable_type')
  #   }
  #   url = $(this).data('url')

  #   new qq.FileUploader {
  #     element: this,
  #     action: url + '?' + params,
  #     debug: true,
  #     params: obj_params,
  #     uploadButtonText: 'Загрузить фотографии'
  #   }
