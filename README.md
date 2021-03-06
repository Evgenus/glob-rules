#glob-rules [![Build Status](https://drone.io/github.com/Evgenus/glob-rules/status.png)](https://drone.io/github.com/Evgenus/glob-rules/latest)

[![Dependency Status](https://david-dm.org/Evgenus/glob-rules.svg)](https://david-dm.org/Evgenus/glob-rules)
[![devDependency Status](https://david-dm.org/Evgenus/glob-rules/dev-status.svg)](https://david-dm.org/Evgenus/glob-rules#info=devDependencies)
[![GitHub version](https://badge.fury.io/gh/Evgenus%2Fglob-rules.svg)](http://badge.fury.io/gh/Evgenus%2Fglob-rules)


Test or transform filesystem paths with glob-like rules

If [minimatch] works like [RegEx.test], then [glob-rules] works like [RegEx.replace]. If you don't need replacing parts of matched filesystem path, or you need feature rich matcher, then use [minimatch]. This library is for copy/move/transfrom functionality, like inside building scripts. 

##Features

* `*` matching single path segment of any length including 0
* `**` matching subpath of any length including 0
* `?` matching single character of segment
* replacing could be achived with brackets like in regular expressions

##Examples

```javascript
var glob_rules = require("glob-rules");

// bulding minifying
var transformer = glob_rules.transformer("./src/(**).js", "./build/$1-min.js");
console.log(transformer("./src/app.js")); // ./build/app-min.js
console.log(transformer("./src/module/func.js")); // ./build/module/func-min.js

// compiling coffee-script
var transformer = glob_rules.transformer("./src/(**).coffee", "./build/$1.js");
console.log(transformer("./src/app.coffee")); // ./build/app.js
console.log(transformer("./src/module/func.coffee")); // ./build/module/func.js
```

## Copyright and license

Code and documentation copyright 2014 Eugene Chernyshov. Code released under [the MIT license](LICENSE).

[![Total views](https://sourcegraph.com/api/repos/github.com/Evgenus/glob-rules/counters/views.png)](https://sourcegraph.com/github.com/Evgenus/glob-rules)
[![Views in the last 24 hours](https://sourcegraph.com/api/repos/github.com/Evgenus/glob-rules/counters/views-24h.png)](https://sourcegraph.com/github.com/Evgenus/glob-rules)
[![library users](https://sourcegraph.com/api/repos/github.com/Evgenus/glob-rules/badges/library-users.png)](https://sourcegraph.com/github.com/Evgenus/glob-rules)
[![xrefs](https://sourcegraph.com/api/repos/github.com/Evgenus/glob-rules/badges/xrefs.png)](https://sourcegraph.com/github.com/Evgenus/glob-rules)

[minimatch]: http://github.com/isaacs/minimatch
[RegEx.test]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/RegExp/test
[glob-rules]: http://github.com/Evgenus/glob-rules
[RegEx.replace]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/replace
