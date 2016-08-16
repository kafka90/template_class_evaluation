json.array!(@subjects) do |subject|
  json.name         subject.name
  json.prof         subject.prof
  json.time         subject.time
  json.id           subject.id
  json.division     subject.division
end
