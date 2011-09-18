# Global javascript hooks for UI.

$(document).ready ->
  $(".rollup").delay(3000).slideUp(500) if $(".rollup")
