Factory.define :event do |e|
  e.start_at { Time.now }
  e.end_at   { |e| e.start_at + 2.hours }
end
