define ['jquery'], ($) ->
	setActive: (str) ->
		$(".items .item[data-active='#{str}']").addClass 'active'
		
		if $('.items.underline').size()
			@underline()
		@hoverMenu()
		console.log document.width
		if document.width < 900
			@mobileNavInit()
		window.onresize = @setActive()

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
				
				if $(this).hasClass('noLine') || $(this).hasClass('disabled')
					$line.css
						left: itemLeft + spanPaddingLeft + margin
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
	hoverMenu: ->
		targetMenu = "first-init"
		$('.items.underline .item').on 'mouseover', (evt) ->
			onShowMenu = targetMenu
			targetMenu = $(this).data('menu') || "nil"
			#console.log("Hover on #{$(this).children().first().text()}, target: #{targetMenu}, onShow: #{onShowMenu}")
			if onShowMenu == "first-init"
				onShowMenu = targetMenu
				$(".hover-menu##{targetMenu}").addClass 'show'
			if targetMenu != onShowMenu
				$(".hover-menu##{onShowMenu}").removeClass 'show'
				unless targetMenu == 'nil'
					$(".hover-menu##{targetMenu}").addClass 'show'
		$('body').on 'click', ->
			$('nav.navbar .hover-menu.show').removeClass 'show'

	mobileNavInit: ->
		$('.mobile-menu-button').on 'click', ->
			if $('.navbar-section').hasClass 'showOnMobile'
				$('.navbar-section').removeClass 'showOnMobile'
				$('.mobile-menu-button .mask')
					.css 'height', 0
					.queue ->
						$('.navbar-section').css 'opacity', 0
						$(@).dequeue()
			else
				$('.navbar-section')
					.addClass 'showOnMobile'
					.queue ->
						$('.mobile-menu-button .mask')
							.css 'height', $('.navbar-section .items').height() + 10
						$(@).dequeue()
					.queue ->
						$('.navbar-section').css 'opacity', 1
						$(@).dequeue()

