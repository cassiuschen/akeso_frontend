define(['jquery', 'navbar', 'pin', 'onePage'], function($, NavBar, pin, onePage) {
  NavBar.setActive("production");
  $('body').addClass('productionDetail');
  return $(".detail-nav").pin({
    containerSelector: ".page"
  });
});
