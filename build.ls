require! {
	"fs-extra": fs
	"glob-concat"
}

Paths = {}
globs = <[
	C/apps/*
	C/(!apps)/**.*
]>
for glob in globs
	Paths"/#glob" = globConcat
		.sync glob
		.map (\/ +)

fs.writeJsonSync \Paths.json, Paths,
	spaces: \\t
