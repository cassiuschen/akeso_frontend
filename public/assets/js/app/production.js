define(['jquery', 'navbar'], function($, NavBar) {
  NavBar.setActive("production");
  return $('body').addClass('Index');
});
