define ['jquery', 'navbar', 'modal', 'leancloud'], ($, NavBar, M, LC) ->
	NavBar.setActive("home")
	$('body').addClass 'Index'
	M.init()
	window.LC = LC