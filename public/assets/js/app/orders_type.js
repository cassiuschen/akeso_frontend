define(['jquery', 'underscore', 'form', 'navbar'], function($, _, UIForm, NavBar) {
  return {
    init: function() {
      NavBar.setActive('production');
      window.formData = {};
      window.formData.totalPrice = Number($('#total').text());
      window.formData.originPrice = Number($('#total').text());
      this.handleSelectGlass();
      return this.handleSelectColor();
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
        window.formData.totalPrice = window.formData.originPrice + Number($(this).data('price'));
        return that.updateTotalPrice();
      });
    },
    handleSelectColor: function() {
      var that;
      that = this;
      return $('.color').on('click', function(el) {
        $('.color').removeClass('selected').addClass('mute');
        return $(this).removeClass('mute').addClass('selected');
      });
    },
    updateTotalPrice: function() {
      return $('#total').text(window.formData.totalPrice);
    }
  };
});
