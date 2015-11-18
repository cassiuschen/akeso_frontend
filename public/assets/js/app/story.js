define(['jquery', 'navbar'], function($, NavBar) {
  NavBar.setActive('story');
  return $('body').addClass('story');
});
