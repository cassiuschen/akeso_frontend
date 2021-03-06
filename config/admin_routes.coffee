express   = require 'express'
router    = express.Router()
LeanCloud = require 'avoscloud-sdk'
_         = require 'underscore'
excel     = require 'node-xlsx'



router.options '*', (req, res, next) ->
  res.status(200).end()
  next()



LeanCloud.initialize('Cpt7lNSjHVOCP1DvYNT73ky9', 'AbTX5HRGkOry6rwBdG59lfkd')

Orders    = LeanCloud.Object.extend "Orders"
Users     = LeanCloud.User
Attendances = LeanCloud.Object.extend "Attendances"

router.get '*', (req, res, next) ->
  unless req.path == '/signin'
    user = LeanCloud.User.current()
    if user
      next()
    else
      res.redirect '/admin/signin'
  else
    next()




router
  .get '/', (req, res) ->
    user = LeanCloud.User.current()
    res.render 'admin/index',
      controller: "Index"
      user: user
  .get '/users', (req, res) ->
    user = LeanCloud.User.current()
    query = new LeanCloud.Query(Users)
    query.limit(1000)
    query.descending "createdAt"
    query.find
      success: (results) ->
        res.render 'admin/users',
          controller: "Users"
          users: results
          user: user
  .get '/orders', (req, res) ->
    user = LeanCloud.User.current()
    query = new LeanCloud.Query(Orders)
    query.limit(1000)
    query.descending "createdAt"
    query.include("author").find
      success: (results) ->
        res.render 'admin/orders',
          controller: "Orders"
          orders: results
          user: user
  .get '/attendances', (req, res) ->
    user = LeanCloud.User.current()
    usersQuery = new LeanCloud.Query(Users)
    usersQuery
      .limit(1000)
      .find
        success: (results) ->
          users = _.map results, (u) ->
            u.attributes.mobilePhoneNumber
          attendancesQuery = new LeanCloud.Query(Attendances)
          attendancesQuery
            .limit(1000)
            .find
              success: (data) ->
                attendances = data
                _.each attendances, (a) ->

                  if _.contains users, a.attributes.mobile
                    a.attributes.isSigned = true
                  else
                    a.attributes.isSigned = false
                res.render 'admin/attendances',
                  controller: "Attendances"
                  attendances: attendances
                  user: user
                  underscore: require 'underscore'
  
  .get '/query/users', (req, res) ->
    query = new LeanCloud.Query(Users)
    query.limit(1000)
    query.descending "createdAt"
    query.include("author").find
      success: (results) ->
        unless !!(req.query.groupBy)
          res.send results
        else
          try
            if req.query.groupBy == "createdAt"
              res.send _.groupBy(results, (d) ->
                tmp = new Date(d.createdAt)
                return tmp.getDate()
              )
            else
              res.send _.groupBy(results, req.query.groupBy)
          catch
            res.send results
  .get '/query/orders', (req, res) ->
    query = new LeanCloud.Query(Orders)
    query.limit(1000)
    query.descending "createdAt"
    query.find
      success: (results) ->
        unless !!(req.query.groupBy)
          res.send results
        else
          try
            if req.query.groupBy == "createdAt"
              res.send _.groupBy(results, (d) ->
                tmp = new Date(d.createdAt)
                return tmp.getDate()
              )
            else
              res.send _.groupBy(results, req.query.groupBy)
          catch
            res.send results



  .get '/excel/orders.xlsx', (req, res) ->
    query = new LeanCloud.Query(Orders)
    query.limit(1000)
    query.descending "createdAt"
    query.include "author"
    query.find
      success: (results) ->
        titles = _.keys results[0].attributes
        titles[0] = [
          "user_name",
          "user_phone",
          "user_email",
          "user_id"
        ]
        titles.push "Created At"
        titles.push "Order ID"
        orders = _.map(results, (o) ->
          raw = _.values(o.attributes)
          raw.push o.createdAt
          raw.push o.id
          raw[0] = [
            raw[0].attributes.username,
            raw[0].attributes.mobilePhoneNumber,
            raw[0].attributes.email,
            raw[0].attributes.objectId
          ]
          return _.flatten raw
        )
        #res.send [_.flatten titles].concat orders
        res.send excel.build [
          name: "订单数据-#{new Date()}"
          data: [_.flatten titles].concat orders
        ]
  .get '/excel/attendances.xlsx', (req, res) ->
    attendancesQuery = new LeanCloud.Query(Attendances)
    attendancesQuery
      .limit(1000)
      .find
        success: (results) ->
          users = _.map results, (u) ->
            u.attributes.mobile
          usersQuery = new LeanCloud.Query(Users)
          usersQuery
            .limit(1000)
            .find
              success: (data) ->
                attendances = data
                filteredAttendances = _.filter attendances, (a) ->
                  _.contains users, a.attributes.mobilePhoneNumber

                sheetTitle = ["姓名", "手机", "电子邮箱", "职业", "年龄", "性别", "病症", "款式", "地址"]
                sheet = []
                sheet.push sheetTitle

                userData = _.each(filteredAttendances, (a) ->
                  raw = []
                  raw.push(a.attributes.username)
                  raw.push(a.attributes.mobilePhoneNumber)
                  raw.push(a.attributes.email)
                  raw.push(a.attributes.job)
                  raw.push(if a.attributes.age < 100 then a.attributes.age else "未填写")
                  raw.push(if a.attributes.gender == "male" then "男" else "女")
                  raw.push(a.attributes.illness)
                  raw.push(a.attributes.type)
                  raw.push(a.attributes.address)
                  sheet.push raw
                )
                res.send excel.build [
                  name: "内测用户数据-#{new Date()}"
                  data: sheet
                ]

  .get '/signin', (req, res) ->
    res.render 'admin/signin'

  .post '/signin', (req, res) ->
    console.log req.body
    LeanCloud.User.logIn req.body.email, req.body.password,
      success: (user) ->
        user.logIn()
        res.redirect '/admin'
      error: (user, error) ->
        console.log error.message
        res.render 'admin/signin',
          error: error.message
  .get '/signout', (req, res) ->
    LeanCloud.User.logOut()
    res.redirect '/admin/signin'




module.exports = router