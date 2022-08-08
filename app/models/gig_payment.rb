class GigPayment < ApplicationRecord
  belongs_to :gig

  include AASM
  aasm column: :state do
    state :pending, :completed

    event :complete do
      transitions :from => :pending, :to => :completed, :if => :pending?, :after => :change_gig_state
    end
  end

  def change_gig_state
    puts "change Gig state to paid"
    self.gig.update('state': 'paid')
  end


  def self.update_gig_payments
    puts "hello world"
    # @gig_payments = GigPayment.all
    # @gig_payments.each do |gig_payment|
    #   if gig_payment.state == "pending"
    #     # gig.update(state: "completed")
    #     # GigPayment.update(gig_id: gig.id, state: "completed")
    #     gig_payment.complete!
    #   end
    # end
  end

end
