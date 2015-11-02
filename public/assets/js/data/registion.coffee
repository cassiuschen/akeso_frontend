define ['jquery'], ($) ->
  API_BASE_URL: "https://leancloud.cn/1.1/"
  APP_ID: "Cpt7lNSjHVOCP1DvYNT73ky9"
  APP_KEY: "AbTX5HRGkOry6rwBdG59lfkd"
  _makeReq: (set={})->
    result = {}
    $.ajax
      type: set.method
      url: "#{@API_BASE_URL}/#{set.url}"
      params: set.params
      data: JSON.stringify set.data
      contentType: "application/json;charset=utf-8"
      dataType: "json"
      async: false
      success: (data, _) ->
        result = data
      headers:
        "X-LC-Id": "Cpt7lNSjHVOCP1DvYNT73ky9"
        "X-LC-Key": "AbTX5HRGkOry6rwBdG59lfkd"
    return result

  checkIfExist: (mobile) ->
    data = @_makeReq
      url: 'Attendances'
      params:
        where:
          mobile: mobile
    return data
