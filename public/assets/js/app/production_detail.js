define(['jquery', 'navbar', 'pin'], function($, NavBar, pin) {
  NavBar.setActive("production");
  $('body').addClass('productionDetail');
  return $(".detail-nav").pin({
    containerSelector: ".page"
  });
});
