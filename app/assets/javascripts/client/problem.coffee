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
  if $('.cl-problem_edit_area').find('.invalid-feedback').length != 0
    $('.cl-problem_show_area').hide()
    $('.cl-problem_edit_area').show()


  # 削除確認ダイアログ
  $('#deletebtn_problem').on 'click', ->
    $('#confirm-delete').modal()

  # コメント投稿モード
  $('#btn_client_comment').on 'click', ->
    $('.cl-problem_comment_post_field').fadeIn(500);
    $('.cl-problem_btn_comment_post_field').hide()

  if $('.cl-problem_comment_area').find('.invalid-feedback').length != 0
    $('.cl-problem_comment_post_field').show()
    $('.cl-problem_btn_comment_post_field').hide()