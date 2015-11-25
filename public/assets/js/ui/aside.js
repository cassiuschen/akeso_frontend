define(["jquery"], function($) {
  return {
    init: function() {
      window.onhashchange = (function() {});
      this.parseURI();
      return this.handleClick();
    },
    parseURI: function() {
      var target;
      if (window.location.hash) {
        $('aside.sidenav .select.active').removeClass('active');
        $('aside.contents section').removeClass('show');
        target = window.location.hash.substr(1);
        $("aside.sidenav .select[data-target='" + target + "']").addClass('active');
        return $("aside.contents section#" + target).addClass('show');
      } else {
        $("aside.sidenav .select:first-child").addClass('active');
        return $("aside.contents section:first-child").addClass('show');
      }
    },
    handleClick: function() {
      return $('aside.sidenav a.select').on('click', function(el) {
        $('aside.contents section').removeClass('show');
        $('aside.sidenav .select.active').removeClass('active');
        $(this).addClass('active');
        $("aside.contents section#" + ($(this).data('target'))).addClass('show');
        window.location.hash = $(this).data('target');
        return window.scrollTo(0, 0);
      });
    }
  };
});
