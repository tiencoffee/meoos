App = m.comp do
	view: ->
		m \.p-2,
			m Button,
				"Button"
			m TextInput,
				icon: \user
				value: "toLocaleString"
			m InputGroup,
				m Button,
					"OK"
				m TextInput
				m Button,
					color: \red
					"OK"
				m Button,
					"OK"
