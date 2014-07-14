class Admin::CategoryController < ApplicationController
	
	require 'rest_client'

	USERNAME = "quangrau" # needed to access the APi
	PASSWORD = "123456" # needed to access the APi
	API_BASE_URL = "http://api.ruby-store.dev:3000" # base url of the API

	# index action
	# TODO: list all categories
	def index
		uri = "#{API_BASE_URL}/category" # specifying json format in the URl

	    rest_resource = RestClient::Resource.new(uri, USERNAME, PASSWORD)

	    categories = rest_resource.get

	    @categories = JSON.parse(categories, :symbolize_names => true)
	end

	# show action
	# TODO: show category detail, list all products in this category 
	def show
		@category = Category.find(params[:id])
	end

	#new action
	# show form to create a new category
	def new
		@category = Category.new
	end

	def edit
		@category = @category = Category.find(params[:id])
	end

	def create
		@category = Category.new(category_params)

		if @category.save
			redirect_to @category
		else
			render 'new'
		end
	end

	def update
		@category = Category.find(params[:id])

		if @category.update(category_params)
			redirect_to @category
		else
			render 'edit'
		end
	end

	def destroy
		@category = Category.find(params[:id])
		@category.destroy

		redirect_to admin_category_index_path
	end

	private
	    # Using a private method to encapsulate the permissible parameters is
	    # just a good pattern since you'll be able to reuse the same permit
	    # list between create and update. Also, you can specialize this method
	    # with per-user checking of permissible attributes.
	    def category_params
	    	params.require(:category).permit(:name)
	    end

end
