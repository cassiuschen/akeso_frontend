define ['jquery','navbar'], ($, NavBar) ->
	NavBar.setActive 'story'
	$('body').addClass 'story'