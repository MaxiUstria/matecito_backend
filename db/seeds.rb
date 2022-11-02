AdminUser.create!(email: 'admin@example.com', password: 'password') if Rails.env.development?
Setting.create_or_find_by!(key: 'min_version', value: '0.0')

categories = %w[art cosplay writing design podcast development healthcare
                streaming education investments miscellaneous bussiness music photography
                videos gaming sports travel food_and_drinks charity pets home fashion beauty
                cars technology books comics movies youtube community news politics software
                hardware influencers blog social_media theater]
categories.each do |category|
  Category.create(name: category)
end
