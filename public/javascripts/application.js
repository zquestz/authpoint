// Rollup the errors and notices after a couple seconds.
$(document).ready(function() {
  if ($('.rollup')) {
    $('.rollup').delay(2000).slideUp(500);
  }
});