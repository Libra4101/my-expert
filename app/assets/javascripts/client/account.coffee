$(document).on 'turbolinks:load', -> 
  $('#btn-modal').on 'click', ->
    $('#withdrawModal').modal()
  
  $(document).on 'turbolinks:render', ->
    if $('.h-adr').length
      new YubinBango.MicroformatDom();

  $('.client_image').on 'change',(e)->
    reader = new FileReader();
    reader.onload = (e)->
      $(".avater_image").attr('src', e.target.result);
    reader.readAsDataURL(e.target.files[0]);