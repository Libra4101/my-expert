$(document).on 'turbolinks:load', -> 
  $('.btn-modal').on 'click', ->
    btnIndex = $('.btn-modal').index(this);
    $('.jobModal').eq(btnIndex).modal();