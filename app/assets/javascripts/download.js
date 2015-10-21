$(document).ready(function() {
  $('#download').click(function(){
     var ids = $(':checked').map(function(){
       return $(this).attr('class')
     })
     var json = JSON.stringify(ids)

    $.ajax({
      method: "POST",
      url: "http://localhost:8080/download",
      data: json
    })
  })
})
