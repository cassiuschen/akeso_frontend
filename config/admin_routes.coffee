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
    console.log user
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