//= require jquery

var Scheduler = Scheduler || {};

Scheduler.form = {};

Scheduler.form.init = function(form, startDate) {
  Scheduler.form.current = form;

  Scheduler.form.showFrequency(form.find("select.scheduler-frequency").val());

  form.on("change", "select.scheduler-frequency", function(){
    Scheduler.form.showFrequency($(this).val());
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
}

Scheduler.form.showFrequency = function(value) {
  form = Scheduler.form.current;

  form.find("#scheduler-options").children("div").hide();
  form.find("#scheduler-options").find("select,input").attr('disabled', 'disabled');

  form.find("#scheduler-frequency-" + value ).show();
  form.find("#scheduler-frequency-" + value ).find("select,input").removeAttr('disabled');
}
