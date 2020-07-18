$(document).on 'turbolinks:load', -> 
  $('#btn-modal').on 'click', ->
    $('#withdrawModal').modal()