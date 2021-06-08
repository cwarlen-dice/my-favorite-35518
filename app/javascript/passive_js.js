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


});
