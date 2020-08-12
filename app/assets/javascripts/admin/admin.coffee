$(document).on 'turbolinks:load', -> 
  $('.btn-modal-job').on 'click', ->
    btnIndex = $('.btn-modal-job').index(this);
    $('.jobModal').eq(btnIndex).modal();

  $('.btn-modal-trouble').on 'click', ->
    btnIndex = $('.btn-modal-trouble').index(this);
    $('.troubleTagModal').eq(btnIndex).modal();