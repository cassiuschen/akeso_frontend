express   = require 'express'
router    = express.Router()
LeanCloud = require 'avoscloud-sdk'
_         = require 'underscore'
excel     = require 'node-xlsx'



router.options '*', (req, res) ->
  res.status(200).end()
  next()

LeanCloud.initialize('Cpt7lNSjHVOCP1DvYNT73ky9', 'AbTX5HRGkOry6rwBdG59lfkd')

Orders    = LeanCloud.Object.extend "Orders"
Users     = LeanCloud.User


router
  .get '/', (req, res) ->
    res.render 'admin/index',
      controller: "Index"
  .get '/users', (req, res) ->
    query = new LeanCloud.Query(Users)
    query.limit(1000)
    query.descending "createdAt"
    query.find
      success: (results) ->
        res.render 'admin/users',
          controller: "Users"
          users: results
  .get '/orders', (req, res) ->
    query = new LeanCloud.Query(Orders)
    query.limit(1000)
    query.descending "createdAt"
    query.include("author").find
      success: (results) ->
        res.render 'admin/orders',
          controller: "Orders"
          orders: results
  
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




module.exports = router