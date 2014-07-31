$( document ).ready(function(){
  $('#email_event').click(function(e){
    e.preventDefault();
    var $form = $(this).closest('form');
    alert("fas");
    
    $.ajax({
      url: '/emails',
      type: 'POST',
      data: $form.serialize(),
      dataType: 'script',
      success: function(){
       // $form.find('input[id="email_email_address"]').val("");
       alert("RR");
        console.log('Email sent!');
      },
      failure: function(){alert('Email could not be sent!');}

    });
  });
});