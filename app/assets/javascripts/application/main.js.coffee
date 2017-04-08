$(document).ready ->
  # $('.search-input').autocomplete
  #   source: ['opt1', "opt2", 'opt3']

  if $(".edit_post").length
    $('form input[type="file"]').each ->
      new Main.ImagePreviewer($(@)).init()

  if $(".edit_user").length
    new Main.ImagePreviewer($('form input[type="file"]')).init()

  if $('.slider-container').length
    new Main.ImageSlider().init()

  $(document).bind 'click', ->
    if $('.new-message-container.expanded').length
      # if don't click inside new message form
      if event.target.offsetParent &&  event.target.offsetParent.className != 'new_message_form'
        $('.new-message-container').removeClass('expanded')