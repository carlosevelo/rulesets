ruleset hello_world {
  meta {
    name "Hello World"
    description <<
  A first ruleset for the Quickstart
  >>
    author "Phil Windley"
    shares hello
  }
    
  global {
    hello = function(obj) {
      msg = "Hello " + obj;
      msg
    }
  }
   
  rule hello_world {
    select when echo hello
    send_directive("say", {"something": "Hello World"})
  }

  rule monkey {
    select when echo monkey
    pre {
      name = event:attr("name");
    }
    if event:attr("name") then
      send_directive("say", {"something":"Hello" || name })
    notfired {
      raise explicit event monkey
    }
  }

  rule when_false {
    select when explicit monkey
    send_directive("say", {"something":"Hello Monkey"});
  }
}