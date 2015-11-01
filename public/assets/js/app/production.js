define(['jquery', 'navbar'], function($, NavBar) {
  NavBar.setActive("home");
  return $('body').addClass('Index');
});
