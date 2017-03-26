class Main.ImagePreviewer
  constructor: ($el) ->
    @$uploadInput = $el
    @$previewImg  = @$uploadInput.parent().find('.image-preview-wrapper img')

  init: ->
    @$uploadInput.on 'change', @renderPreviewImage

  renderPreviewImage: =>
    reader        = new FileReader()
    previewImage  = @$previewImg

    # get loaded data and render thumbnail.
    reader.onload = (event) ->
      previewImage.attr('src', event.target.result)
      previewImage.css("width", "250px")

    # read the image file as a data URL.
    reader.readAsDataURL(event.target.files[0])