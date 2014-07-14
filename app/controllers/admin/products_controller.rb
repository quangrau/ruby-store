class Admin::ProductsController < ApplicationController

	# index action
	# TODO: list all products
	def index
		@products = Product.all
	end

	def new
		@category = Category.all
		@product = Product.new
	end

	def edit
		@product = Product.find(params[:id])
		@category = Category.all
	end

	# show action
	# TODO: show product detail
	def show
		@product = Product.find(params[:id])
	end

	def create
		@category = Category.find(params[:category_id])
		@product = @category.products.create(product_params)
		
		redirect_to admin_category_path(@category)
	end

	def update
		@product = Product.find(params[:id])
		@product.update(product_params)
		
		redirect_to admin_product_path(@product)

	end

	def destroy
		
		@product = Product.find(params[:id])
		@product.destroy

		if @product.category.nil?
			redirect_to admin_products_path
		else
			redirect_to admin_category_path(@product.category)
		end
		
	end

	private
	    # Using a private method to encapsulate the permissible parameters is
	    # just a good pattern since you'll be able to reuse the same permit
	    # list between create and update. Also, you can specialize this method
	    # with per-user checking of permissible attributes.
	    def product_params
	    	
	    	params.require(:product).permit(:category_id, :name, :price)
	    end
end
