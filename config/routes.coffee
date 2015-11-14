express = require 'express'
router  = express.Router()

router.options '*', (req, res) ->
  res.status(200).end()
  next()


router
  .get '/', (req, res) ->
    res.render 'static/index'
  .get '/detail', (req, res) ->
    res.render 'static/detail'

  .get '/users/registion', (req, res) ->
    if req.params.success == 1
      res.render 'users/registion/success'
    else
      res.render 'users/registion/create'


module.exports = router