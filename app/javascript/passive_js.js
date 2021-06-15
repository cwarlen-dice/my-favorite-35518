window.addEventListener('load', function () {

  // user#show > profileの表示切替
  if (document.getElementById('edit-btn')) {
    document.getElementById('edit-btn').addEventListener('click', function () {
      const elem = document.getElementById('profile');
      if (elem.style.display == "block") {
        // noneで非表示
        elem.style.display = "none";
      } else {
        // blockで表示
        elem.style.display = "block";
      }
    });
  }

  // user#show > genreソート
  if (document.getElementsByClassName('select-box-genre-sort')[0]) {
    document.getElementsByClassName('select-box-genre-sort')[0].addEventListener('change', function () {
      const hidden_elem = document.getElementsByClassName('item-genre');
      for (let i = 0; i < hidden_elem.length; i++) {
        const elem = hidden_elem[i];
        elem.style.display = "none";
      }
      if (this.value != "") {
        const IdNum = `item-genre-${this.value}`;
        const target_elem = document.getElementById(IdNum);
        target_elem.style.display = "block";
      } else {
        for (let i = 0; i < hidden_elem.length; i++) {
          const elem = hidden_elem[i];
          elem.style.display = "block";
        }
      }
    });
  }

  // item#new > タグ入力
  if (document.getElementById('tag-input-now')) {
    document.getElementById('tag-input-now').addEventListener('change', function () {
      const tag_count = document.getElementsByClassName('tags').length;

      // タグを表示するためのdiv要素を生成
      const tagElem = document.createElement('div');
      tagElem.setAttribute('class', "tag-element");

      // 新しいタグの入力要素を生成
      const new_tag = document.createElement('input');
      new_tag.setAttribute('class', 'tags');
      new_tag.setAttribute('name', 'item_options[tags][]');
      new_tag.setAttribute('type', 'text');
      new_tag.value = this.value; // 新しい要素に値を入力
      this.value = ''; // 元のフィールドから値を削除

      // 削除ボタンの生成
      const del_btn = document.createElement('input');
      del_btn.type = 'button';
      del_btn.value = '✕';
      del_btn.setAttribute('onclick', `this.parentNode.remove()`);

      // 要素をブラウザに表示
      tagElem.appendChild(new_tag);
      tagElem.appendChild(del_btn);
      this.before(tagElem);
    });
  }

  // message_rooms#index > 連絡相手削除
  if (document.querySelectorAll('.user-del')) {
    const trigger = document.querySelectorAll('.user-del');
    trigger.forEach(function (target) {
      target.addEventListener('click', function (e) {
        e.preventDefault();
        if (window.confirm('ユーザーをリストから削除すると、そのユーザーとの全てのメッセージも削除されます。\n本当によろしいですね？')) {
          this.previousElementSibling.click();
        }
      });
    });
  }

  // permits#new > 認証画像送信
  if (document.getElementById('image-select-sub')) {
    let item_id = [];
    const renderDom = document.getElementById('image-select');
    const trigger = document.getElementById('image-select-sub');
    trigger.addEventListener('click', function (e) {
      e.preventDefault();
      // 選択されたチェックボックスを取得
      const elems = document.querySelectorAll('[name="permit_image[item_id]"]:checked');
      elems.forEach(function (e) {
        // チェックボックスのバリュー取得
        const id = e.value;
        // 隠しパラメータとして埋め込み要素作成
        const idsObj = `<input value="${id}" name='item_ids[]' type="hidden">`;
        // 埋め込み
        renderDom.insertAdjacentHTML("beforeend", idsObj);
      });
      // フォームをサブミット
      renderDom.submit();
    });
  }


});
