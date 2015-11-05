define(['jquery'], function($) {
  return {
    init: function() {
      return $('.has-modal').on('click', function(evt) {
        var body, closeBtn, customCloseBtn, target, targetName;
        targetName = $(this).data('modal');
        target = $(".modal#" + targetName);
        closeBtn = $(".modal#" + targetName + ">.close");
        customCloseBtn = $(".modal#" + targetName + " *[data-close-modal='true']");
        body = $('body');
        target.fadeIn(400).addClass('open');
        body.css({
          "overflow": "hidden"
        });
        closeBtn.on('click', function() {
          target.fadeOut(600, function() {
            return target.removeClass('open');
          });
          return body.css({
            "overflow": "auto"
          });
        });
        return customCloseBtn.on('click', function() {
          target.fadeOut(600, function() {
            return target.removeClass('open');
          });
          return body.css({
            "overflow": "auto"
          });
        });
      });
    }
  };
});
