define ['jquery'], ($) ->
	validateInput: (selector, validation = ((th) -> return true), warning_text = "信息填写有误，请重新输入！") ->
		el = $(selector)
		value = el.val()
		if !validation.call(value)
			el.addClass "warning"
			el.after("<div class=\"info\"><i class=\"fa fa-warning\"></i> #{warning_text}</div>")

	getWarn: (selector, warning_text) ->
		el = $(selector)
		el.addClass "warning"
		el.after("<div class=\"info\"><i class=\"fa fa-warning\"></i> #{warning_text}</div>")