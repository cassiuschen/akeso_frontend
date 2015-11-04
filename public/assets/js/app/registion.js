define(['jquery', 'navbar', 'leancloud', 'form'], function($, NavBar, LC, UIForm) {
  $('body').addClass('users registion');
  try {
    NavBar.setActive('users');
  } catch (undefined) {}
  return window.UI = UIForm;
});
