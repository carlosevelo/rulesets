ruleset wovyn_base {
  meta {
    name "wovn base ruleset"
    
  }

  global {

    

  }

  rule process_heartbeat {
    select when wovyn heartbeat
    send_directive()
  }
}