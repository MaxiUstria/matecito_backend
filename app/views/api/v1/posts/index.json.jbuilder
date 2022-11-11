json.posts do
  json.array! @posts do |post|
    json.partial! 'info', post:
  end
end
