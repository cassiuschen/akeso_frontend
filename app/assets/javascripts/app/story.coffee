define ['jquery','navbar'], ($, NavBar) ->
	NavBar.setActive 'story'
	if $('.story>.header>.action').width()
		showMenu = $('.story>.header>.action')
		showMenu.on 'click', ->
			el = $('.story>.header .list')
			el.toggleClass 'show'

			if el.hasClass 'show'
				showMenu.children('i').attr 'class', 'fa fa-close'
				el.css 'opacity', '1'
			else
				showMenu.children('i').attr 'class', 'fa fa-th-large'
				el.css 'opacity', '0'
