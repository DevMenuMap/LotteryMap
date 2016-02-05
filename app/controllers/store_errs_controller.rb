class StoreErrsController < ApplicationController
  def index
		@store_errs = StoreErr.all
  end

  def new
		@store = Store.find(params[:store_id])
		@store_err = StoreErr.new
		respond_to do |format|
			format.js { render layout: false }
		end
  end

  def create
		@store_err = StoreErr.new(store_err_params)
		if @store_err.save
			flash.now[:success] = "판매점 오류 신고가 접수되었습니다."
		else
			flash.now[:danger] = "내용을 적어주세요."
		end

		respond_to do |format|
			format.js { render layout: false }
		end
  end

  def destroy
		if StoreErr.find(params[:id]).update(active: false)
			flash[:success] = "success"
		else
			flash[:danger] = "fail"
		end
		redirect_to store_errs_url
  end

	private
		def store_err_params
			params.require(:store_err).permit(:store_id, :email, :content)
		end
end
