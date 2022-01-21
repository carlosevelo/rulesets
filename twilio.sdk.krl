ruleset twilio.sdk {
  meta {
    configure using 
      SID = ""
      authToken = ""
    provides getMessages, sendMessage
  }
  global {
    base_url = "https://api.twilio.com/2010-04-01/Accounts"

    getMessages = function(PageSize=50, To="+18505916767", From="+19378822423") {
      authentication = {"username":SID,"password":authToken}

      PageSizeFinal = (PageSize == "") => 50 | PageSize
        
      qs = {"PageSize":PageSizeFinal, "From":From, "To":To}
      
      http:get(<<#{base_url}/#{SID}/Messages.json>>, auth = authentication, qs=qs).decode()
    }

    sendMessage = defaction(Body) {
      form = {"To":+18505916767, "From":+19378822423, "Body":Body}
      authentication = {"username":SID,"password":authToken}

      http:post(<<#{base_url}/#{SID}/Messages.json>>.klog("Url to post to: "), 
        form = form,
        auth = authentication) setting(response)
      return response.klog("Response from API: ")
    }
  }

}