define(['jquery'], function($) {
  return {
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
    getWarn: function(selector, warning_text) {
      var el;
      el = $(selector);
      el.addClass("warning");
      return el.after("<div class=\"info\"><i class=\"fa fa-warning\"></i> " + warning_text + "</div>");
    }
  };
});
