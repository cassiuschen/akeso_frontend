define(['jquery', 'underscore'], function($, _) {
  return {
    init: function() {
      $('body').addClass('orders new');
      this.handleNextBtn();
      return this.handleColorSelect();
    },
    handleNextBtn: function() {
      return $('#next').on('click', function() {
        var height;
        console.log('click!');
        if ($('#next').data('target') === "StepTwo") {
          console.log('toStepTwo');
          $('.step').removeClass('onStepOne');
          $('.step').addClass("on" + ($('#next').data('target')));
          $('#next').data('target', 'StepOne');
          $(this).text('选择款式');
          height = $('#step-1').height();
          $('#step-1').hide();
          return setTimeout(function() {
            return $('#step-2').removeClass('hide').fadeIn(600).addClass('show');
          }, 200);
        } else {
          $('#step-1').show();
          $('#step-2').fadeOut(600).addClass('hide').removeClass('show');
          console.log('toStepOne');
          $('.step').removeClass('onStepTwo');
          $('.step').addClass("on" + ($('#next').data('target')));
          $('#next').data('target', 'StepTwo');
          return $(this).text('填写信息');
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
        $('#next').removeAttr('disabled');
        $(this).removeClass('mute').addClass('selected');
        that.updatePrice($(this).data('price'));
        type = $(this).parent().data('type');
        $('.typeInput').text("已选款式：" + ($(this).data('name')) + ($(this).parent().data('typename')));
        $("#" + type).attr('src', $(this).data('img'));
        return $("#preview").attr('src', $(this).data('preview'));
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
