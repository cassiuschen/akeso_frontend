define(['jquery', 'cookie', 'navbar', 'leancloud', 'form', 'modal'], function($, CC, NavBar, LC, UIForm, M) {
  $('body').addClass('users registion');
  try {
    NavBar.setActive('users');
  } catch (undefined) {}
  window.CC = CC;
  UIForm.actionBtn({
    selector: '#sendCode',
    loadingText: '已发送',
    onclick: function(el) {
      var mobileNumber;
      mobileNumber = $('input#mobile').val();
      console.log(mobileNumber);
      if (!LC.checkIfExist(mobileNumber)) {
        return UIForm.getWarn('input#mobile', "哎呀，这次内测没有入选呢，下回再来试试吧！", function(el) {
          return $('#sendCode').removeAttr('disabled');
        });
      } else {
        $(this.selector).text('已发送');
        LC.SMSVerifySend(mobileNumber, {
          template: "registion",
          username: $('input#name').val()
        });
        return $('#nextMove').removeAttr('disabled');
      }
    }
  });
  return $("#nextMove").on('click', function() {
    $('#step1 .actions').css('opacity', '0').remove();
    $('#step1 .input-group').css('opacity', '0').remove();
    $('.sub-title').css('opacity', '0');
    $('#step1').css('margin-top', '-60px');
    $('#step2').fadeIn(700);
    $('#t1').css('opacity', '0').text('订单信息').delay(500, function() {
      return $(this).css('opacity', '1');
    });
    $('input#mobile').attr('disabled', 'disabled');
    M.init();
    $('.selections .selection').on('click', function() {
      if (!$('#typePreviewImg').hasClass('show')) {
        $('#typePreviewImg').addClass('show');
      }
      $('#typePreviewImg img').attr('src', "/assets/images/type-" + ($(this).data('type')) + ".jpg");
      $('#submit').removeAttr('disabled');
      $('.selections input').val($(this).text());
      $('.selection.selected').removeClass('selected');
      return $(this).addClass('selected');
    });
    $('#submit').on('click', function() {
      $('#nameCheck').text($('input#name').val());
      $('#mobileCheck').text($('input#mobile').val());
      $('#addressCheck').text($('#address').val());
      $('#typeImg').attr('src', "/assets/images/type-" + ($('.selection.selected').data('type')) + ".jpg");
      return $('#typeCheck').text($('input#type').val());
    });
    return $('#confirmed').on('click', function() {
      var data;
      $('#confirmed').attr('disabled', 'disabled');
      $(this).text('请稍后...');
      data = {
        type: $('input#type').val(),
        address: $('#address').val()
      };
      if (LC.updateUserData(CC.session('user_id'), CC.session("user_session"), data)) {
        return window.location = '/users/registion-success.html';
      }
    });
  });
});
