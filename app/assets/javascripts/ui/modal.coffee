define ['jquery'], ($) ->
	class @UIModal
		constructor: (@element) ->

		show: ->
			el = $(@element)
			$('body')
				.append '<<div class="modal-dimmer"></div>>'
				.css 'overflow', 'hidden'
			el.addClass 'open'
			el.children(".close-btn").on 'click', ->
				$('.modal-dimmer')
					.fadeOut(1000)
					.remove()
				el.removeClass 'open'
				$('body').css 'overflow', 'auto'
		hidden: ->
			el = $(@element)
			el.removeClass 'open'
			$('body').css 'overflow', 'auto'


	@UIModal
		