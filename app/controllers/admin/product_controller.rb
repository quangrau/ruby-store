class Admin::ProductController < ApplicationController

	def index
		@products = Product.all
	end

	def show
		@product = Product.find(params[:id])
	end

	def create
		@product = Product.new(product_params)

		if @product.save
			redirect_to admin_product_path(@product)
		else
			render 'new'
		end
	end

	def update
		@product = Product.new(product_params)

		if @product.update_attributes(product_params)
			redirect_to admin_product_path(@product)
		else
			render 'edit'
		end

	end

	def destroy
		@product = Product.new(product_params)
		@product.destroy

		redirect_to admin_product_index_path
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
