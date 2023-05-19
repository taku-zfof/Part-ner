import consumer from "./consumer"

 $(document).on('turbolinks:load', function() {
  const chatChannel = consumer.subscriptions.create({ channel: 'ChatroomChannel', chatroom_id: $('#messages').data('chatroom_id') }, {
    connected() {
      // Called when the subscription is ready for use on the server
    },
  
    disconnected() {
      // Called when the subscription has been terminated by the server
    },
  
    received: function(data) {
     return $('#messages').append(data['message']);
    },
  
    speak: function(message) {
      return this.perform('speak',{
        message: message
      });
    }
  });
  
  $(document).on('keypress', '[data-behavior~=chatroom_speaker]', function(event) {
    if (event.keyCode === 13) {
      chatChannel.speak(event.target.value);
      event.target.value = '';
      return event.preventDefault();
    }
  });
});
