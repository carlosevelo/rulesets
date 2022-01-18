ruleset twilio {
  meta {
    use module twilio.sdk alias sdk
      with 
        SID = meta:rulesetConfig{"sid"}
        authToken = meta:rulesetConfig{"auth_Token"}
    shares getMessages
  }
  global {
    getMessages = function(pageSize=10, To="+18505916767", From="+19378822423") {
      sdk:getMessages(pageSize, To, From)
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