define ['jquery'], ($) ->
	setActive: (str) ->
		$(".items .item[data-active='#{str}']").addClass 'active'
		if $('.items.underline').size()
			@underline()

	underline: ->
		if $('.underline .animated-line').size()
			$line = $('.underline .animated-line')
			$active = $('.items.underline .item.active')
			itemLeft = $active.position().left
			spanPaddingLeft = 40
			width = $active.children().first().width()

			margin = 0

			$line.css
				left: itemLeft + spanPaddingLeft + margin
				width: width

			$('.items.underline .item').on 'mouseover', (evt) ->
				
				if $(this).hasClass 'noLine'
					$line.css
						left: spanPaddingLeft + margin
						width: width
				else
					$line.css
						left: $(this).position().left + spanPaddingLeft + margin
						width: $(this).children().first().width()
				return
			$('.items.underline .item').on 'mouseleave', (evt) ->
				$line.css
					left: itemLeft + spanPaddingLeft + margin
					width: width