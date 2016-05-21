import socket from "./socket"

/**
TEST
**/
$(function() {
  let div = $("#test");
  var topic = "data:lobby";
  console.log('registered data');

  // Join the topic
  let channel = socket.channel(topic, {});
  channel.join()
    .receive("ok", data => {
      console.log("Joined topic", topic)
    })
    .receive("error", resp => {
      console.log("Unable to join topic", topic)
    })

});
