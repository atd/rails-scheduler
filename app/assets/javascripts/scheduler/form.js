Scheduler.form = (function($, undefined) {
  var current;

  var init = function(form, startDate) {
    current = form;

    showFrequency(form.find("select.scheduler-frequency").val());

    form.on("change", "select.scheduler-frequency", function(){
      showFrequency($(this).val());
    });

    if (startDate) {
      var weekDay = (startDate.getDay() + 6) % 7; // monday is 0 in Rails
      var weekDayOrder = Math.floor((startDate.getDate() - startDate.getDay() + 6) / 7);
      if (weekDayOrder > 3) {
        weekDayOrder = -1;
      }

      // check day of week
      form.find('#event_week_days_' + weekDay).attr('checked','checked');

      // init day of month
      form.find('#event_week_day_order').val(weekDayOrder);
      form.find('#event_week_day').val(weekDay);
    }
  };

  var showFrequency = function(value) {
    current.find("#scheduler-options").children("div").hide();
    current.find("#scheduler-options").find("select,input").attr('disabled', 'disabled');

    current.find("#scheduler-frequency-" + value ).show();
    current.find("#scheduler-frequency-" + value ).find("select,input").removeAttr('disabled');
  };

  var reset = function(form) {
    var select = form.find('select.scheduler-frequency');
    select.find('option[value="0"]').prop('selected', true);
    select.change();
  };

  return {
    init: init,
    reset: reset
  };
})(jQuery);
