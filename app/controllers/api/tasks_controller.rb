class Api::TasksController < Api::BaseController

  def index
    tasks = current_user.tasks.page(page).per(limit)
    render_response tasks
  end

  def show
    render_response current_user.tasks.find(params[:id])
  end

  def create
    image = Image.find(params[:image_id])
    task = current_user.tasks.create! image: image, params: task_params
    task.callback_url = ENV['HOST'] + "/tasks/#{task.id}"
    task.save!
    TaskWorker.perform_async(task.id)

    render_response task, 201
  end

  def update
    task = Task.find(params[:id])
    image = JSON.parse(params[:image])
    task.update image
    render_response task, 200
  end

  def destroy
    task = current_user.tasks.find(params[:id])
    task.destroy
    head 204
  end

  private
  def task_params
    image_params = params[:params]

    if image_params.is_a?(Hash)
      image_params.to_json
    else
      image_params = {}
      image_params.to_json
    end
  end

end