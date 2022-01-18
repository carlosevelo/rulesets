ruleset twilio {
  meta {
    use module twilio.sdk
      with 
        SID = keys:rulesetConfig{"sid"}
        authToken = keys:rulesetConfig{"auth_Token"}
  }
  global {
    messages = function() {
      twilioMod.messages()
    }
  }

  rule getMessages {
    select when twilio get_Messages
    messages()
  }

  rule sendMessage {
    select when twilio new_Message
    pre {
      msgto = event:attr("to")
      msgFrom = event:attr("from")
      msgBody = event:attr("body")
    }
    if msgto && msgFrom && msgBody then
      twilioMod:sendMessage(msgto, msgFrom, msgBody)

  }
}