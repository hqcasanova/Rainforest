$(document).on('ready page:load', function() {
  $('<article>', {class: 'placeholder'}).insertAfter(".predecessor");   //additional placeholder for ajax results (for cases where results create new content as opposed to modifying it)
  $('.search-form').submit(function(e) {
    e.preventDefault();                   //cancel form's submit action (progressive enhancement)
    $.getScript('/products?search=' + $('#search').val());  //request products page with partial list according to search form's input
  });

  $("form")                               //remember magic for forms: an class/id of "action_controller" is set
    .on('ajax:beforeSend', function() {   //re-submit prevention. Event is non-standard from Rails.
      $("input[type='submit']").attr('disabled', 'disabled'); 
    })
    .on('ajax:complete', function() {     //restore previous UI state. Event is non-standard from Rails.
      $("input[type='submit']").removeAttr('disabled');
  });
});
