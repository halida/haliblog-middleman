(function() {
  var onResize;

  window.init = function() {
    init_pjax();
    $('select#color-select').change(function() {
      return $('body').attr('class', 'color-' + $(this).val());
    });
    window.registerScroll("#return-top-block");
    $(window).resize(onResize);
    return onResize();
  };

  onResize = function() {
    return $('#content').css('height', window.innerHeight - 30 - 72 - 20 - 20 + 'px');
  };

  window.init_pjax = function() {
    var error_func;
    error_func = function(xhr, err) {
      return $('.error').text('Something went wrong: ' + err);
    };
    $('.js-pjax').pjax('#content', {
      timeout: null,
      error: error_func
    });
    $('body').bind('start.pjax', function() {
      return $('#content').html('<div class="more"><img src="/ajax-loader.gif" id="more-display" /></div>');
    });
    return $('body').bind('end.pjax', function() {
      return $('body').scrollTop(0);
    });
  };

  window.registerScroll = function(object) {
    object = $(object);
    return $(window).scroll(function() {
      var bot, bottom, bottom_margin, normal_margin, top;
      top = $(this).scrollTop();
      if (top < 300) {
        bot = -130;
      } else {
        bottom = $(document).height() - $(window).height() - top;
        bottom_margin = 150;
        normal_margin = 50;
        if (bottom < (bottom_margin - normal_margin)) {
          bot = bottom_margin - bottom;
        } else {
          bot = normal_margin;
        }
      }
      return object.css("bottom", bot + 'px');
    });
  };

  window.more = function(from) {
    var loader, loc, _ref;
    loader = $('#resources.loader').clone();
    loader.attr('id', 'more-display');
    $('#activity-more').html(loader);
    loc = window.location + ((_ref = /\?/.test(window.location)) != null ? _ref : {
      "&": "?"
    }) + ("from=" + from + "&_pjax=true");
    return $.get(loc, function(data) {
      return $('#activity-more').replaceWith(data);
    });
  };

}).call(this);
