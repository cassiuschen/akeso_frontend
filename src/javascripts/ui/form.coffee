define ['jquery'], ($) ->
	validateInput: (selector, validation = ((th) -> return true), warning_text = "信息填写有误，请重新输入！") ->
		el = $(selector)
		value = el.val()
		if !validation.call(value)
			el.addClass "warning"
			el.after("<div class=\"info\"><i class=\"fa fa-warning\"></i> #{warning_text}</div>")

	getWarn: (selector, warning_text, callback) ->
		el = $(selector)
		el.addClass "warning"
		el.after("<div class=\"info\"><i class=\"fa fa-warning\"></i> #{warning_text}</div>")
		el.bind 'input propertychange', ->
			el.removeClass 'warning'
			$("#{selector}+.info").remove()
			try
				callback.call(el)
			el.unbind 'input propertychange'

	actionBtn: (settings = {
			selector: '.button.action'
			onclick: (->)
			onfinish: (->)
			loadingText: "请稍后..."
		}) ->
		el = $(settings.selector)
		el.on 'click', ->
			el.text = settings.loadingText
			el.attr 'disabled', 'true'
			try
				settings.onclick.call(el)
			try
				settings.onfinish.call(el)
			



