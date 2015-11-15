express   = require 'express'
router    = express.Router()
LeanCloud = require 'avoscloud-sdk'
_         = require 'underscore'
AkesoData = require './data'

router.options '*', (req, res) ->
  res.status(200).end()
  next()

LeanCloud.initialize('Cpt7lNSjHVOCP1DvYNT73ky9', 'AbTX5HRGkOry6rwBdG59lfkd')
router
  .get '/', (req, res) ->
    res.render 'static/index'
  .get '/detail', (req, res) ->
    res.render 'static/detail'

  

  # User System

  # 创建用户
  # {smsCode: 'xxxxxx', mobilePhoneNumber: '15910364815', ...}
  .post '/users', (req, res) ->
    user = LeanCloud.User()
    user.signUpOrlogInWithMobilePhone req.params,
      success: (user) ->
        user.logIn()
        res.redirect '/users/registion?success=1'
      error: (err) ->
        console.dir err
        res.send
          message: "登录失败，请重试！"
          status: 500
  .delete '/users', (req, res) ->
    LeanCloud.User.logOut()
    res.send
      message: "您已成功登出！"
      status: 200


  # 订单系统
  #                  orders GET    /orders(.:format)                           orders#index
  #                        POST    /orders(.:format)                           orders#create
  #               new_order GET    /orders/new(.:format)                       orders#new
  #              edit_order GET    /orders/:id/edit(.:format)                  orders#edit
  #                   order GET    /orders/:id(.:format)                       orders#show
  #                        PATCH   /orders/:id(.:format)                       orders#update
  #                        PUT     /orders/:id(.:format)                       orders#update
  #                        DELETE  /orders/:id(.:format)                       orders#destroy
  #                   root GET     /                                           order#index

  # 列出当前用户所有订单 
  #.get '/orders', (req, res) ->

  # 新建订单
  # {smsCode: xxx, mobilePhoneNumber: xxx, username: xxx, gender: xxx, email: xxx, orders:{ type:xxx, color:xxx }}
  .post '/orders', (req, res) ->
    user = LeanCloud.User()
    user.signUpOrlogInWithMobilePhone
      smsCode: req.params.smsCode
      mobilePhoneNumber: req.params.mobilePhoneNumber
      username: req.params.username
      email: req.params.email
      gender: req.params.gender
    ,
      success: (user) ->
        user.logIn()
        order = new LeanCloud.Orders()
        order.set 'author', user
        order.set 'type', req.params.orders.type
        order.set 'color', req.params.orders.color
        order.save null,
          success: (order) ->
            # Send SMS to notice
            res.redirect '/orders/success'
          
      error: (err) ->
        console.dir err
        res.send
          message: "登录失败，请重试！"
          status: 500

  .get '/orders/new', (req, res) ->
    res.render 'orders/new', {types: AkesoData.types, glass: AkesoData.glass}

  .get '/orders/success', (req, res) ->
    res.render 'orders/success'



  # LeanCloud API
  .get '/leancloud/sendSMS/:mobile', (req, res) ->
    console.log req.params.mobile
    LeanCloud.User
      .requestMobilePhoneVerify(req.params.mobile)
      .then ->
          res.send
            message: "发送成功"
            status: 200
        , (err) ->
          console.log err
          res.send
            message: "发送失败"
            status: 500




  # 内测登记
  .get '/users/registion', (req, res) ->
    if req.params.success == 1
      res.render 'users/registion/success'
    else
      res.render 'users/registion/create'


module.exports = router