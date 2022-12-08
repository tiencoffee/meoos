Css =
	colors:
		gray: <[#212529 #343a40 #495057 #6c757d #adb5bd #ced4da #dee2e6 #e9ecef #f8f9fa]>
		blue: <[#031633 #052c65 #084298 #0a58ca #0d6efd #3d8bfd #6ea8fe #9ec5fe #cfe2ff]>
		green: <[#051b11 #0a3622 #0f5132 #146c43 #198754 #479f76 #75b798 #a3cfbb #d1e7dd]>
		yellow: <[#331904 #653208 #984c0c #ca6510 #fd7e14 #fd9843 #feb272 #fecba1 #ffe5d0]>
		red: <[#2c0b0e #58151c #842029 #b02a37 #dc3545 #e35d6a #ea868f #f1aeb5 #f8d7da]>

	sides:
		"": [""]
		x: [\-left \-right]
		y: [\-top \-bottom]
		l: [\-left]
		t: [\-top]
		r: [\-right]
		b: [\-bottom]

	spaces: [0 4 8 16 24 48]

	shadow: '0 2px 4px #21252933,0 8px 24px #21252933'

Css <<<
	intents:
		blue: Css.colors.blue
		green: Css.colors.green
		yellow: Css.colors.yellow
		red: Css.colors.red

for k, val of Css.colors
	Css[k] = val

m.css do
	'*,:before,:after':
		boxSizing: \border-box
		verticalAlign: \middle
	':focus':
		outline: 0
	'html':
		height: \100%
		background: \#fff
	'body':
		height: \100%
		margin: 0
		fontFamily: '"Helvetica Neue","Tahoma",sans-serif'
		fontSize: \16px
		overflow: \hidden
		userSelect: \none
	'#m ':
		for val in <[absolute relative fixed]>
			".#val":
				position: val
		for p, prop of (m: \margin p: \padding)
			for s, sides of Css.sides
				* for size, z in Css.spaces
						* ".#p#s-#z":
								{["#prop#side", size] for side in sides}
							if p is \m and z
								".-#p#s-#z":
									{["#prop#side", -size] for side in sides}
					if p is \m
						".m#s\-auto":
							{["margin#side", \auto] for side in sides}
		for p, prop of (w: \width h: \height)
			for type in ["" \min- \max-]
				for size in [0 50 100]
					".#type#p-#size":
						"#type#prop": size + \%
		'.row':
			display: \flex
		'.column':
			display: \flex
			flexDirection: \column
		'.col':
			minWidth: 0
			flex: 1
		'.col-0':
			flex: \initial
		for i from 1 to 12
			size = (+(i / 12 * 100)toFixed 5) + \%
			".col-#i":
				width: size
			".col-#i.column":
				height: size
		'.start,.top.column':
			justifyContent: \flex-start
		'.center,.middle.column':
			justifyContent: \center
		'.end,.bottom.column':
			justifyContent: \flex-end
		'.top,.start.column':
			alignItems: \flex-start
		'.middle,.center.column':
			alignItems: \center
		'.bottom,.end.column':
			alignItems: \flex-end
		for val in <[auto hidden]>
			".overflow-#val":
				overflow: val
