define ["jquery"], ($) ->
	init: ->
		window.onhashchange = (->)
		@parseURI()
		@handleClick()
	
	parseURI: ->
		if window.location.hash
			$('aside.sidenav .select.active').removeClass 'active'
			$('aside.contents section').removeClass 'show'
			target = window.location.hash.substr(1)
			$("aside.sidenav .select[data-target='#{target}']").addClass 'active'
			$("aside.contents section##{target}").addClass 'show'
		else
			$("aside.sidenav .select:first-child").addClass 'active'
			$("aside.contents section:first-child").addClass 'show'
	handleClick: ->
		$('aside.sidenav a.select').on 'click', (el) ->
			$('aside.contents section').removeClass 'show'
			$('aside.sidenav .select.active').removeClass 'active'
			$(@).addClass 'active'
			$("aside.contents section##{$(@).data 'target'}").addClass 'show'
			window.location.hash = $(@).data 'target'
			window.scrollTo(0,0)