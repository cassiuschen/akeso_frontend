ASSETS_URL = '/assets'
data = 
	glass: [
		{
			name: "无镜片"
			value: 0
		}, {
			name: "蔡司A系列1.665非球面树脂镜片"
			value: 699
		}, {
			name: "蔡司抗疲劳1.665数码型镜片"
			value: 1299
		}
	]
	types:
		akesoSheet: 
			name: "板材款"
			shortcut: "sheet"
			price: 699
			colors: [
				{
					name: "黑色"
					price: 699
					shortcut: 'black'
					photo:
						positive: "#{ASSETS_URL}/images/orders/positive/photo_sheet_black.jpg"
						side: "#{ASSETS_URL}/images/orders/45/photo_sheet_black.jpg"
						color: "#{ASSETS_URL}/images/orders/colors/photo_sheet_black.png"
				},{
					name: "拼色"
					shortcut: 'mix'
					price: 699
					photo:
						positive: "#{ASSETS_URL}/images/orders/positive/photo_sheet_red.jpg"
						side: "#{ASSETS_URL}/images/orders/45/photo_sheet_red.jpg"
						color: "#{ASSETS_URL}/images/orders/colors/photo_sheet_red.png"
				}
			]
		akesoTi:
			name: "钛架款"
			shortcut: "ti"
			price: 899
			colors: [
				{
					name: "黑色"
					shortcut: 'black'
					price: 899
					photo:
						positive: "#{ASSETS_URL}/images/orders/positive/photo_black.jpg"
						side: "#{ASSETS_URL}/images/orders/45/photo_black.jpg"
						color: "#{ASSETS_URL}/images/orders/colors/photo_black.png"
				}, {
					name: "蓝色"
					shortcut: 'blue'
					price: 899
					photo:
						positive: "#{ASSETS_URL}/images/orders/positive/photo_blue.jpg"
						side: "#{ASSETS_URL}/images/orders/45/photo_blue.jpg"
						color: "#{ASSETS_URL}/images/orders/colors/photo_blue.png"
				}, {
					name: "灰色"
					shortcut: 'grey'
					price: 899
					photo:
						positive: "#{ASSETS_URL}/images/orders/positive/photo_hui.jpg"
						side: "#{ASSETS_URL}/images/orders/45/photo_hui.jpg"
						color: "#{ASSETS_URL}/images/orders/colors/photo_gray.png"
				}, {
					name: "白色"
					shortcut: 'white'
					price: 899
					photo:
						positive: "#{ASSETS_URL}/images/orders/positive/photo_white.jpg"
						side: "#{ASSETS_URL}/images/orders/45/photo_white.jpg"
						color: "#{ASSETS_URL}/images/orders/colors/photo_white.png"
				}
			]
		akesoWood:
			name: "檀木款（全框）"
			shortcut: 'wood'
			price: 1699
			colors: [
				{
					name: "黑檀木"
					shortcut: 'black'
					price: 1699
					photo:
						positive: "#{ASSETS_URL}/images/orders/positive/photo_wood_black.jpg"
						side: "#{ASSETS_URL}/images/orders/45/photo_wood_black.jpg"
						color: "#{ASSETS_URL}/images/orders/colors/photo_wood_black.png"
				}, {
					name: "红檀木"
					shortcut: 'red'
					price: 1699
					photo:
						positive: "#{ASSETS_URL}/images/orders/positive/photo_wood_red.jpg"
						side: "#{ASSETS_URL}/images/orders/45/photo_wood_red.jpg"
						color: "#{ASSETS_URL}/images/orders/colors/photo_wood_red.png"
				}, {
					name: "绿檀木"
					shortcut: 'green'
					price: 1699
					photo:
						positive: "#{ASSETS_URL}/images/orders/positive/photo_wood_green.jpg"
						side: "#{ASSETS_URL}/images/orders/45/photo_wood_green.jpg"
						color: "#{ASSETS_URL}/images/orders/colors/photo_wood_green.png"
				}
			]
		akesoWoodHald:
			name: "檀木款（半框）"
			shortcut: 'woodHalf'
			price: 1699
			colors: [
				{
					name: "黑檀木"
					shortcut: 'black'
					price: 1699
					photo:
						positive: "#{ASSETS_URL}/images/orders/positive/photo_wood_black_half.jpg"
						side: "#{ASSETS_URL}/images/orders/45/photo_wood_black_half.jpg"
						color: "#{ASSETS_URL}/images/orders/colors/photo_wood_black.png"
				}, {
					name: "红檀木"
					shortcut: 'red'
					price: 1699
					photo:
						positive: "#{ASSETS_URL}/images/orders/positive/photo_wood_red_half.jpg"
						side: "#{ASSETS_URL}/images/orders/45/photo_wood_red_half.jpg"
						color: "#{ASSETS_URL}/images/orders/colors/photo_wood_red.png"
				}, {
					name: "绿檀木"
					shortcut: 'green'
					price: 1699
					photo:
						positive: "#{ASSETS_URL}/images/orders/positive/photo_wood_green_half.jpg"
						side: "#{ASSETS_URL}/images/orders/45/photo_wood_green_half.jpg"
						color: "#{ASSETS_URL}/images/orders/colors/photo_wood_green.png"
				}
			]

module.exports = data