express   = require 'express'
router    = express.Router()
LeanCloud = require 'avoscloud-sdk'
_         = require 'underscore'
AkesoData = require './data'

router.options '*', (req, res) ->
  res.status(200).end()
  next()

#if process.env.NODE_ENV == 'production' || process.env.NODE_ENV == 'staging'
LeanCloud.initialize('Cpt7lNSjHVOCP1DvYNT73ky9', 'AbTX5HRGkOry6rwBdG59lfkd')
#else
#  LeanCloud.initialize('aLFJqize9puIjxGu7Q9jWd9q', '4nIIMFQFjAv0asjOr2yJ4DrU')
sendErrorMessage = (data) ->
  #用户 {{name}} 订单提交时出现错误，以下为数据信息： 
  # 用户电话： {{mobile}}，邮箱：{{email}}，省份：{{location}} 
  # 订单信息：{{color}}款{{type}}，选配{{glass}} 
  # 错误原因：{{errorMessage}} 请及时联系用户
  adminMobile = ['15910364815', '13911413915']
  _.each adminMobile, (admin) ->
    params =
      mobilePhoneNumber: admin
      template: "error-warning"
      name: data.name
      mobile: data.userMobile
      email: data.email
      location: data.location
      color: data.order.color
      type: data.order.type
      glass: data.order.glass
      errorMessage: data.error
      type: "#{req.body.orders.color}#{req.body.orders.type}"
    LeanCloud.Cloud.requestSmsCode(params)
router
  .get '/', (req, res) ->
    res.render 'static/index',
      controller: "Index"
  .get '/detail', (req, res) ->
    res.render 'static/detail',
      controller: "productionDetail"
  .get '/about', (req, res) ->
    res.render 'static/about',
      controller: "about"
  .get '/contact', (req, res) ->
    res.render 'static/contact',
      controller: "about"

      
  .get '/health', (req, res) ->
    res.render 'static/health',
      controller: 'health'
  .get '/service', (req, res) ->
    res.render 'static/service',
      controller: 'service'

  .get '/stories', (req, res) ->
    res.render 'stories/index',
      controller: "story"
  .get '/stories/:name', (req, res) ->
    try
      res.render "stories/#{req.params.name}",
        controller: "story"
    catch e
      res.render 'error',
        message: "404 Not Found"
        error: "404 Not Found"

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
    console.log "========================================== Order Comming =================================================="
    console.log req.body
    user = new LeanCloud.User()

    user.signUpOrlogInWithMobilePhone
      smsCode: req.body.smsCode
      mobilePhoneNumber: req.body.mobilePhoneNumber
      username: req.body.username
      email: req.body.email || "#{req.body.mobilePhoneNumber}@default.akeso.cn"
    ,
      success: (user_req) ->
        console.log user_req
        #user.logIn()
        Orders = LeanCloud.Object.extend("Orders")
        
        order = new Orders()
        order.set 'type', req.body.orders.type
        order.set 'color', req.body.orders.color
        order.set 'glass', req.body.orders.glass
        order.set 'author', user_req
        order.set 'province', req.body.orders.province
        order.save null,
          success: (order_saved) ->
            user.relation("orders").add order_saved
            console.log "============================"
            user.save null,
              success: (order) ->
                # Send SMS to notice
                params =
                    mobilePhoneNumber: req.body.mobilePhoneNumber
                    template: "order-success"
                    name: req.body.username
                    gender: ''
                    type: "#{req.body.orders.color}#{req.body.orders.type}"
                console.log params
                LeanCloud.Cloud.requestSmsCode(params).then ->
                      console.log '已发送短信'  
                    , (err) ->
                      console.log err.message
                res.send
                  status: 200
                  message: "订单提交成功"
              error: (usr, err) ->
                console.log "+++++++++++++++++++++++++++++++ ERROR!!!!!"
                console.log "+++++++++++++++++++++++++++++++ ERROR DATA"
                console.log req.body
                console.log "+++++++++++++++++++++++++++++++ ERROR MESSAGE"
                console.log err.message
                console.log "+++++++++++++++++++++++++++++++++++++++++++++"
                errorData =
                  errorMessage: err.message
                  name: req.body.username
                  userMobile: req.body.mobilePhoneNumber
                  email: req.body.email
                  location: req.body.orders.province
                  order:
                    type: req.body.orders.type
                    color: req.body.orders.color
                    glass: req.body.orders.glass
                sendErrorMessage(errorData)
                res.send
                  message: err.message
                  status: 500
          error: (oder, err) ->
            console.log "+++++++++++++++++++++++++++++++ ERROR!!!!!"
            console.log "+++++++++++++++++++++++++++++++ ERROR DATA"
            console.log req.body
            console.log "+++++++++++++++++++++++++++++++ ERROR MESSAGE"
            console.log err.message
            console.log "+++++++++++++++++++++++++++++++++++++++++++++"
            errorData =
              errorMessage: err.message
              name: req.body.username
              userMobile: req.body.mobilePhoneNumber
              email: req.body.email
              location: req.body.orders.province
              order:
                type: req.body.orders.type
                color: req.body.orders.color
                glass: req.body.orders.glass
            sendErrorMessage(errorData)
            res.send
              message: err.message
              status: 500
          
      error: (usr, err) ->
        console.log "+++++++++++++++++++++++++++++++ ERROR!!!!!"
        console.log "+++++++++++++++++++++++++++++++ ERROR DATA"
        console.log req.body
        console.log "+++++++++++++++++++++++++++++++ ERROR MESSAGE"
        console.log err.message
        console.log "+++++++++++++++++++++++++++++++++++++++++++++"
        errorData =
          errorMessage: err.message
          name: req.body.username
          userMobile: req.body.mobilePhoneNumber
          email: req.body.email
          location: req.body.orders.province
          order:
            type: req.body.orders.type
            color: req.body.orders.color
            glass: req.body.orders.glass
        sendErrorMessage(errorData)
        res.send
          message: err.message
          status: 500

  .get '/orders/new', (req, res) ->
    res.render 'orders/new', 
      types: AkesoData.types
      glass: AkesoData.glass
      controller: "orders"
      action: "new"
  .get '/orders/new/:type', (req, res) ->
    console.log req.params.type
    res.render "orders/type",
      data: AkesoData.types[req.params.type]
      glass: AkesoData.glass
      controller: "orders"
      action: "selectColor"

  .get '/orders/success', (req, res) ->
    res.render 'orders/success',
      controller: "'users registion'"



  # LeanCloud API
  .get '/leancloud/sendSMS/:mobile', (req, res) ->
    console.log req.params.mobile
    LeanCloud.Cloud.requestSmsCode(req.params.mobile)
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
    if req.query.success == "1"
      res.render 'users/registions/success'
    else
      res.render 'users/registions/create'


module.exports = router