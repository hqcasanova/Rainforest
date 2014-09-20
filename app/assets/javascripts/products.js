$(function() {
  $("#new_review")                        //remember magic for forms: an class/id of "action_controller" is set
    .on('ajax:beforeSend', function() {   //user feedback and re-submit prevention. Event is non-standard from Rails.
      $("input[type='submit']")           
        .val('Saving...') 
        .attr('disabled', 'disabled'); 
    })
    .on('ajax:complete', function() {     //restore previous UI state. Event is non-standard from Rails.
      $("input[type='submit']")
        .val('Create Review')
        .removeAttr('disabled');
    });
});
