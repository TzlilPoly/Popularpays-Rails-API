class GigPaymentsController < ApplicationController
  before_action :restrict_gig_payment_access
  before_action :set_gig_payment, only: [:show]

  # GET /gig_payments
  def index
    @gig_payments = GigPayment.all

    render json: @gig_payments
  end

  # GET /gig_payments/1
  def show
    puts "get"
    render json: @gig_payment
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_gig_payment
    @gig_payment = GigPayment.find(params[:id])
  end

  def restrict_gig_payment_access
    if !@api_key.gig_payment_access
      render json: {error: "Authorization failed"}, status: :network_authentication_required
    end
  end
end
