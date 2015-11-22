define(['jquery', 'navbar'], function($, NavBar) {
  var showMenu;
  NavBar.setActive('story');
  if ($('.story>.header>.action').width()) {
    showMenu = $('.story>.header>.action');
    return showMenu.on('click', function() {
      var el;
      el = $('.story>.header .list');
      el.toggleClass('show');
      if (el.hasClass('show')) {
        showMenu.children('i').attr('class', 'fa fa-close');
        return el.css('opacity', '1');
      } else {
        showMenu.children('i').attr('class', 'fa fa-th-large');
        return el.css('opacity', '0');
      }
    });
  }
});
