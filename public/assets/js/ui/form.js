define(['jquery'], function($) {
  return {
    formWarning: function(selector, text, callback) {
      var el;
      if (callback == null) {
        callback = (function() {});
      }
      el = $(selector);
      el.children('input').addClass('warning');
      el.children('.title').after("<div class=\"info\"><i class=\"fa fa-warning\"></i> " + text + "</div>");
      return el.children('input').bind('input propertychange', function() {
        el.children('input').removeClass('warning');
        $(selector + ">.title+.info").remove();
        try {
          callback.call(el);
        } catch (undefined) {}
        return el.children('input').unbind('input propertychange');
      });
    },
    validateInput: function(selector, validation, warning_text) {
      var el, value;
      if (validation == null) {
        validation = (function(th) {
          return true;
        });
      }
      if (warning_text == null) {
        warning_text = "信息填写有误，请重新输入！";
      }
      el = $(selector);
      value = el.val();
      if (!validation.call(value)) {
        el.addClass("warning");
        return el.after("<div class=\"info\"><i class=\"fa fa-warning\"></i> " + warning_text + "</div>");
      }
    },
    getWarn: function(selector, warning_text, callback) {
      var el;
      el = $(selector);
      el.addClass("warning");
      el.after("<div class=\"info\"><i class=\"fa fa-warning\"></i> " + warning_text + "</div>");
      return el.bind('input propertychange', function() {
        el.removeClass('warning');
        $(selector + "+.info").remove();
        try {
          callback.call(el);
        } catch (undefined) {}
        return el.unbind('input propertychange');
      });
    },
    actionBtn: function(settings) {
      var el;
      if (settings == null) {
        settings = {
          selector: '.button.action',
          onclick: (function() {}),
          onfinish: (function() {}),
          loadingText: "请稍后..."
        };
      }
      el = $(settings.selector);
      return el.on('click', function() {
        el.text = settings.loadingText;
        el.attr('disabled', 'true');
        try {
          settings.onclick.call(el);
        } catch (undefined) {}
        try {
          return settings.onfinish.call(el);
        } catch (undefined) {}
      });
    }
  };
});
