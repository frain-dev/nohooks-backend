class PollRenderJob < ApplicationJob
  queue_as :render_scheduler

  def perform(*args)
    RenderAccount.all.each do |account|
      PollRenderResourcesJob.perform_later(account.id)
    end
  end
end
