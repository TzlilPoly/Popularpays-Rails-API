require 'rails_helper'

RSpec.describe GigPayment, :type => :model do
  it 'Test that initial value of state is pending' do
    creator = Creator.create(first_name: 'first_name', last_name: 'last_name')
    gig = Gig.create(brand_name: 'brand_name', creator_id: creator.id)
    gig_payment = GigPayment.new(gig_id: gig.id)

    expect(gig_payment.state).to be_eql "pending"
  end
end