class SeedCategories < ActiveRecord::Migration[7.0]
  def up
    categories = %w[art cosplay writing design podcast development healthcare
                    streaming education investments miscellaneous bussiness music photography
                    videos gaming sports travel food_and_drinks charity pets home fashion beauty
                    cars technology books comics movies youtube community news politics software
                    hardware influencers blog social_media theater]
    categories.each do |category|
      Category.create(name: category)
    end
  end

  def down
    Category.delete_all
  end
end
