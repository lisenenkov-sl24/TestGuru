document.addEventListener('turbolinks:load', function () {
  var progressbar = document.getElementById('question_progress');
  if (progressbar) {
    progressbar.querySelector('.progress-bar').style.width =
      100 * Number(progressbar.dataset.numder) / Number(progressbar.dataset.total) + '%';
  }
})