define(['jquery'], function($) {
  return {
    setActive: function(str) {
      $(".items .item[data-active='" + str + "']").addClass('active');
      if ($('.items.underline').size()) {
        this.underline();
      }
      this.hoverMenu();
      console.log(document.width);
      if (document.width < 900) {
        this.mobileNavInit();
      }
      return window.onresize = this.setActive();
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
          if ($(this).hasClass('noLine') || $(this).hasClass('disabled')) {
            $line.css({
              left: itemLeft + spanPaddingLeft + margin,
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
    },
    hoverMenu: function() {
      var targetMenu;
      targetMenu = "first-init";
      $('.items.underline .item').on('mouseover', function(evt) {
        var onShowMenu;
        onShowMenu = targetMenu;
        targetMenu = $(this).data('menu') || "nil";
        if (onShowMenu === "first-init") {
          onShowMenu = targetMenu;
          $(".hover-menu#" + targetMenu).addClass('show');
        }
        if (targetMenu !== onShowMenu) {
          $(".hover-menu#" + onShowMenu).removeClass('show');
          if (targetMenu !== 'nil') {
            return $(".hover-menu#" + targetMenu).addClass('show');
          }
        }
      });
      return $('body').on('click', function() {
        return $('nav.navbar .hover-menu.show').removeClass('show');
      });
    },
    mobileNavInit: function() {
      return $('.mobile-menu-button').on('click', function() {
        if ($('.navbar-section').hasClass('showOnMobile')) {
          $('.navbar-section').removeClass('showOnMobile');
          return $('.mobile-menu-button .mask').css('height', 0).queue(function() {
            $('.navbar-section').css('opacity', 0);
            return $(this).dequeue();
          });
        } else {
          return $('.navbar-section').addClass('showOnMobile').queue(function() {
            $('.mobile-menu-button .mask').css('height', $('.navbar-section .items').height() + 10);
            return $(this).dequeue();
          }).queue(function() {
            $('.navbar-section').css('opacity', 1);
            return $(this).dequeue();
          });
        }
      });
    }
  };
});
