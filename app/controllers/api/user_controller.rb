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

Uh thì cuộc sống vốn dĩ đã không công bằng. Nhưng đâu cần phải quá bất công và khốn nạn như vậy nhỉ? 

Mấy tháng trước, mấy anh em còn đi ăn ốc, em kể về những hành trình em đã đi qua, e giành hết tuổi trẻ của mình để làm những công việc thiện nguyện, e mang tri thức, sức trẻ đến với mọi người. Vậy mà ông trời nỡ bắt e rời bỏ mọi người, bỏ lại gia đình, bè bạn, bỏ lại bao ước mơ còn dang dở... Ông trời thật bất công em nhỉ?

Thôi thì coi như đây chỉ là cõi tạm, ai rồi cũng phải đi qua, em đã có một hành trình không dài, nhưng rất đẹp, để giờ đây, mọi người khóc, còn em thì mỉm cười...
