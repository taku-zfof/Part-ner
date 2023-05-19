import consumer from "./consumer"


 $(document).on('turbolinks:load', function() {
   //showのid名からchatroom_idをもらう
  const chatChannel = consumer.subscriptions.create({ channel: 'ChatroomChannel', chatroom_id: $('#messages').data('chatroom_id') }, {
    connected() {
    },
  
    disconnected() {
    },
  　
  　//処理の最後に送られてくる”message”（messageパーシャルが入っている)をchatrooms/showの#messagesに追加する。
    received: function(data) {
     return $('#messages').append(data['message']);
    },
  
    //発火したらまずここが動く。(event.target.value)をmessageに代入、chatroom_channel.rbのspeakに飛ぶ
    speak: function(message) {
      return this.perform('speak',{
        message: message
      });
    }
  });
  
  // エンターキー押下で発火
  $(document).on('keypress', '[data-behavior~=chatroom_speaker]', function(event) {
    if (event.keyCode === 13) {
      chatChannel.speak(event.target.value);
      event.target.value = '';
      return event.preventDefault();
    }
  });
});
