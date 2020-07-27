$(document).on 'turbolinks:load', -> 

  # コメント投稿モード
  $('#btn_client_comment').on 'click', ->
    $('.cl-problem_comment_post_field').fadeIn(500);
    $('.cl-problem_btn_comment_post_field').hide()