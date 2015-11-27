define(['jquery'], function($) {
  this.UIModal = (function() {
    function UIModal(element) {
      this.element = element;
    }

    UIModal.prototype.show = function() {
      var el;
      el = $(this.element);
      $('body').append('<<div class="modal-dimmer"></div>>').css('overflow', 'hidden');
      el.addClass('open');
      return el.children(".close-btn").on('click', function() {
        $('.modal-dimmer').fadeOut(1000).remove();
        el.removeClass('open');
        return $('body').css('overflow', 'auto');
      });
    };

    UIModal.prototype.hidden = function() {
      var el;
      el = $(this.element);
      el.removeClass('open');
      return $('body').css('overflow', 'auto');
    };

    return UIModal;

  })();
  return this.UIModal;
});
