class IncreaseObjectiveCounterJob < ApplicationJob
  queue_as :default

  def perform(user, donation)
    user.objectives.where(state: %w[active goal_reached]).where(
      'end_date >= ? OR end_date is NULL', donation.created_at.to_date
    ).each do |objective|
      increment_current_amount(objective, donation, objective.current_amount)
      rescue ActiveRecord::RecordInvalid => e
        Sentry.capture_exception(e)
        next
    end
  end

  private

  def increment_current_amount(objective, donation, current_amount)
    objective.update!(current_amount: current_amount + donation.amount)
    objective.reached! if objective.current_amount >= objective.target_amount && objective.active?
  end
end
