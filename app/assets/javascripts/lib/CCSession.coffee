define ['underscore'], (_) ->
    encode: (s) ->
        encodeURIComponent s

    decode: (s) ->
        decodeURIComponent s

    stringifyCookieValue: (value) ->
        #console.log value
        String value

    parseCookieValue: (s) ->
        if s.indexOf('"') == 0
            s = s.slice(1, -1).replace(/\\"/g, '"').replace(/\\\\/g, '\\')

        try
            s = decodeURIComponent(s.replace(/\+/g, ' '))
            return s
        catch e
            console.log e

    read: (s) ->
        value = @parseCookieValue s
        value

    session: (key, value) ->
        if arguments.length > 1 && !_.isFunction(value)
            return document.cookie = [@encode(key), '=', @stringifyCookieValue(value)].join('')

        if key
            result = undefined
        else
            result = {}
        cookies = document.cookie.split '; '

        for cookie in cookies
            parts = cookie.split '='
            name = @decode parts.shift()
            thisCookie = parts.join '='

            if key == name
                result = @read thisCookie
                result = undefined if result.length == 0
                break

            if !key
                result[name] = @read(thisCookie) || undefined

        return result

    remove: (key) ->
        @session key, ''
        return !@session key