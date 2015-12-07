define ['jquery', 'underscore', 'form', 'navbar', 'modal'], ($, _, UIForm, NavBar, UIModal) ->
  init: ->
    NavBar.setActive 'production'
    window.formData = {}
    window.formData.type = $(".gt").data 'type'
    window.formData.totalPrice = Number($('#total').text())
    window.formData.originPrice = Number($('#total').text())
    window.formData.color = $('.color.selected').text()
    that = @
    window.app = @
    @handleSelectGlass()
    @handleSelectColor()
    submit = new UIModal("#info-modal")
    $(".submit").on 'click', ->
      submit.show()

    $('#sendCode').on 'click', ->
      that.sendSMS()

  handleSelectGlass: ->
    that = @
    $('.glass').on 'click', (el) ->
      $('.glass').removeClass 'selected'
      $(@).addClass 'selected'
      $('.glasses>.message').remove()
      if Number($(@).data 'price') > 0
        message = '<div class="message"><red>* </red>如果您的近视度数超过800或者散光度数超过200，需要单独定制镜片，价格会有变更，需要您联系我们的<a href="http://weibo.com/akesoeyecare">官方微博</a></div>'
        $(@).after message
      window.formData.glass = $(@).children(".name").text()
      window.formData.totalPrice = window.formData.originPrice + Number($(@).data 'price')
      that.updateTotalPrice()
  handleSelectColor: ->
    that = @
    $('.color').on 'click', (el) ->
      $('.color')
        .removeClass 'selected'
        .addClass 'mute'
      $(@)
        .removeClass 'mute'
        .addClass 'selected'
      $('.submit').removeAttr 'disabled'
      window.formData.color = $(@).text()
      $("#colorImg").attr 'src', $(@).data 'img'
  updateTotalPrice: ->
    $('#total').text window.formData.totalPrice
  sendSMS: ->
    that = @
    $('#sendCode').attr 'disabled', 'disabled'
    mobile = $('input#mobile').val()
    result = {}
#    $.ajax
#      type: 'GET'
#      url: "/leancloud/sendSMS/#{mobile}"
#      params:
#        mobile: mobile
#      data: 
#        mobile: mobile
#      contentType: "application/json"
#      dataType: "json"
#      async: false
#      success: (data, _) ->
#        result = data
#        console.log result.message
#        if result.status == 200
#          $('#submit').removeAttr 'disabled'
#          $('#submit').on 'click', ->
#            that.submit()
#        else
#          UIForm.getWarn 'input#mobile', "手机号似乎有点问题哦，请重新填写。", (el) ->
#            $('#sendCode').removeAttr 'disabled'
    $('#submit').removeAttr 'disabled'
    $('#submit').on 'click', ->
      that.submit()
  getData: ->
    data = {}
    data.username = $('input#name').val()
    data.smsCode = $('input#code').val()
    data.mobilePhoneNumber = $('input#mobile').val()
    data.email = $('input#email').val()
    data.orders = window.formData
    data.orders.province = $('input#province').val()
    return data
  submit: ->
    that = @
    console.log @getData()
    $.ajax
      type: 'POST'
      url: "/orders"
      params:
        that.getData()
      data: 
        JSON.stringify(that.getData())
      contentType: "application/json"
      dataType: "json"
      success: (data, _) ->
        console.log data
        if data.status == 500
          UIForm.formWarning '.form', data.message
        else
          window.location = '/orders/success'
      error: (err) ->
        console.log err