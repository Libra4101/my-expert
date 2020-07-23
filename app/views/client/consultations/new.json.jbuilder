json.array!(@events) do |event|
  json.extract! event, :id, :title
  json.start event.start_event_time
  json.end event.end_event_time
end