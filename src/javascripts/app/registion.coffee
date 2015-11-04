define ['jquery', 'navbar', 'leancloud', 'form'], ($, NavBar, LC, UIForm) ->
	$('body').addClass 'users registion'
	try
		NavBar.setActive 'users'
	window.UI = UIForm



