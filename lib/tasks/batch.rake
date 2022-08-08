namespace :batch do
  desc "This job changes the state of any pending gig payments to completed every 2 minutes. "
  task change_state: :environment do
    @gig_payments = GigPayment.all
    @gig_payments.each do |gig_payment|
      if gig_payment.state == "pending"
        gig_payment.complete!
      end
    end
  end
end