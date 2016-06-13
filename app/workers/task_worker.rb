class TaskWorker
  include Sidekiq::Worker

  sidekiq_options queue: 'tasks'

  def perform(id)
    task = Task.find id
    task.process_image!
    options = {
        body: task
    }
    url = ENV['IMAGE_PROCESSING_HOST'] + '/tasks'
    HTTParty.post(url, options)
  end

end