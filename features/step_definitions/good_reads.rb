require 'rest-client'
require 'nokogiri'
require 'active_record'
require 'books'

When ('Get xml responses from {int} pages with a paginated list of books written by Jack London id {int}') do |pages, id|
  @pages = pages
  @id = id
  @response = []
  for i in 1..@pages.to_i
    @response[i - 1] = ((RestClient.get $rest_url, :params => { :key => $dev_key, :id => @id.to_i, :page => i }))
  end
end

When('Save all information about books to DataBase') do
  resp_parsed = []
  for i in 1..@pages
    resp_parsed[i - 1] = Nokogiri::XML(@response[i - 1].body)
    resp_parsed[i - 1].xpath('//book').each do |book|
      book = Books.new(book_id: book.xpath('id').text, title: book.xpath('title').text, author: book.xpath('authors/author/name').text, image_url: book.xpath('image_url').text)
      book.save!
    end
  end
end

Then('Verify that information about {int} books is stored in DataBase') do |int|
  expect(Books.count).to eq(int)
end

Then /^all books are written by (.*)$/ do |author_name|
  Books.connection.select_values('SELECT author from books').each do |author|
    expect(author).to eq(author_name)
  end
end

When('Get response from {int} page') do |int|
  @neg_response = ((RestClient.get $rest_url, :params => { :key => $dev_key, :id => @id.to_i, :page => int }))
end

Then('Verify that no books are present') do
  neg_resp_parsed = Nokogiri::XML(@neg_response.body)
  expect(neg_resp_parsed.xpath('//book').count).to eq(0)
end
