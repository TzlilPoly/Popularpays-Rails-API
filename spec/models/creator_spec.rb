require 'rails_helper'

RSpec.describe Creator, :type => :model do
  it 'Test Creator Obj Creation' do
    creator = Creator.new('first_name': "Tzlil", 'last_name': 'Pol')
    expect(creator.first_name).to be_eql "Tzlil"
    expect(creator.last_name).to be_eql "Pol"
  end
end