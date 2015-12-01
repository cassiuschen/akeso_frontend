ASSETS_URL = '/assets'
data = 
	glass: [
		{
			name: "蔡司Aplus非球面树脂镜片"
			des: "卡尔蔡司Aplus非球面树脂镜片"
			message: "此镜片为非卖品，仅为艾索健康会员的眼健康呵护服务"
			value: 699
			origin:2480
		}, {
			name: "卡尔蔡司数码型防疲劳镜片"
			des: "非球面钻立方防蓝光镀膜·"
			message: "此镜片为非卖品，仅为艾索健康会员的眼健康呵护服务"
			value: 1299
			origin: 4780
		}
	]
	types:
		sheet: 
			name: "板材款"
			shortcut: "sheet"
			price: 699
			des: "意大利Mazzucchelli板材"
			real: "#{ASSETS_URL}/images/orders/sheet@2x.png"
			layout:
				main: "#{ASSETS_URL}/images/orders/pro/sheet_1.png"
				side: "#{ASSETS_URL}/images/orders/pro/sheet_2.png"
			colors: [
				{
					name: "黑色"
					price: 699
					shortcut: 'black'
					photo:
						positive: "#{ASSETS_URL}/images/orders/positive/photo_sheet_black.jpg"
						side: "#{ASSETS_URL}/images/orders/45/photo_sheet_black.jpg"
						color: "#{ASSETS_URL}/images/orders/colors/photo_sheet_black.png"
				}, {
					name: "拼色"
					shortcut: 'mix'
					price: 699
					photo:
						positive: "#{ASSETS_URL}/images/orders/positive/photo_sheet_red.jpg"
						side: "#{ASSETS_URL}/images/orders/45/photo_sheet_red.jpg"
						color: "#{ASSETS_URL}/images/orders/colors/photo_sheet_red.png"
				},
			]
		ti:
			name: "钛架款"
			shortcut: "ti"
			price: 899
			des: "军工级纯钛"
			real: "#{ASSETS_URL}/images/orders/ti@2x.png"
			layout:
				main: "#{ASSETS_URL}/images/orders/pro/titanium_1.png"
				side: "#{ASSETS_URL}/images/orders/pro/titanium_2.png"
			colors: [
				{
					name: "白色"
					shortcut: 'white'
					price: 899
					photo:
						positive: "#{ASSETS_URL}/images/orders/positive/photo_white.jpg"
						side: "#{ASSETS_URL}/images/orders/45/photo_white.jpg"
						color: "#{ASSETS_URL}/images/orders/colors/photo_white.png"
				}, {
					name: "灰色"
					shortcut: 'grey'
					price: 899
					photo:
						positive: "#{ASSETS_URL}/images/orders/positive/photo_hui.jpg"
						side: "#{ASSETS_URL}/images/orders/45/photo_hui.jpg"
						color: "#{ASSETS_URL}/images/orders/colors/photo_gray.png"
				}, {
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
				}
			]
		wood:
			name: "檀木款(全框)"
			shortcut: 'wood'
			price: 1699
			des: "百年檀木"
			real: "#{ASSETS_URL}/images/orders/wood@2x.png"
			layout:
				main: "#{ASSETS_URL}/images/orders/pro/wood_1.png"
				side: "#{ASSETS_URL}/images/orders/pro/wood_2.png"
			colors: [
				{
					name: "红檀木"
					shortcut: 'red'
					price: 1699
					photo:
						positive: "#{ASSETS_URL}/images/orders/positive/photo_wood_red.jpg"
						side: "#{ASSETS_URL}/images/orders/45/photo_wood_red.jpg"
						color: "#{ASSETS_URL}/images/orders/colors/photo_wood_red.png"
				}, {
					name: "黑檀木"
					shortcut: 'black'
					price: 1699
					photo:
						positive: "#{ASSETS_URL}/images/orders/positive/photo_wood_black.jpg"
						side: "#{ASSETS_URL}/images/orders/45/photo_wood_black.jpg"
						color: "#{ASSETS_URL}/images/orders/colors/photo_wood_black.png"
				}, {
					name: "花梨木"
					shortcut: 'green'
					price: 1699
					photo:
						positive: "#{ASSETS_URL}/images/orders/positive/photo_wood_green.jpg"
						side: "#{ASSETS_URL}/images/orders/45/photo_wood_green.jpg"
						color: "#{ASSETS_URL}/images/orders/colors/photo_wood_green.png"
				}
			]
		woodHalf:
			name: "檀木款(半框)"
			shortcut: 'woodHalf'
			price: 1699
			des: "百年檀木"
			real: "#{ASSETS_URL}/images/orders/wood_half@2x.png"
			layout:
				main: "#{ASSETS_URL}/images/orders/pro/wood_half.png"
				side: "#{ASSETS_URL}/images/orders/pro/wood_half_2.png"
			colors: [
				{
					name: "红檀木"
					shortcut: 'red'
					price: 1699
					photo:
						positive: "#{ASSETS_URL}/images/orders/positive/photo_wood_red_half.jpg"
						side: "#{ASSETS_URL}/images/orders/45/photo_wood_red_half.jpg"
						color: "#{ASSETS_URL}/images/orders/colors/photo_wood_red.png"
				}, {
					name: "黑檀木"
					shortcut: 'black'
					price: 1699
					photo:
						positive: "#{ASSETS_URL}/images/orders/positive/photo_wood_black_half.jpg"
						side: "#{ASSETS_URL}/images/orders/45/photo_wood_black_half.jpg"
						color: "#{ASSETS_URL}/images/orders/colors/photo_wood_black.png"
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