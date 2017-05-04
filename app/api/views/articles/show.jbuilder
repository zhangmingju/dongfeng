if @article.present?
  json.result 1
  json.article do
    json.slug @article.slug
    json.name @article.name
    json.content @article.content
    json.category @article.category.try(:name)
    json.user @article.user.try(:nick_name)
    json.content_html @article.content_html
    json.hits @article.hits
    json.created_at @article.created_at
  end
else
  json.result 0
end