import consumer from "./consumer"

consumer.subscriptions.create("MessageChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // メッセージ本文を表示するためのdiv要素を生成
    const messageComment = document.createElement('div');
    messageComment.setAttribute('class', "message-comment");
    const messageCommentHtml = data.content.content;
    messageComment.insertAdjacentHTML('afterbegin', messageCommentHtml);

    // // 画像を表示するためのdiv要素を生成
    // console.log(data.content.image);
    // if (data.content.image) {
    //   const messageImg = document.createElement('div');
    //   messageImg.setAttribute('class', "message-img");
    //   const messageImgHtml = `${data.content.image}.variant(resize: '500x500')`;
    //   messageImg.insertAdjacentHTML('afterbegin', messageImgHtml);
    // }

    // 投稿時間を表示するためのdiv要素を生成
    const messageDate = document.createElement('div');
    messageDate.setAttribute('class', "message-date");
    const messageDateHtml = data.content.created_at;
    messageDate.insertAdjacentHTML('afterbegin', messageDateHtml);
    messageDate.style.display = "none";

    // 本文・画像・時間を一つの要素にまとめるdiv要素を生成
    const messageContent = document.createElement('div');
    messageContent.setAttribute('class', "message-content");
    messageContent.appendChild(messageComment);
    // if (data.content.image) {
    //   messageContent.appendChild(messageImg);
    // }
    messageContent.appendChild(messageDate);

    // 削除ボタンを表示するための要素を生成
    const delBtn = document.createElement('input');
    delBtn.setAttribute('type', 'button');
    delBtn.setAttribute('onclick', 'this.closest(".message").remove()');
    delBtn.value = '✕';

    // 削除ボタンをリンクにするための要素を生成
    const delLink = document.createElement('a');
    delLink.setAttribute('data-method', 'delete');
    delLink.setAttribute('href', `/users/${data.content.user_id}/message_rooms/${data.content.room_id}/messages/${data.content.id}`);
    delLink.appendChild(delBtn);

    // 削除リンクを表示するためのdiv要素を生成
    const messageDel = document.createElement('div');
    messageDel.setAttribute('class', "message-del");
    messageDel.appendChild(delLink);

    // 作成した要素を表示するためのdiv要素を生成
    const message = document.createElement('div');
    message.setAttribute('class', "message");
    message.appendChild(messageContent);
    message.appendChild(messageDel);

    // メッセージの最上部に作成した要素を追加
    const messages = document.getElementById('messages');
    messages.prepend(message)

    // 入力した内容を初期化
    const newMessage = document.getElementById('message_content');
    newMessage.value = '';
  }
});
