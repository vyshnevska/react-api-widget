$(document).ready ->

  if $(".edit_post").length
    $('form input[type="file"]').each ->
      new Main.ImagePreviewer($(@)).init()

  if $(".edit_user").length
    new Main.ImagePreviewer($('form input[type="file"]')).init()

  if $('.slider-container').length
    new Main.ImageSlider().init()