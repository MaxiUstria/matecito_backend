Sentry.init do |config|
  if Rails.env.production?
    config.dsn = 'https://215b5afc2a9f406e9baf1ccea17662b2@o4504057273319424.ingest.sentry.io/4504057320898560'
  end
  config.breadcrumbs_logger = %i[active_support_logger http_logger]

  # Set traces_sample_rate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production.
  config.traces_sample_rate = 1.0
  # or
  config.traces_sampler = lambda do |_context|
    true
  end
end
