define ['jquery', 'underscore', 'form', 'navbar'], ($, _, UIForm, NavBar) ->
  init: ->
    NavBar.setActive 'production'
    window.formData = {}
    window.formData.totalPrice = Number($('#total').text())
    window.formData.originPrice = Number($('#total').text())
    @handleSelectGlass()
    @handleSelectColor()

  handleSelectGlass: ->
    that = @
    $('.glass').on 'click', (el) ->
      $('.glass').removeClass 'selected'
      $(@).addClass 'selected'
      $('.glasses>.message').remove()
      if Number($(@).data 'price') > 0
        message = '<div class="message"><red>* </red>如果您的近视度数超过800或者散光度数超过200，需要单独定制镜片，价格会有变更，需要您联系我们的<a href="http://weibo.com/akesoeyecare">官方微博</a></div>'
        $(@).after message
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
  updateTotalPrice: ->
    $('#total').text window.formData.totalPrice