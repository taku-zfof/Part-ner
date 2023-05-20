import consumer from "./consumer"


 $(document).on('turbolinks:load', function() {
   //showのid名からchatroom_idをもらう
  const chatChannel = consumer.subscriptions.create({ channel: 'ChatroomChannel', chatroom_id: $('#messages').data('chatroom_id') }, {
    connected() {
    },

    disconnected() {
    },

  　
    received: function(data) {
    //処理の最後に送られてくる”message”（messageパーシャルが入っている)をchatrooms/showの#messagesに追加する。
     $('#messages').append(data['message']);
     
     //下の３行で一番下にスクロール
     var scrollPosition = document.getElementById("area").scrollTop;
     var scrollHeight = document.getElementById("area").scrollHeight;
     document.getElementById("area").scrollTop = scrollHeight;
    },

    //発火したらまずここが動く。(event.target.value)をmessageに代入、chatroom_channel.rbのspeakに飛ぶ
    speak: function(message) {
      return this.perform('speak',{
        message: message,
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
   // ボタンクリックでも発火
  $('#message_button').click(function(event) {
      const target = $('[data-behavior~=chatroom_speaker]');
      chatChannel.speak(target.val());
      target.val('');
      return event.preventDefault();
  });
});
