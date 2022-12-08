Paths = await m.fetch \Paths.json \json
paths =
	* \/model/both/Css.ls
		\/model/both/Both.ls
	* \/model/main/TaskPubl.ls
		\/model/main/Task.ls
		\/model/main/Main.ls
	* \/model/ifrm/Ifrm.ls
	* \/comp/both/Icon.ls
		\/comp/both/Button.ls
		\/comp/both/TextInput.ls
		\/comp/both/InputGroup.ls
	* []
	* []
	\/code/both.ls
	\/code/main.ls
	\/code/ifrm.ls
	\/ifrm.html
Codes = await Promise.all paths.map (path) ~>
	if Array.isArray path
		Promise.all path.map (path2) ~>
			m.fetch path2
		.then (* \\n)
	else
		m.fetch path
Codes.9 -= /<!-- Code injected by live-server -->.+<\/script>\n/gs
codeMain = Codes[0 1 3 4 6 7] * \\n
codeMain = livescript.compile codeMain
eval codeMain
