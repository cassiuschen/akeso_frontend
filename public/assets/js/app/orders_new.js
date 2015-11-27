define(['jquery', 'underscore', 'form', 'navbar'], function($, _, UIForm, NavBar) {
  return {
    init: function() {
      NavBar.setActive('production');
      this.handleTypeSelect();
      window.UI = this;
      window.totalPrice = 0;
      return window.formData = {};
    },
    handleStep2Init: function() {
      var that;
      that = this;
      return $('#nextToStep2').on('click', function() {
        var height;
        console.log('click!');
        if ($('#nextToStep2').data('target') === "StepTwo") {
          console.log('toStepTwo');
          $('.step').removeClass('onStepOne');
          $('.step').addClass("on" + ($('#nextToStep2').data('target')));
          $('#nextToStep2').data('target', 'StepOne');
          $(this).html('<i class="fa fa-angle-left"> 选择款式');
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
          $('.step').addClass("on" + ($('#nextToStep2').data('target')));
          $('#nextToStep2').data('target', 'StepTwo');
          return $(this).html('填写信息 <i class="fa fa-angle-right">');
        }
      });
    },
    handleTypeSelect: function() {
      var that;
      that = this;
      return $('.type').on('click', function(el) {
        var type;
        $('.type').addClass('mute');
        $('.type.selected').removeClass('selected');
        $('#nextToStep2').removeAttr('disabled');
        $(this).removeClass('mute').addClass('selected');
        that.updatePrice($(this).data('price'));
        type = $(this).data('type');
        window.formData.type = type;
        return $('#nextToStep2').attr('href', "/orders/new/" + type);
      });
    },
    selectionUI: function() {
      var that;
      that = this;
      return $('.selections .selection').on('click', function() {
        var oldPrice, rawType;
        $('.selections input').val($(this).text());
        $('.selection.selected').removeClass('selected');
        $(this).addClass('selected');
        oldPrice = Number($('#nextToStep2').data('layoutValue'));
        that.updatePrice(oldPrice + Number($(this).data('value')));
        rawType = "" + ($('.colors .color.selected').data('name')) + ($('.colors .color.selected').parent().data('typename'));
        if ($(this).data('value') !== 0) {
          rawType += " + " + $(this).text();
          $('.des').addClass('show');
        } else {
          $('.des').removeClass('show');
        }
        return $('.typeInput').text(rawType);
      });
    },
    updatePrice: function(newPrice) {
      window.totalPrice = newPrice;
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
        glass: $('input#glass').val(),
        province: $('input#province').val()
      };
      return data;
    },
    submit: function() {
      var that;
      that = this;
      console.log(this.getFormData());
      return $.ajax({
        type: 'POST',
        url: "/orders",
        params: that.getFormData(),
        data: JSON.stringify(that.getFormData()),
        contentType: "application/json",
        dataType: "json",
        success: function(data, _) {
          return window.location = '/orders/success';
        },
        error: function(err) {
          return console.log(err);
        }
      });
    }
  };
});
