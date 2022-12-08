class Task
	(app, env, parent) ->
		@ <<< Both!
		@ <<< TaskPubl!
		m.bind @
		@pid = @incrId!
		@tid = @uuid!
		@name = app.name
		@icon = app.icon
		@type = app.type
		@path = app.path
		@title = env.title ? app.title ? @name
		@width = env.width or app.width or 800
		@height = env.height or app.height or 600
		@x = Math.floor env.x ? app.x ? (os.desktop.width - @width) / 2
		@y = Math.floor env.y ? app.y ? (os.desktop.height - @height) / 2
		@parent = parent
		@dom = void
		@moving = no

	oncreate: (vnode) !->
		@dom = vnode.dom
		@updateSizeDom!
		@updateXYDom!
		@iframe = @dom.querySelector \iframe
		code = await os.readFile "#@path/app.ls"
		code = Codes.8.replace /(\t*)\[\[(@?)(\w+)\]\]/g (, tab, isThis, name) ~>
			val =
				if isThis => @[name]
				else eval name
			@indent val, tab.length
		code = Codes[0 2 3 5 6]concat code .join \\n
		code = livescript.compile code
		code = Codes.9.replace "[[code]]" code
		@iframe.srcdoc = code
		m.redraw!

	clampXY: !->
		@x = @clamp @x, os.desktop.x, os.desktop.width - @width
		@y = @clamp @y, os.desktop.y, os.desktop.height - @height

	updateSizeDom: !->
		anime.set @dom,
			width: @width
			height: @height

	updateXYDom: !->
		anime.set @dom,
			left: @x
			top: @y

	onpointerdownTitle: (event) !->
		event.target.setPointerCapture event.pointerId
		@moving = yes

	onpointermoveTitle: (event) !->
		event.redraw = no
		if @moving
			@x += event.movementX
			@y += event.movementY
			@updateXYDom!

	onlostpointercaptureTitle: (event) !->
		if @moving
			@clampXY!
			@updateXYDom!
			@moving = no

	view: ->
		m \.Task,
			m \.Task__header,
				m Button,
					basic: yes
					small: yes
					icon: @icon
				m \.Task__title,
					onpointerdown: @onpointerdownTitle
					onpointermove: @onpointermoveTitle
					onlostpointercapture: @onlostpointercaptureTitle
					m \.Task__titleText,
						@title
				m Button,
					basic: yes
					small: yes
					icon: \minus
				m Button,
					basic: yes
					small: yes
					icon: \plus
				m Button,
					basic: yes
					small: yes
					color: \red
					icon: \times
			m \.Task__body,
				m \iframe.Task__iframe

m.css do
	'.Task':
		position: \absolute
		borderRadius: 8
		display: \flex
		flexDirection: \column
		boxShadow: "0 0 0 1px #{Css.gray.4},#{Css.shadow}"
	'.Task__header':
		margin: '4px 4px 0'
		display: \flex
		alignItems: \center
	'.Task__title':
		width: 0
		height: \100%
		padding: '0 8px'
		display: \flex
		flex: 1
		alignItems: \center
	'.Task__titleText':
		overflow: \hidden
		textOverflow: \ellipsis
		whiteSpace: \nowrap
	'.Task__body':
		position: \relative
		margin: 4
		flex: 1
	'.Task__iframe':
		position: \absolute
		width: \100%
		height: \100%
		border: 0
		borderRadius: 6
