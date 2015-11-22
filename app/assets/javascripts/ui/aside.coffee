define ["jquery"], ($) ->
	init: ->
		$('aside.sidenav a.select').on 'click', (el) ->
			$('aside.contents section').removeClass 'show'
			$('aside.sidenav .select.active').removeClass 'active'
			$(@).addClass 'active'
			$("aside.contents section##{$(@).data 'target'}").addClass 'show'