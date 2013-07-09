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

  $('#clone_btn').click =>
    $('#multiple_form').attr('action', '/products/multiple_clone')
    $('#multiple_form').submit()
  $('#edit_btn').click =>
    $('#multiple_form').attr('action', '/products/multiple_edit')
    $('#multiple_form').submit()

