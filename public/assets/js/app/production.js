define(['jquery', 'navbar', 'modal', 'leancloud'], function($, NavBar, M, LC) {
  NavBar.setActive("home");
  $('body').addClass('Index');
  M.init();
  return window.LC = LC;
});
