express = require 'express'
router  = express.Router()

router.options '*', (req, res) ->
	res.status(200).end()
	next()


router
	.get '/', (req, res) ->
		res.render 'index'
	.get '/detail', (req, res) ->
		res.render 'detail'

module.exports = router