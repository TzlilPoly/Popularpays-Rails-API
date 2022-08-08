class GigPaymentSerializer < ActiveModel::Serializer
  attributes :id, :state
  belongs_to :gig
end
