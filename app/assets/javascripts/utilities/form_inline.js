$(document).on('turbolinks:load', function () {
  var form_inline_link = $('.form-inline-link');
  if(!form_inline_link.length) return;
  form_inline_link.click(formInlineLinkHandler);

  var errors = document.querySelector('.resource-errors');
  if (errors) {
    var resourceId = errors.dataset.resourceId;
    formInlineHandler(resourceId);
  }

  function formInlineLinkHandler(event) {
    event.preventDefault();

    var testId = this.dataset.testId;
    formInlineHandler(testId);
  }

  function formInlineHandler(testId) {
    var link = document.querySelector('.form-inline-link[data-test-id="' + testId + '"]');
    var $testTitile = $('.test-title[data-test-id="' + testId + '"]');
    var $formInline = $('.form-inline[data-test-id="' + testId + '"]');

    $formInline.toggle();
    $testTitile.toggle();

    if ($formInline.is(':visible')) {
      link.textContent = link.dataset.cancelText;
    } else {
      link.textContent = link.dataset.editText;
    }

  }
});
