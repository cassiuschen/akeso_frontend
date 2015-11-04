define ['jquery', 'cookie', 'navbar', 'leancloud', 'form'], ($, CC, NavBar, LC, UIForm) ->
	$('body').addClass 'users registion'
	try
		NavBar.setActive 'users'
	window.CC = CC
	UIForm.actionBtn
		selector: '#sendCode'
		loadingText: '已发送'
		onclick: (el) ->
			mobileNumber = $('input#mobile').val()
			console.log mobileNumber
			if !LC.checkIfExist mobileNumber
				UIForm.getWarn 'input#mobile', "哎呀，这次内测没有入选呢，下回再来试试吧！", (el) ->
					$('#sendCode').removeAttr 'disabled'
			else
				$(@selector).text '已发送'
				LC.SMSVerifySend mobileNumber
				$('#nextMove').removeAttr 'disabled'
	$("#nextMove").on 'click', ->
		userQuery = LC.createUserByMobile $('input#mobile').val(), $('input#code').val()
		attendanceData = LC.getUserAttendanceDataByMobile($('input#mobile').val())

		data =
			username: attendanceData.name
			email: attendanceData.email
			job: attendanceData.job
			gender: attendanceData.gender
			age: attendanceData.age
			illness: attendanceData.illness
		CC.session "user_session", userQuery.sessionToken

		LC.updateUserData(userQuery.objectId, CC.session("user_session"), data)