require 'rails_helper'

RSpec.describe Gig, :type => :model do
  it 'Test Gig Obj Creation' do
    gig = Gig.create(brand_name: 'brand', creator_id: '')
    expect(gig.first_name).to be_eql "Tzlil"
    expect(gig.last_name).to be_eql "Pol"
  end

  it 'Test when Gig state is set to completed a gig payment should automatically be created for this gig ' do
    creator = Creator.create(first_name: 'first_name', last_name: 'last_name')
    gig = Gig.create(brand_name: 'brand_name', creator_id: creator.id)
    gig.complete

    gig_payment = GigPayment.find_by(gig_id: gig.id)
    expect(gig_payment).to be_truthy

  end
end