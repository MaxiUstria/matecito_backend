class UpdateGoalNotReachedObjectivesJob < ApplicationJob
  queue_as :default

  def perform
    Objective.where('end_date < ?',
                    Time.zone.today).where(state: 'active').each(&:not_reached!)
  rescue ActiveRecord::RecordInvalid => e
    Sentry.capture_exception(e)
  end
end
