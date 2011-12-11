module Scheduler
  FREQUENCIES = [ :one_off, :daily, :weekly, :monthly ]

  class << self
    def frequency_options
      FREQUENCIES.each_with_index.map{ |value, index|
        [ I18n.t("scheduler.frequency.#{ value }.form.option"), index ]
      }
    end
  end
end
