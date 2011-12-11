//= require jquery

var Scheduler = Scheduler || {};

Scheduler.form = {};

Scheduler.form.init = function(form, startDate) {
  Scheduler.form.current = form;

  Scheduler.form.showFrequency(form.find("select.scheduler-frequency").val());

  form.on("change", "select.scheduler-frequency", function(){
    Scheduler.form.showFrequency($(this).val());
  });
}

Scheduler.form.showFrequency = function(value) {
  form = Scheduler.form.current;

  form.find("#scheduler-options").children("div").hide();
  form.find("#scheduler-frequency-" + value ).show();
}
