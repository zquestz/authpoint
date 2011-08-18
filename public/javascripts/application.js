// Rollup the errors and notices after a few seconds.
$(document).ready(function() {
  if ($('.rollup')) {
    $('.rollup').delay(3000).slideUp(500);
  }
});