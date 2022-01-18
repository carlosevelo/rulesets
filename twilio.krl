ruleset twilio {
  meta {
    use module twilio.sdk alias sdk
      with 
        SID = meta:rulesetConfig{"sid"}
        authToken = meta:rulesetConfig{"auth_Token"}
    shares messages
  }
  global {
    messages = function() {
      sdk:messages()
    }
  }

  rule sendMessage {
    select when twilio new_Message
    pre {
      msgBody = event:attr("body")
    }
    if msgBody then
      twilioMod:sendMessage(msgto, msgFrom, msgBody)

  }
}