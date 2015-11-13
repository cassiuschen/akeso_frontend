define ['jquery', 'underscore'], ($, _) ->
  API_BASE_URL: "https://leancloud.cn/1.1"
  APP_ID: "Cpt7lNSjHVOCP1DvYNT73ky9"
  APP_KEY: "AbTX5HRGkOry6rwBdG59lfkd"
  _makeReq: (set={method: 'GET', headers: {}})->
    result = {}
    if set.method != "GET"
      set.data = JSON.stringify set.data
    rawHeaders = 
      "X-LC-Id": @APP_ID
      "X-LC-Key": @APP_KEY
    headers = _.extend rawHeaders, set.headers
    $.ajax
      type: set.method
      url: "#{@API_BASE_URL}/#{set.url}"
      params: set.params
      #data: JSON.stringify set.data
      data: set.data
      contentType: "application/json"
      dataType: "json"
      async: false
      success: (data, _) ->
        result = data
      headers: headers
    console.log result
    return result

  checkIfExist: (mobile) ->
    console.log("FUCK!")
    data = @_makeReq
      method: 'GET'
      url: 'classes/Attendances'
      data:
        #where: "{\"mobile\":\"#{mobile}\"}"
        where:
            mobile: mobile
    console.log data
    if data.results.length > 0
      return true
    else
      return false

  updateInfo: (mobile, data={}) ->
    exist = @_makeReq
      method: 'GET'
      url: 'classes/Attendances'
      data:
        where:
            mobile: mobile
    if exist.results.length > 0
      objId = exist.results[0].objectId
      result = @_makeReq
        method: "PUT"
        url: "classes/Attendances/#{objId}"
        data: data
      return result
    else
      return false

  SMSVerifySend: (mobile, set={}) ->
    data =
      mobilePhoneNumber: mobile
    data = _.extend data, set
    @_makeReq
      method: "POST"
      url: "requestSmsCode"
      data: data

  SMSVerifyCheck: (mobile, code) ->
    @_makeReq
      method: "POST"
      url: "verifySmsCode/#{code}?mobilePhoneNumber=#{mobile}"

  createUserByMobile: (mobile, code) ->
    @_makeReq
      method: "POST"
      url: 'usersByMobilePhone'
      data:
        mobilePhoneNumber: mobile
        smsCode: code

  getUserAttendanceDataByMobile: (mobile) ->
    exist = @_makeReq
      method: 'GET'
      url: 'classes/Attendances'
      data:
        where:
            mobile: mobile
    if exist.results.length > 0
      objId = exist.results[0].objectId
      result = @_makeReq
        method: "GET"
        url: "classes/Attendances/#{objId}"
      return result
    else
      return {}
  updateUserData: (id, session, data) ->
    @_makeReq
      method: 'PUT'
      url: "users/#{id}"
      data: data
      headers: 
        "X-LC-Session": session
  getUserThatHaveNotSignIn: ->
    attendances = @attendances()
    #attendances = _.map attendances, (u) ->
    #  return {
    #    mobile: u.mobile
    #    name: u.name
    #  }
    attendancesMobile = _.map attendances, (u) ->
      return u.mobile

    users = @_makeReq
      method: 'GET'
      url: 'users'
    #users = _.map users.results, (u) ->
    #  return {
    #    mobile: u.mobilePhoneNumber
    #    name: u.username
    #  }
    userMobile = _.map users.results, (u) ->
      return u.mobilePhoneNumber
    #console.log users
    #console.log attendances
    window._ = _
    diff = _.difference attendancesMobile, userMobile
    _.filter attendances, (u) ->
      _.contains diff, u.mobile

  sendNoticeToUserWhoHaveNotSignIn: ->
    users = @getUserThatHaveNotSignIn()
    for user in users
      @SMSVerifySend user.mobile, template: 'notice-email', name: user.name

  attendances: ->
    first = @_makeReq
      method: 'GET'
      url: 'classes/Attendances'
    last = @_makeReq
      method: 'GET'
      url: 'classes/Attendances?skip=100'
    return first.results.concat last.results

