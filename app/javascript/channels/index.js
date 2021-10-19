// Load all the channels within this directory and all subdirectories.
// Channel files must be named *_channel.js.

const channels = require.context('.', true, /_channel\.js$/)
channels.keys().forEach(channels)

let interval = null
document.addEventListener("turbolinks:load", function() {
  if (window.location.pathname == "/message") {
    const ADMIN_USER_ID = new URL(window.location.href).searchParams.get("admin_user_id")
    const URL_PATH = `/message.js?admin_user_id=${ADMIN_USER_ID}`
  
    console.log({ADMIN_USER_ID,URL_PATH})
    clearInterval(interval)
    interval = setInterval(() => {
      console.log("Fetching")
      fetch(URL_PATH)
      .then(res => res.text())
      .then(res => {
        let messageContainer = document.querySelector("#message-container")
        messageContainer.innerHTML = res
      })
      .catch(err => console.log({err}))
    }, 3000);
}});
