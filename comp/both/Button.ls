Button = m.comp do
	onbeforeupdate: !->
		@attrs.type ?= \button

	view: ->
		m \button.Button,
			class: m.class do
				"Button--basic": @attrs.basic
				"Button--small": @attrs.small
				"Button--#{@attrs.color}": @attrs.color
				"Button--hasColor": @attrs.color
				@attrs.class
			type: @attrs.type
			if @attrs.icon
				m Icon,
					class: "Button__icon"
					name: @attrs.icon
			if @children.length
				m \.Button__text,
					@children
			if @attrs.rightIcon
				m Icon,
					class: "Button__icon"
					name: @attrs.rightIcon

m.css do
	'.Button':
		height: 28
		padding: '0 4px'
		border: "solid 1px #{Css.gray.4}"
		borderRadius: 6
		display: \inline-flex
		justifyContent: \center
		alignItems: \center
		font: \inherit
		backgroundColor: Css.gray.8
		':hover':
			borderColor: Css.gray.3
			backgroundColor: Css.gray.7
	for k, val of Css.colors
		".Button--#k":
			borderColor: val.2
			backgroundColor: val.4
			color: \#fff
			':hover':
				borderColor: val.1
				backgroundColor: val.3
			'.Button--basic':
				color: val.4
				':hover':
					backgroundColor: val.8
	'.Button--basic':
		border: 0
		backgroundColor: \#ffff
		color: Css.gray.2
	'.Button--small':
		height: 24
	'.Button__icon':
		margin: '0 4px'
	'.Button__text':
		margin: '0 4px'
		flex: 1
