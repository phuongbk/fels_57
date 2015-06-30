jQuery ->
  $("#filter_form select").change -> window.location = $(this).val()