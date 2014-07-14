class Api::UserController < ApplicationController
	skip_before_filter :verify_authenticity_token

	before_filter :fetch_product, :except => [:index, :create]

	def fetch_product
		@user = Product.find(params[:id])
	end

	def index
		@users = Product.all
		respond_to do |format|
			format.json { render json: @users }
			format.xml { render xml: @users }
		end
	end

	def show
		respond_to do |format|
			format.json { render json: @user }
			format.xml { render xml: @users }
		end
	end

	def create
		@user = Product.new(user_params)
		respond_to do |format|
			if @user.save
				format.json { render json: @user, status: :created }
				format.xml { render xml: @user, status: :created }
			else
				format.json { render json: @user.errors, status: :unprocessable_entity }
				format.xml { render xml: @user.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			if @user.update_attributes(user_params)
				format.json { head :no_content, status: :ok }
				format.xml { head :no_content, status: :ok }
			else
				format.json { render json: @user.errors, status: :unprocessable_entity }
				format.xml { render xml: @user.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		respond_to do |format|
			if @user.destroy
				format.json { head :no_content, status: :ok }
				format.xml { head :no_content, status: :ok }
			else
				format.json { render json: @user.errors, status: :unprocessable_entity }
				format.xml { render xml: @user.errors, status: :unprocessable_entity }
			end
		end
	end

	private
	    # Using a private method to encapsulate the permissible parameters is
	    # just a good pattern since you'll be able to reuse the same permit
	    # list between create and update. Also, you can specialize this method
	    # with per-user checking of permissible attributes.
	    def user_params
	    	
	    	params.permit(:category_id, :name, :price)
	    end
end