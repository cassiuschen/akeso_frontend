define(['jquery'], function($) {
  return {
    setActive: function(str) {
      $(".items .item[data-active='" + str + "']").addClass('active');
      if ($('.items.underline').size()) {
        return this.underline();
      }
    },
    underline: function() {
      var $active, $line, itemLeft, margin, spanPaddingLeft, width;
      if ($('.underline .animated-line').size()) {
        $line = $('.underline .animated-line');
        $active = $('.items.underline .item.active');
        itemLeft = $active.position().left;
        spanPaddingLeft = 40;
        width = $active.children().first().width();
        margin = 0;
        $line.css({
          left: itemLeft + spanPaddingLeft + margin,
          width: width
        });
        $('.items.underline .item').on('mouseover', function(evt) {
          if ($(this).hasClass('noLine')) {
            $line.css({
              left: spanPaddingLeft + margin,
              width: width
            });
          } else {
            $line.css({
              left: $(this).position().left + spanPaddingLeft + margin,
              width: $(this).children().first().width()
            });
          }
        });
        return $('.items.underline .item').on('mouseleave', function(evt) {
          return $line.css({
            left: itemLeft + spanPaddingLeft + margin,
            width: width
          });
        });
      }
    }
  };
});
