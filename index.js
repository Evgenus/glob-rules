var compile, quote;

quote = function(str) {
  return (str + '').replace(new RegExp('[.\\\\+*?\\[\\^\\]${}=!<>:\\-]', 'g'), '\\$&');
};

compile = function(str) {
  return new RegExp(quote(str).replace(/\\\*\\\*\//g, '(?:[^/]+/)*').replace(/\\\*/g, '[^/]*').replace(/\\\?/g, '[^/]'), 'm');
};

module.exports.tester = function(str) {
  var re;
  re = compile(str);
  return function(p) {
    return re.test(p);
  };
};

module.exports.transformer = function(str, pattern) {
  var re;
  re = compile(str);
  return function(p) {
    return input.replace(p, pattern);
  };
};
