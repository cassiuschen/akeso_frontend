define ['jquery'], ($) ->
	init: ->
		$('.has-modal').on 'click', (evt) ->
			targetName = $(this).data 'modal'
			target = $(".modal##{targetName}")
			closeBtn = $(".modal##{targetName}>.close")
			body = $('body')
			target
				.fadeIn 400
				.addClass 'open'
			body.css
				"overflow": "hidden"
			closeBtn.on 'click', ->
				target
					.fadeOut 600, ->
						target.removeClass 'open'
				body.css
					"overflow": "auto"