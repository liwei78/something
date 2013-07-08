jQuery ->
  $(".popover_field").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()
  $(".dropdown-toggle").dropdown()
  $('.fileupload').fileupload()

  $("#checkall").change =>
    if $('#checkall').is ':checked'
      $("input:checkbox[name='pid[]']").each ->
        $(this).is ':checked', true
    else
      $("input:checkbox[name='pid[]']").each ->
        $(this).is ':checked', false
