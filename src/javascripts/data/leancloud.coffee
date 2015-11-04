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

  SMSVerifySend: (mobile) ->
    @_makeReq
      method: "POST"
      url: "requestSmsCode"
      data:
        mobilePhoneNumber: mobile

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


