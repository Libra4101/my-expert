$(function () {
  $(document).on('turbolinks:load', function () {
    $('#datetimepicker').datetimepicker({
      icons: {
        time: 'fa fa-clock',
      }
    });
    $('#timepicker').datetimepicker({
        format: 'LT'
    });
  });
});
