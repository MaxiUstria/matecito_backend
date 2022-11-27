json.user do
  json.partial! 'info', user: @user
  json.social_networks do
    json.array! @user.social_networks do |social_network|
        json.url social_network.url
        json.name social_network.name
    end
  end
  json.donations do
    json.array! Donation.where(beneficiary_id: @user.id).last(10) do |donation|
        json.amount donation.amount
        json.donor donation.donor.username
        json.message donation.message
    end
  end
end