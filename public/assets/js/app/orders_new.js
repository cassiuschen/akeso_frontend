define(['jquery', 'underscore', 'form'], function($, _, UIForm) {
  return {
    init: function() {
      $('body').addClass('orders new');
      this.handleNextBtn();
      this.handleColorSelect();
      return window.UI = this;
    },
    handleNextBtn: function() {
      var that;
      that = this;
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
          $(this).data('layoutValue', $('.price').data('price'));
          return setTimeout(function() {
            $('#step-2').removeClass('hide').fadeIn(600).addClass('show');
            that.selectionUI();
            return $('#sendCode').on('click', function() {
              return that.sendSMS();
            });
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
        $('.typeInput').data('type', $(this).parent().data('typename'));
        $('.typeInput').data('color', $(this).data('name'));
        $("#" + type).attr('src', $(this).data('img'));
        return $("#preview").attr('src', $(this).data('preview'));
      });
    },
    selectionUI: function() {
      var that;
      that = this;
      return $('.selections .selection').on('click', function() {
        var oldPrice;
        $('.selections input').val($(this).text());
        $('.selection.selected').removeClass('selected');
        $(this).addClass('selected');
        oldPrice = Number($('#next').data('layoutValue'));
        return that.updatePrice(oldPrice + Number($(this).data('value')));
      });
    },
    updatePrice: function(newPrice) {
      $('.price').data('price', newPrice);
      $('.price').html("<span>价格</span>￥" + newPrice);
      $('.price').addClass('priceChange');
      return setTimeout(function() {
        return $('.price').removeClass('priceChange');
      }, 800);
    },
    sendSMS: function() {
      var mobile, result, that;
      that = this;
      $('#sendCode').attr('disabled', 'disabled');
      mobile = $('input#mobile').val();
      result = {};
      return $.ajax({
        type: 'GET',
        url: "/leancloud/sendSMS/" + mobile,
        params: {
          mobile: mobile
        },
        data: {
          mobile: mobile
        },
        contentType: "application/json",
        dataType: "json",
        async: false,
        success: function(data, _) {
          result = data;
          console.log(result.message);
          if (result.status === 200) {
            $('#submit').removeAttr('disabled');
            return $('#submit').on('click', function() {
              return that.submit();
            });
          } else {
            return UIForm.getWarn('input#mobile', "手机号似乎有点问题哦，请重新填写。", function(el) {
              return $('#sendCode').removeAttr('disabled');
            });
          }
        }
      });
    },
    getFormData: function() {
      var data;
      data = {};
      data.username = $('input#name').val();
      data.smsCode = $('input#code').val();
      data.mobilePhoneNumber = $('input#mobile').val();
      data.email = $('input#email').val();
      data.orders = {
        type: $('.typeInput').data('type'),
        color: $('.typeInput').data('color'),
        glass: $('input#glass').val()
      };
      return data;
    },
    submit: function() {
      var that;
      that = this;
      return $.ajax({
        type: 'POST',
        url: "/orders",
        params: that.getFormData(),
        data: that.getFormData(),
        contentType: "application/json",
        dataType: "json",
        async: false,
        success: function(data, _) {
          return alert(data.message);
        }
      });
    }
  };
});
