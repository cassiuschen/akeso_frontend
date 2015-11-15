define(['jquery', 'underscore'], function($, _) {
  return {
    init: function() {
      $('body').addClass('orders new');
      this.handleNextBtn();
      return this.handleColorSelect();
    },
    handleNextBtn: function() {
      return $('#next').on('click', function() {
        console.log('click!');
        if ($('#next').data('target') === "StepTwo") {
          console.log('toStepTwo');
          $('.step').removeClass('onStepOne');
          $('.step').addClass("on" + ($('#next').data('target')));
          return $('#next').data('target', 'StepOne');
        } else {
          console.log('toStepOne');
          $('.step').removeClass('onStepTwo');
          $('.step').addClass("on" + ($('#next').data('target')));
          return $('#next').data('target', 'StepTwo');
        }
      });
    },
    handleColorSelect: function() {
      var that;
      that = this;
      return $('.colors .color').on('click', function(el) {
        var type;
        $('.color').addClass('mute');
        $('.color.selected').removeClass('selected');
        $(this).removeClass('mute').addClass('selected');
        that.updatePrice($(this).data('price'));
        type = $(this).parent().data('type');
        $("#" + type).attr('src', $(this).data('img'));
        return console.log($(this).data('img'));
      });
    },
    updatePrice: function(newPrice) {
      $('.price').data('price', newPrice);
      $('.price').html("<span>价格</span>￥" + newPrice);
      $('.price').addClass('priceChange');
      return setTimeout(function() {
        return $('.price').removeClass('priceChange');
      }, 800);
    }
  };
});
