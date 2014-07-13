class Api::CategoryController < ApplicationController
	skip_before_filter :verify_authenticity_token

	before_filter :fetch_category, :except => [:index, :create]

	def fetch_category
		@category = Category.find(params[:id])
	end

	def index
		@categories = Category.all
		respond_to do |format|
			format.json { render json: @categories }
			format.xml { render xml: @categories }
		end
	end

	def show
		respond_to do |format|
			format.json { render json: @category }
			format.xml { render xml: @category }
		end
	end

	def create
		@category = Category.new(category_params)
		respond_to do |format|
			if @category.save
				format.json { render json: @category, status: :created }
				format.xml { render xml: @category, status: :created }
			else
				format.json { render json: @category.errors, status: :unprocessable_entity }
				format.xml { render xml: @category.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			if @category.update_attributes(category_params)
				format.json { head :no_content, status: :ok }
				format.xml { head :no_content, status: :ok }
			else
				format.json { render json: @category.errors, status: :unprocessable_entity }
				format.xml { render xml: @category.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		respond_to do |format|
			if @category.destroy
				format.json { head :no_content, status: :ok }
				format.xml { head :no_content, status: :ok }
			else
				format.json { render json: @category.errors, status: :unprocessable_entity }
				format.xml { render xml: @category.errors, status: :unprocessable_entity }
			end
		end
	end

	private
	    # Using a private method to encapsulate the permissible parameters is
	    # just a good pattern since you'll be able to reuse the same permit
	    # list between create and update. Also, you can specialize this method
	    # with per-user checking of permissible attributes.
	    def category_params
	    	params.permit(:name)
	    end

end
