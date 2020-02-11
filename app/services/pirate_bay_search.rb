# app/services/pirate_bay_search.rb
class PirateBaySearch
	attr_accessor :title
	def initialize(title)
		self.title = title
	end

	def search
		ebooks = []

		if self.title == ''
			return ebooks
		end

		begin
			_search = Pirata::Search.new(self.title, Pirata::Sort::SEEDERS, [Pirata::Category::EBOOKS])
		rescue => error
			ebooks.push(error.inspect)
			return ebooks
		end

		if _search.pages == 0
			for item in _search.results do
				ebooks.push(item.title())
			end
		elsif _search.pages > 0
			for _page in 0..(_search.pages-1) do
				for item in _search.search_page(_page) do
					ebooks.push(item.title())
				end
			end
		end

		return ebooks	
	end
end