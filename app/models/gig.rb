class Gig < ApplicationRecord
  belongs_to :creator
  has_one :gig_payment

  include AASM
  aasm column: :state do
    state :applied, :accepted, :completed, :paid

    event :complete do
      # before do
      #   puts "Current state: #{aasm.current_state}"
      # end
      # after do
      #   puts "New state: #{aasm.current_state}"
      # end
      # from : current state
      # to : the new state
      # if : only if current state is what after if
      # transitions :from => :applied, :to => :accepted, :if => :applied?
      transitions :from => [:applied, :accepted], :to => :completed, :after => :generate_gig_payment
    end

    # event :pay do
    #   transitions :from => :completed, :to => :paid, :if => :completed?
    # end

  end

  def generate_gig_payment
    puts "create gig payment gig_id: #{self.id}"
    GigPayment.create('gig_id': self.id)
  end

end



