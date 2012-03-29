window.init = ()->
  init_pjax()
  $('select#color-select').change ()->
    $('body').attr('class', 'color-'+$(this).val())
  window.registerScroll("#return-top-block")

  $(window).resize onResize
  onResize()

onResize = ()->
  $('#content').css('height', window.innerHeight - 30 - 72 - 20 - 20 + 'px')

window.init_pjax = ()->
  error_func = (xhr, err)-> $('.error').text('Something went wrong: ' + err)
  $('.js-pjax').pjax '#content', {timeout: null, error: error_func}
  $('body').bind 'start.pjax', ()-> $('#content').html('<div class="more"><img src="/ajax-loader.gif" id="more-display" /></div>')
  $('body').bind 'end.pjax'  , ()-> $('body').scrollTop(0)

# scroll
window.registerScroll = (object)->
  object = $(object)
  $(window).scroll ()->
    top = $(this).scrollTop()

    if (top < 300)
      bot = -130
    else
      bottom = $(document).height() - $(window).height() - top
      bottom_margin = 150
      normal_margin = 50
      if (bottom < (bottom_margin - normal_margin))
        bot = bottom_margin - bottom
      else
        bot = normal_margin

    object.css("bottom", bot + 'px')

window.more = (from)->
    loader = $('#resources.loader').clone()
    loader.attr('id', 'more-display')
    $('#activity-more').html(loader)
    loc = window.location + (/\?/.test(window.location) ? "&" : "?") + "from=#{from}&_pjax=true"
    $.get loc, (data)->
        $('#activity-more').replaceWith(data);


