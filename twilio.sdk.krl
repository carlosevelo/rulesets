ruleset twilio.sdk {
  meta {
    configure using 
      SID = ""
      authToken = ""
    provides messages, sendMessage
  }
  global {
    base_url = "https://api.twilio.com/2010-04-01/Accounts"

    messages = function() {
      http:get(<<#{base_url}/#{SID}/Messages.json>>).decode()
    }

    sendMessage = defaction(To, From, Body) {
      queryString = {"To":To, "From":From, "Body":Body}
      http:post(<<#{base_url}/#{SID}/Messages.json>>, 
        qs = queryString,
        auth = {
          "username":"#{SID}",
          "password":"#{authToken}"
        }) setting(response)
      return response
    }
  }

}