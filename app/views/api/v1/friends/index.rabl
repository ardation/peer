object false

child(:@friends) do
  extends 'api/v1/friends/show'
end

node(:_links) do
  paginate @friends
end
