quote = (str) ->
    return (str + '')
        .replace(new RegExp('[.\\\\+*?\\[\\^\\]${}=!<>:\\-]', 'g'), '\\$&')

compile = (str) -> 
    re = quote(str)
        .replace(/^\\\*\\\*\//g, '(?:[^/]*(?:/[^/]+)*/)?')        # ^**/
        .replace(/\\\*\\\*\//g, '(?:[^/]+(?:/[^/]+)*/)?')         # **/
        .replace(/\\\*\\\*/g, '[^/]*(?:/[^/]*)*')               # **
        .replace(/\\\*/g, '[^/]*')                              # *
        .replace(/\\\?/g, '[^/]')                               # ?
    return new RegExp("^" + re + "$")

module.exports.tester = (str) ->
    re = compile(str)
    return (p) -> 
        return re.test(p)

module.exports.matcher = (str) ->
    re = compile(str)
    return (p) -> 
        result = p.match(re)
        return [].concat(result) if result?
        return null 

module.exports.transformer = (str, pattern) ->
    re = compile(str)
    return (p) -> 
        parts = p.match(re)
        return p if parts is null
        result = pattern.replace /\$([1-9][0-9]*)/g, (_, snum) ->
            num = parseInt(snum)
            return parts[num]
        return result