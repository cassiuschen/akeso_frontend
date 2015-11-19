define(['jquery', 'navbar', 'pin', 'onePage'], function($, NavBar, pin, onePage) {
  NavBar.setActive("production");
  return $(".detail-nav").pin({
    containerSelector: ".page"
  });
});
