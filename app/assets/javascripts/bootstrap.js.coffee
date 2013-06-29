jQuery ->
  $(".popover_field").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()
  $(".dropdown-toggle").dropdown()
  $('.fileupload').fileupload()

  $('#checkall').bind 'click', (event) =>
    if $('#checkall').attr("checked") == true
      $("input:checkbox[@name='pid[]']").each ->
        $(this).attr("checked", false)
    else
      $("input:checkbox[@name='pid[]']").each ->
        $(this).attr("checked", true)


