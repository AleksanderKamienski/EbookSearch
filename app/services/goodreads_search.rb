# app/services/goodreads_search.rb
require 'goodreads'
class GoodreadsSearch
	attr_accessor :title
	def initialize(title)
		self.title = title
	end

	def search
		client = Goodreads.new(api_key: ENV["GOODREADS_API_KEY"])
		
		book_info = []

		if self.title == ''
			return []
		end

		begin 
			search1 = client.book_by_title(self.title)
			search2 = client.search_books(self.title)
		rescue
			return []
		else
			begin
				book_info.push(search1.description)
				book_info.push(search2.results.work.first.best_book.author.name)
				book_info.push(search2.results.work.first.best_book.title)
				book_info.push(search2.results.work.first.best_book.image_url)
			rescue 
				return []
			end
		end

		if book_info.length == 4
			return book_info
		else
			return []
		end
	end
end
