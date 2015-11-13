define ['jquery', 'navbar', 'pin'], ($, NavBar, pin) ->
	NavBar.setActive("production")
	$('body').addClass 'productionDetail'
	$(".detail-nav").pin
		containerSelector: ".page"