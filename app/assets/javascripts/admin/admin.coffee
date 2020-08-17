$(document).ready ->
  $(document).on 'turbolinks:render', ->
    if $('.h-adr').length
      new YubinBango.MicroformatDom();

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

  $('a[data-toggle="tab"').on 'shown.bs.tab', (e)->
    activated_tab = e.target
    edit_url
    switch activated_tab.id
      when "expert-tab"
        edit_url = $('#edit_path_expert')[0].value
      when "office-tab"
        edit_url = $('#edit_path_office')[0].value
    $('#btn-edit').attr('href', edit_url)