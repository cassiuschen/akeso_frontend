define ['jquery', 'navbar', 'modal'], ($, NavBar, M) ->
	NavBar.setActive("home")
	$('body').addClass 'Index'
	M.init()