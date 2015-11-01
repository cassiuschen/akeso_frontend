define(['jquery', 'navbar', 'modal'], function($, NavBar, M) {
  NavBar.setActive("home");
  $('body').addClass('Index');
  return M.init();
});
