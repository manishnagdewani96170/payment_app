class MerchantsController < ApplicationController
  before_action :set_merchant, only: [:show, :edit, :update, :destroy]

  def index
    @merchants = Merchant.all
  end

  def new
    @merchant_form = Merchants::NewForm.new
  end

  def create
    @merchant_form = Merchants::NewForm.new(merchant_params)

    if @merchant_form.submit
      redirect_to merchant_path(@merchant), notice: 'Merchant created successfully.'
    else
      render(:new)
    end
  end

  def edit
    @merchant_form = Merchants::EditForm.new(merchant: @merchant)
  end

  def show
  end

  def update
    @merchant_form = Merchants::EditForm.new(merchant: @merchant,  params: merchant_params)

    if @merchant_form.submit
      redirect_to merchant_path(@merchant), notice: 'Merchant updated successfully.'
    else
      render(:edit)
    end
  end

  def destroy
    is_deleted = Merchants::DeleteUc.new.execute(merchant: @merchant)
    if is_deleted
      redirect_to merchants_path, notice: 'Merchant deleted successfully.'
    else
      render(:edit)
    end
  end

  private

  def merchant_params
    params.require(:merchant).permit(:name, :email, :description, :status)
  end

  def set_merchant
    @merchant = Merchant.find(params[:id])
  end
end
