# == Schema Information
#
# Table name: donations
#
#  id             :bigint           not null, primary key
#  amount         :integer          not null
#  currency       :string           default("UY"), not null
#  message        :string
#  beneficiary_id :bigint           not null
#  donor_id       :bigint
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_donations_on_beneficiary_id  (beneficiary_id)
#  index_donations_on_donor_id        (donor_id)
#
class AnonymousDonation < Donation
end
