$( document ).ready(function(){
  $('#add_to_calendar').click(function(e){
    e.preventDefault();
    var $form = $(this).closest('form');
    $.ajax({
      url: '/emails',
      type: 'POST',
      data: $form.serialize(),
      dataType: 'script',
      success: function(){console.log('Email sent!');},
      failure: function(){alert('Email could not be sent!');}
    });
  });
});