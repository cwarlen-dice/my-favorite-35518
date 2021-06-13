import consumer from "./consumer"

consumer.subscriptions.create("MessageChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const messages = document.getElementById('messages');
    const newMessage = document.getElementById('message_content');

    // メッセージを表示するためのdiv要素を生成
    const messageComment = document.createElement('div');
    messageComment.setAttribute('class', "message-comment");
    const messageCommentHtml = data.content.content;
    messageComment.insertAdjacentHTML('afterbegin', messageCommentHtml);

    if (data.content.image) {
      const messageImg = document.createElement('div');
      messageImg.setAttribute('class', "message-img");
      const messageImgHtml = `${data.content.image}.variant(resize: '500x500')`;
      messageImg.insertAdjacentHTML('afterbegin', messageImgHtml);
    }

    const messageDate = document.createElement('div');
    messageDate.setAttribute('class', "message-date");
    const messageDateHtml = data.content.created_at;
    messageDate.insertAdjacentHTML('afterbegin', messageDateHtml);
    messageDate.style.display = "none";

    const messageContent = document.createElement('div');
    messageContent.setAttribute('class', "message-content");

    messageContent.appendChild(messageComment);
    if (data.content.image) {
      messageContent.appendChild(messageImg);
    }
    messageContent.appendChild(messageDate);

    const delBtn = document.createElement('input');
    delBtn.setAttribute('type', 'button');
    delBtn.setAttribute('onclick', 'this.closest(".message").remove()');
    delBtn.value = '✕';

    const delLink = document.createElement('a');
    delLink.setAttribute('data-method', 'delete');
    delLink.setAttribute('href', `/users/${data.content.user_id}/message_rooms/${data.content.room_id}/messages/${data.content.id}`);

    delLink.appendChild(delBtn);

    const messageDel = document.createElement('div');
    messageDel.setAttribute('class', "message-del");

    messageDel.appendChild(delLink);

    const message = document.createElement('div');
    message.setAttribute('class', "message");

    message.appendChild(messageContent);
    message.appendChild(messageDel);

    messages.prepend(message)





    // const html = `<p>${data.content.content}</p>`;
    // const messages = document.getElementById('messages');
    // const newMessage = document.getElementById('message_content');
    // messages.insertAdjacentHTML('afterbegin', html);
    newMessage.value = '';
  }
});
