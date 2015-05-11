object false

child(:@conversations) do
  extends 'api/v1/conversations/show'
end

node(:_links) do
  paginate @conversations
end
