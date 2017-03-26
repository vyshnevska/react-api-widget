$(document).ready ->

  if $(".edit_post").length
    $('form input[type="file"]').each ->
      new Main.ImagePreviewer($(@)).init()