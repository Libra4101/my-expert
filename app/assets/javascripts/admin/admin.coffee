$(document).on 'turbolinks:load', -> 
  $('.btn-modal-job').on 'click', ->
    btnIndex = $('.btn-modal-job').index(this);
    $('.jobModal').eq(btnIndex).modal();

  $('.btn-modal-trouble').on 'click', ->
    btnIndex = $('.btn-modal-trouble').index(this);
    $('.troubleTagModal').eq(btnIndex).modal();
  
  $('.expert_image').on 'change',(e)->
    reader = new FileReader();
    reader.onload = (e)->
      $(".avater_image").attr('src', e.target.result);
    reader.readAsDataURL(e.target.files[0]);