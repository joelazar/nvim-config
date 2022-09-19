return {
	lintCommand = "pylint --output-format text --score no --msg-template {path}:{line}:{column}:{C}:{msg} ${INPUT}",
	lintStdin = false,
	lintFormats = { "%f:%l:%c:%t:%m" },
	lintSource = "pylint",
}
