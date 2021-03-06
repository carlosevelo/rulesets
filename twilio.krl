ruleset twilio {
  meta {
    use module twilio.sdk alias sdk
      with 
        SID = meta:rulesetConfig{"sid"}
        authToken = meta:rulesetConfig{"auth_Token"}
    shares getMessages
  }
  global {
    getMessages = function(PageSize, To, From) {
      sdk:getMessages(PageSize, To, From)
    }
  }

  rule sendMessage {
    select when twilio new_Message
    pre {
      msgBody = event:attr("body")
    }
    if msgBody then
    sdk:sendMessage(msgBody)

  }
}