define(["jquery"], function($) {
  return {
    init: function() {
      return $('aside.sidenav a.select').on('click', function(el) {
        $('aside.contents section').removeClass('show');
        $('aside.sidenav .select.active').removeClass('active');
        $(this).addClass('active');
        return $("aside.contents section#" + ($(this).data('target'))).addClass('show');
      });
    }
  };
});
