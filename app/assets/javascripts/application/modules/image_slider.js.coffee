class Main.ImageSlider
  constructor: () ->
    @$container  = $('.slider-container')
    @$navigation = @$container.find('.navigation')

    @$nextButton = @$navigation.find('.arrow-right')
    @$prevButton = @$navigation.find('.arrow-left')

    @slideIndex = 1

  init: ->
    @renderSlide(@slideIndex)

    @$prevButton.on 'click', @nextSlide
    @$nextButton.on 'click', @nextSlide

  renderSlide: (slideIndex) ->
    slides = @$container.find('.slide')

    if (@slideIndex > slides.length)
      @slideIndex = 1

    if (@slideIndex < 1)
      @slideIndex = slides.length

    i = 0
    while i < slides.length
      slides[i].style.display = 'none'
      i++
    slides[@slideIndex - 1].style.display = 'block'

  nextSlide: =>
    nextSlideIndex = parseInt(event.target.dataset.slide_index)
    @renderSlide(@slideIndex += nextSlideIndex)