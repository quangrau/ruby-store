class Admin::CategoryController < ApplicationController
	# skip authenticate 
	skip_before_filter :verify_authenticity_token

	# constructor
	#before_filter :fetch_category, :except => [:index, :create, :new]

	# return obj Category by params :id
	def fetch_category
		@category = Category.find(params[:id])
	end

	# index action
	# TODO: list all categories
	def index
		@categories = Category.all
	end

	# show action
	# TODO: show category detail, list all products in this category 
	def show
		@category = Category.find(params[:id])
		@product = Product.new
	end

	#new action
	# show form to create a new category
	def new
		@category = Category.new
	end

	#edit action
	#show form to update category info
	def edit
		@category = Category.find(params[:id])
	end

	def create
		@category = Category.new(category_params)

		if @category.save
			redirect_to admin_category_path(@category)
		else
			render 'new'
		end
	end

	def update
		@category = Category.find(params[:id])

		if @category.update(category_params)
			redirect_to admin_category_path(@category)
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
