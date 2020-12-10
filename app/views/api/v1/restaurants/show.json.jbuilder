json.restauranti do
  json.fucku do
    json.extract! @restaurant, :id, :name, :address
    myname
  end
end

json.comments @restaurant.comments do |comment|
  json.extract! comment, :id, :content
  json.user do
    json.id comment.user.id
    json.email comment.user.email
  end
end
