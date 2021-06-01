window.addEventListener('load', function () {

  // user#show > prorileの表示切替
  document.getElementById('edit-btn').addEventListener('click', function () {
    const elem = document.getElementById('prorile');
    if (elem.style.display == "block") {
      // noneで非表示
      elem.style.display = "none";
    } else {
      // blockで表示
      elem.style.display = "block";
    }
  });


});
