define ['jquery','navbar'], ($, NavBar) ->
	NavBar.setActive 'story'
	if $('.story>.header>.action').width()
		showMenu = $('.story>.header>.action')
		showMenu.on 'click', ->
			el = $('.story>.header .list')
			el.toggleClass 'show'

			if el.hasClass 'show'
				showMenu.children('i').attr 'class', 'fa fa-close'
				showMenu.children('.mobile').children('i').attr 'class', 'fa fa-sort-up'
				el.css 'opacity', '1'
			else
				showMenu.children('i').attr 'class', 'fa fa-th-large'
				showMenu.children('.mobile').children('i').attr 'class', 'fa fa-sort-down'
				el.css 'opacity', '0'
