  $(function() {    
    $("#checkall").bind('click', (function(){

      if($(this).attr("checked") == true){
        $(this).attr("checked", false);
        $("input[type=checkbox][name='pid[]']").each(function(){    
          $(this).attr("checked", true);    
        });    
      } else {
        $(this).attr("checked", true);
        $("input[type=checkbox][name='pid[]']").each(function(){    
          $(this).attr("checked", false);    
        });    
      }    
    }));    
  });