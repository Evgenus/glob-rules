quote = (str) ->
    return (str + '')
        .replace(new RegExp('[.\\\\+*?\\[\\^\\]${}=!<>:\\-]', 'g'), '\\$&')

compile = new RegExp(
    quote(str)
        .replace(/\\\*\\\*\//g, '(?:[^/]+/)*')
        .replace(/\\\*/g, '[^/]*')
        .replace(/\\\?/g, '[^/]')
    , 'm')

module.export.tester = (str) ->
    re = compile(str)
    return (p) -> return re.test(p)

module.export.transformer = (str, pattern) ->
    re = compile(str)
    return (p) -> return input.replace(p, pattern)