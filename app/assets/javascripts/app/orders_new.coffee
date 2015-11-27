define ['jquery', 'underscore', 'form', 'navbar'], ($, _, UIForm, NavBar) ->
  init: ->
    NavBar.setActive 'production'
    #@handleStep2Init()
    @handleTypeSelect()
    window.UI = @
    window.totalPrice = 0
    window.formData = {}

  handleStep2Init: ->
    that = @
    $('#nextToStep2').on 'click', ->
      console.log 'click!'
      if $('#nextToStep2').data('target') == "StepTwo"
        console.log 'toStepTwo'
        $('.step').removeClass 'onStepOne'
        $('.step').addClass "on#{$('#nextToStep2').data 'target'}"
        $('#nextToStep2').data 'target', 'StepOne'
        $(this).html '<i class="fa fa-angle-left"> 选择款式'
        height = $('#step-1').height()
        $('#step-1').hide()
        $(this).data 'layoutValue', $('.price').data('price')
        setTimeout ->
            $('#step-2')
              .removeClass 'hide'
              .fadeIn(600)
              .addClass 'show'
              that.selectionUI()
              $('#sendCode').on 'click', ->
                that.sendSMS()
              
              #.css "-webkit-transform", "translateY(-#{height}px)"
              #.css "transform", "translateY(-#{height}px)"
          , 200
      else
        $('#step-1').show()
        $('#step-2')
          .fadeOut(600)
          .addClass 'hide'
          .removeClass 'show'
          #.css "-webkit-transform", "translateY(0)"
          #.css "transform", "translateY(0)"
        console.log 'toStepOne'
        $('.step').removeClass 'onStepTwo'
        $('.step').addClass "on#{$('#nextToStep2').data 'target'}"
        $('#nextToStep2').data 'target', 'StepTwo'
        $(this).html '填写信息 <i class="fa fa-angle-right">'


        

  handleTypeSelect: ->
    that = @
    $('.type').on 'click', (el) ->
      $('.type').addClass 'mute'
      $('.type.selected').removeClass 'selected'
      $('#nextToStep2').removeAttr 'disabled'

      $(this)
        .removeClass 'mute'
        .addClass 'selected'
      that.updatePrice $(@).data('price')

      type = $(@).data 'type'
      window.formData.type = type
      $('#nextToStep2').attr 'href', "/orders/new/#{type}"

  selectionUI: ->
    that = @
    $('.selections .selection').on 'click', ->
      $('.selections input').val $(this).text()
      $('.selection.selected').removeClass 'selected'
      $(this).addClass 'selected'
      oldPrice = Number($('#nextToStep2').data 'layoutValue')
      that.updatePrice(oldPrice + Number($(this).data 'value'))
      rawType = "#{$('.colors .color.selected').data 'name'}#{$('.colors .color.selected').parent().data 'typename'}"
      unless $(@).data('value') == 0
        rawType += " + " + $(@).text()
        $('.des').addClass 'show'
      else
        $('.des').removeClass 'show'
       $('.typeInput').text rawType



      
  updatePrice: (newPrice) ->
    window.totalPrice = newPrice
    $('.price').data 'price', newPrice
    $('.price').html "<span>价格</span>￥#{newPrice}"
    $('.price').addClass 'priceChange'
    setTimeout ->
        $('.price').removeClass 'priceChange'
      , 800

  sendSMS: ->
    that = @
    $('#sendCode').attr 'disabled', 'disabled'
    mobile = $('input#mobile').val()
    result = {}
    $.ajax
      type: 'GET'
      url: "/leancloud/sendSMS/#{mobile}"
      params:
        mobile: mobile
      data: 
        mobile: mobile
      contentType: "application/json"
      dataType: "json"
      async: false
      success: (data, _) ->
        result = data
        console.log result.message
        if result.status == 200
          $('#submit').removeAttr 'disabled'
          $('#submit').on 'click', ->
            that.submit()
        else
          UIForm.getWarn 'input#mobile', "手机号似乎有点问题哦，请重新填写。", (el) ->
            $('#sendCode').removeAttr 'disabled'

  getFormData: ->
    # {smsCode: xxx, mobilePhoneNumber: xxx, username: xxx, gender: xxx, email: xxx, orders:{ type:xxx, color:xxx }}
    data = {}
    data.username = $('input#name').val()
    data.smsCode = $('input#code').val()
    data.mobilePhoneNumber = $('input#mobile').val()
    data.email = $('input#email').val()
    data.orders = 
      type: $('.typeInput').data 'type'
      color: $('.typeInput').data 'color'
      glass: $('input#glass').val()
      province: $('input#province').val()
    return data

  submit: ->
    that = @
    console.log @getFormData()
    $.ajax
      type: 'POST'
      url: "/orders"
      params:
        that.getFormData()
      data: 
        JSON.stringify(that.getFormData())
      contentType: "application/json"
      dataType: "json"
      success: (data, _) ->
        window.location = '/orders/success'
      error: (err) ->
        console.log err


