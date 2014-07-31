$( document ).ready(function(){
  $('#event_email').click(function(e){
    e.preventDefault();
    var $form = $(this).closest('form');
    $.ajax({
      url: '/emails',
      type: 'POST',
      data: $form.serialize(),
      dataType: 'script',
      success: function(){
        $form.find('input[id="email_email_address"]').val("");
        console.log('Email sent!');
      },
      failure: function(){alert('Email could not be sent!');}
    });
  });
});