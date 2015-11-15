define ['jquery', 'underscore'], ($, _) ->
	init: ->
		$('body').addClass 'orders new'
		@handleNextBtn()
		@handleColorSelect()

	handleNextBtn: ->
		$('#next').on 'click', ->
			console.log 'click!'
			if $('#next').data('target') == "StepTwo"
				console.log 'toStepTwo'
				$('.step').removeClass 'onStepOne'
				$('.step').addClass "on#{$('#next').data 'target'}"
				$('#next').data 'target', 'StepOne'
			else
				console.log 'toStepOne'
				$('.step').removeClass 'onStepTwo'
				$('.step').addClass "on#{$('#next').data 'target'}"
				$('#next').data 'target', 'StepTwo'

	handleColorSelect: ->
		that = @
		$('.colors .color').on 'click', (el) ->
			$('.color').addClass 'mute'
			$('.color.selected').removeClass 'selected'
			$(this)
				.removeClass 'mute'
				.addClass 'selected'
			that.updatePrice $(@).data('price')
			type = $(@).parent().data 'type'
			$("##{type}").attr 'src', $(@).data('img')
			console.log $(@).data('img')

			
	updatePrice: (newPrice) ->
		$('.price').data 'price', newPrice
		$('.price').html "<span>价格</span>￥#{newPrice}"
		$('.price').addClass 'priceChange'
		setTimeout ->
				$('.price').removeClass 'priceChange'
			, 800