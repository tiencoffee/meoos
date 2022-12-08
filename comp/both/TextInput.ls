TextInput = m.comp do
	view: ->
		m \.TextInput,
			if @attrs.icon
				m Icon,
					class: "TextInput__icon TextInput__leftIcon"
					name: @attrs.icon
			m \input.TextInput__input
			if @attrs.rightIcon
				m Icon,
					class: "TextInput__icon TextInput__rightIcon"
					name: @attrs.rightIcon

m.css do
	'.TextInput':
		position: \relative
		width: 200
		height: 28
		border: "solid 1px #{Css.gray.4}"
		borderRadius: 6
		display: \inline-flex
		alignItems: \center
		background: \#fff
		':focus-within':
			borderColor: \#0000
			boxShadow: "0 0 0 1px #{Css.blue.3},0 0 0 3px #{Css.blue.4}66"
			zIndex: 3
	'.TextInput__input':
		width: 0
		height: \100%
		border: 0
		padding: '0 8px'
		flex: 1
		font: \inherit
		background: \#0000
	'.TextInput__leftIcon':
		paddingLeft: 8
	'.TextInput__rightIcon':
		paddingRight: 8
