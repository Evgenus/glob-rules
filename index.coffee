quote = (str) ->
    return (str + '')
        .replace(new RegExp('[.\\\\+*?\\[\\^\\]${}=!<>:\\-]', 'g'), '\\$&')

compile = (str) -> 
    re = quote(str)
        .replace(/\\\*\\\*\//g, '[^/]*(?:/[^/]*)*/')
        .replace(/\\\*\\\*/g, '[^/]*(?:/[^/]*)*')
        .replace(/\\\*/g, '[^/]*')
        .replace(/\\\?/g, '[^/]')
    return new RegExp("^" + re + "$")

module.exports.tester = (str) ->
    re = compile(str)
    return (p) -> return re.test(p)

module.exports.transformer = (str, pattern) ->
    re = compile(str)
    return (p) -> return input.replace(p, pattern)