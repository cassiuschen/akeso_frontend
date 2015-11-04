define(['jquery', 'cookie', 'navbar', 'leancloud', 'form'], function($, CC, NavBar, LC, UIForm) {
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
        LC.SMSVerifySend(mobileNumber);
        return $('#nextMove').removeAttr('disabled');
      }
    }
  });
  return $("#nextMove").on('click', function() {
    var attendanceData, data, userQuery;
    userQuery = LC.createUserByMobile($('input#mobile').val(), $('input#code').val());
    attendanceData = LC.getUserAttendanceDataByMobile($('input#mobile').val());
    data = {
      username: attendanceData.name,
      email: attendanceData.email,
      job: attendanceData.job,
      gender: attendanceData.gender,
      age: attendanceData.age,
      illness: attendanceData.illness
    };
    CC.session("user_session", userQuery.sessionToken);
    return LC.updateUserData(userQuery.objectId, CC.session("user_session"), data);
  });
});
