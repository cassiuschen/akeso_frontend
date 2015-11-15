define ['jquery', 'underscore'], ($, _) ->
	init: ->
		$('body').addClass 'orders new'
		@handleNextBtn()
		@handleColorSelect()

	handleNextBtn: ->
		that = @
		$('#next').on 'click', ->
			console.log 'click!'
			if $('#next').data('target') == "StepTwo"
				console.log 'toStepTwo'
				$('.step').removeClass 'onStepOne'
				$('.step').addClass "on#{$('#next').data 'target'}"
				$('#next').data 'target', 'StepOne'
				$(this).text '选择款式'
				height = $('#step-1').height()
				$('#step-1').hide()
				$(this).data 'layoutValue', $('.price').data('price')
				setTimeout ->
						$('#step-2')
							.removeClass 'hide'
							.fadeIn(600)
							.addClass 'show'
							that.selectionUI()
							#.css "-webkit-transform", "translateY(-#{height}px)"
							#.css "transform", "translateY(-#{height}px)"
					, 200
			else
				$('#step-1').show()
				$('#step-2')
					.fadeOut(600)
					.addClass 'hide'
					.removeClass 'show'
					#.css "-webkit-transform", "translateY(0)"
					#.css "transform", "translateY(0)"
				console.log 'toStepOne'
				$('.step').removeClass 'onStepTwo'
				$('.step').addClass "on#{$('#next').data 'target'}"
				$('#next').data 'target', 'StepTwo'
				$(this).text '填写信息'


				

	handleColorSelect: ->
		that = @
		$('.colors .color').on 'click', (el) ->
			$('.color').addClass 'mute'
			$('.color.selected').removeClass 'selected'
			$('#next').removeAttr 'disabled'
			$(this)
				.removeClass 'mute'
				.addClass 'selected'
			that.updatePrice $(@).data('price')
			type = $(@).parent().data 'type'
			$('.typeInput').text "已选款式：#{$(@).data 'name'}#{$(@).parent().data 'typename'}"
			$("##{type}").attr 'src', $(@).data('img')
			$("#preview").attr 'src', $(@).data('preview')

	selectionUI: ->
		that = @
		$('.selections .selection').on 'click', ->
			$('.selections input').val $(this).text()
			$('.selection.selected').removeClass 'selected'
			$(this).addClass 'selected'
			oldPrice = Number($('#next').data 'layoutValue')
			that.updatePrice(oldPrice + Number($(this).data 'value'))


			
	updatePrice: (newPrice) ->
		$('.price').data 'price', newPrice
		$('.price').html "<span>价格</span>￥#{newPrice}"
		$('.price').addClass 'priceChange'
		setTimeout ->
				$('.price').removeClass 'priceChange'
			, 800