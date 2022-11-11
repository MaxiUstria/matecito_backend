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

trophies = [{ name: '10_followers', description: 'Consigue 10 seguidores', category: 'bronze' },
            { name: '100_followers', description: 'Consigue 100 seguidores', category: 'silver' },
            { name: '1000_followers', description: 'Consigue 1000 seguidores', category: 'gold' },
            { name: '10_donations', description: 'Consigue 10 donaciones', category: 'bronze' },
            { name: '100_donations', description: 'Consigue 100 donaciones', category: 'silver' },
            { name: '1000_donations', description: 'Consigue 1000 donaciones', category: 'gold' }]

trophies.each do |trophy|
  Trophy.create(trophy)
end
