module SchedulerHelper
  def frequency_options
    Scheduler::FREQUENCIES.each_with_index.map{ |value, index|
      [ I18n.t("scheduler.frequency.#{ value }.form.option"), index ]
    }
  end

  def week_day_order_options
    [1, 2, 3, -1 ].map do |d|
      [
        t("scheduler.frequency.monthly.form.week_day_order_option.#{ d }"),
        d
      ]
    end
  end

  def week_day_options
    7.times.map do |d|
      [
        l(Date.today.beginning_of_week + d, :format => "%A"),
        d
      ]
    end
  end
end
