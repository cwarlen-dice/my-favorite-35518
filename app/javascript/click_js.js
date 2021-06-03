window.addEventListener('load', function () {

  // user#show > profileの表示切替
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

  // user#show > genreソート
  document.getElementsByClassName('select-box-genre-sort')[0].addEventListener('change', function () {
    const IdNum = `item-genre-${this.value}`;

    if (this.value != "") {
      try {
        if (document.getElementById(IdNum)) {
          const target_elem = document.getElementById(IdNum);
          const hidden_elem = document.getElementsByClassName('item-genre');
          for (let i = 0; i < hidden_elem.length; i++) {
            const elem = hidden_elem[i];
            if (elem != target_elem) {
              elem.style.display = "none";
            }
          }
          target_elem.style.display = "block";
        }
        else {
          throw new Error(`${IdNum}はありません`);
        }
      }
      catch (e) {
      }
    } else {
      console.log('value');
      const hidden_elem = document.getElementsByClassName('item-genre');
      for (let i = 0; i < hidden_elem.length; i++) {
        const elem = hidden_elem[i];
        elem.style.display = "block";
      }
    }
  });


});
