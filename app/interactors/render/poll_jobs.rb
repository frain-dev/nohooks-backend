module Render
  class PollJobs < ApplicationInteractor
    def call 
      @account = context.account
    end
  end
end
