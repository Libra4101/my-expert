$(document).on 'turbolinks:load', -> 
  $('#datetimepicker').on 'datepicker', ->
    icons: {
      time: 'fa fa-clock',
    }

  $('.timepicker').on 'timepicker', ->
