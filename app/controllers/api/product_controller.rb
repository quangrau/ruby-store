class Api::ProductController < ApplicationController
	http_basic_authenticate_with :name => "quangrau", :password => "123456"
	
	# skip_before_filter :verify_authenticity_token

	before_filter :fetch_product, :except => [:index, :create]

	def fetch_product
		@product = Product.find(params[:id])
	end

	def index
		@products = Product.all
		respond_to do |format|
			format.json { render json: @products }
			format.xml { render xml: @products }
		end
	end

	def show
		respond_to do |format|
			format.json { render json: @product }
			format.xml { render xml: @product }
		end
	end

	def create
		@product = Product.new(product_params)
		respond_to do |format|
			if @product.save
				format.json { render json: @product, status: :created }
				format.xml { render xml: @product, status: :created }
			else
				format.json { render json: @product.errors, status: :unprocessable_entity }
				format.xml { render xml: @product.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			if @product.update_attributes(product_params)
				format.json { head :no_content, status: :ok }
				format.xml { head :no_content, status: :ok }
			else
				format.json { render json: @product.errors, status: :unprocessable_entity }
				format.xml { render xml: @product.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		respond_to do |format|
			if @product.destroy
				format.json { head :no_content, status: :ok }
				format.xml { head :no_content, status: :ok }
			else
				format.json { render json: @product.errors, status: :unprocessable_entity }
				format.xml { render xml: @product.errors, status: :unprocessable_entity }
			end
		end
	end

	private
	    # Using a private method to encapsulate the permissible parameters is
	    # just a good pattern since you'll be able to reuse the same permit
	    # list between create and update. Also, you can specialize this method
	    # with per-user checking of permissible attributes.
	    def product_params
	    	
	    	params.permit(:category_id, :name, :price)
	    end
end
