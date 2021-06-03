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




});
