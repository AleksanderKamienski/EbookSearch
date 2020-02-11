require 'pirata'
require 'kaminari'
class SearchController < ApplicationController

	def index
		search_result = PirateBaySearch.new(params[:search]).search
		@description = GoodreadsSearch.new(params[:search]).search
		params[:search] ? @books = Kaminari.paginate_array(search_result).page(params[:page]).per(5):
		@books = Kaminari.paginate_array([]).page(1).per(1)
	end

end

