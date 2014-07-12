var compile, quote;

quote = function(str) {
  return (str + '').replace(new RegExp('[.\\\\+*?\\[\\^\\]${}=!<>:\\-]', 'g'), '\\$&');
};

compile = function(str) {
  var re;
  re = quote(str).replace(/^\\\*\\\*\//g, '(?:[^/]*(?:/[^/]+)*/)?').replace(/\\\*\\\*\//g, '(?:[^/]+(?:/[^/]+)*/)?').replace(/\\\*\\\*/g, '[^/]*(?:/[^/]*)*').replace(/\\\*/g, '[^/]*').replace(/\\\?/g, '[^/]');
  return new RegExp("^" + re + "$");
};

module.exports.tester = function(str) {
  var re;
  re = compile(str);
  return function(p) {
    return re.test(p);
  };
};

module.exports.matcher = function(str) {
  var re;
  re = compile(str);
  return function(p) {
    var result;
    result = p.match(re);
    if (result != null) {
      return [].concat(result);
    }
    return null;
  };
};

module.exports.transformer = function(str, pattern, callback) {
  var re;
  re = compile(str);
  return function(p) {
    var parts, result;
    parts = p.match(re);
    if (parts === null) {
      return p;
    }
    result = pattern.replace(/\$([1-9][0-9]*)/g, function(_, snum) {
      var num;
      num = parseInt(snum);
      return parts[num];
    });
    result = result.replace(/\{([1-9][0-9]*)\}/g, function(_, snum) {
      var num;
      num = parseInt(snum);
      return parts[num];
    });
    result = result.replace(/\{([a-zA-Z_][0-9a-zA-Z_]*)\}/g, function(_, id) {
      return callback(id, parts);
    });
    return result;
  };
};
