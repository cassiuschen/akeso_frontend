define(['jquery', 'underscore', 'form', 'navbar', 'modal'], function($, _, UIForm, NavBar, UIModal) {
  return {
    init: function() {
      var submit, that;
      NavBar.setActive('production');
      window.formData = {};
      window.formData.type = $(".gt").data('type');
      window.formData.totalPrice = Number($('#total').text());
      window.formData.originPrice = Number($('#total').text());
      that = this;
      window.app = this;
      this.handleSelectGlass();
      this.handleSelectColor();
      submit = new UIModal("#info-modal");
      $(".submit").on('click', function() {
        return submit.show();
      });
      return $('#sendCode').on('click', function() {
        return that.sendSMS();
      });
    },
    handleSelectGlass: function() {
      var that;
      that = this;
      return $('.glass').on('click', function(el) {
        var message;
        $('.glass').removeClass('selected');
        $(this).addClass('selected');
        $('.glasses>.message').remove();
        if (Number($(this).data('price')) > 0) {
          message = '<div class="message"><red>* </red>如果您的近视度数超过800或者散光度数超过200，需要单独定制镜片，价格会有变更，需要您联系我们的<a href="http://weibo.com/akesoeyecare">官方微博</a></div>';
          $(this).after(message);
        }
        window.formData.glass = $(this).children(".name").text();
        window.formData.totalPrice = window.formData.originPrice + Number($(this).data('price'));
        return that.updateTotalPrice();
      });
    },
    handleSelectColor: function() {
      var that;
      that = this;
      return $('.color').on('click', function(el) {
        $('.color').removeClass('selected').addClass('mute');
        $(this).removeClass('mute').addClass('selected');
        $('.submit').removeAttr('disabled');
        window.formData.color = $(this).text();
        return $("#colorImg").attr('src', $(this).data('img'));
      });
    },
    updateTotalPrice: function() {
      return $('#total').text(window.formData.totalPrice);
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
    getData: function() {
      var data;
      data = {};
      data.username = $('input#name').val();
      data.smsCode = $('input#code').val();
      data.mobilePhoneNumber = $('input#mobile').val();
      data.email = $('input#email').val();
      data.orders = window.formData;
      data.orders.province = $('input#province').val();
      return data;
    },
    submit: function() {
      var that;
      that = this;
      console.log(this.getData());
      return $.ajax({
        type: 'POST',
        url: "/orders",
        params: that.getData(),
        data: JSON.stringify(that.getData()),
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
