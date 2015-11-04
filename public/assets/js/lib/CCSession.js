define(['underscore'], function(_) {
  return {
    encode: function(s) {
      return encodeURIComponent(s);
    },
    decode: function(s) {
      return decodeURIComponent(s);
    },
    stringifyCookieValue: function(value) {
      return String(value);
    },
    parseCookieValue: function(s) {
      var e, error;
      if (s.indexOf('"') === 0) {
        s = s.slice(1, -1).replace(/\\"/g, '"').replace(/\\\\/g, '\\');
      }
      try {
        s = decodeURIComponent(s.replace(/\+/g, ' '));
        return s;
      } catch (error) {
        e = error;
        return console.log(e);
      }
    },
    read: function(s) {
      var value;
      value = this.parseCookieValue(s);
      return value;
    },
    session: function(key, value) {
      var cookie, cookies, i, len, name, parts, result, thisCookie;
      if (arguments.length > 1 && !_.isFunction(value)) {
        return document.cookie = [this.encode(key), '=', this.stringifyCookieValue(value)].join('');
      }
      if (key) {
        result = void 0;
      } else {
        result = {};
      }
      cookies = document.cookie.split('; ');
      for (i = 0, len = cookies.length; i < len; i++) {
        cookie = cookies[i];
        parts = cookie.split('=');
        name = this.decode(parts.shift());
        thisCookie = parts.join('=');
        if (key === name) {
          result = this.read(thisCookie);
          if (result.length === 0) {
            result = void 0;
          }
          break;
        }
        if (!key) {
          result[name] = this.read(thisCookie) || void 0;
        }
      }
      return result;
    },
    remove: function(key) {
      this.session(key, '');
      return !this.session(key);
    }
  };
});
