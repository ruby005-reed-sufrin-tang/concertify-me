$( document ).ready(function(){
  $('#email_event').click(function(e){
    e.preventDefault();
    var $form = $(this).closest('form');
   var userEmail = $form.find("#email_user_email").val();
  if (userEmail === "" || userEmail === null) {
    //change the div's css
    $("#error_messages_display").css({ "width": "300px", "height": "75px", "display": "table" });
    }

    $.ajax({
      url: '/emails',
      type: 'POST',
      data: $form.serialize(),
      dataType: 'script',
      success: function(){
        console.log('Email sent!');
      },
      failure: function(){
        console.log('Email could not be sent!');
      }
    });
  });
});