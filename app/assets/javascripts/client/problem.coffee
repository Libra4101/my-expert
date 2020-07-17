$(document).on 'turbolinks:load', -> 
  # 編集モード
  $('#problem_edit_mode').on 'click', ->
    $('.cl-problem_show_area').hide()
    $('.cl-problem_edit_area').fadeIn(500);

  # 詳細モード
  $('#problem_show_mode').on 'click', ->
    $('.cl-problem_show_area').fadeIn(500);
    $('.cl-problem_edit_area').hide()
  
  # モード初期設定
  if $('.cl-problem_edit_area').find('.invalid-feedback').length == 0
    $('.cl-problem_show_area').show()
    $('.cl-problem_edit_area').hide()
  else
    $('.cl-problem_show_area').hide()
    $('.cl-problem_edit_area').show()