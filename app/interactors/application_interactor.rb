# frozen_string_literal: true

class ApplicationInteractor
  include Interactor

  def fail_context!(err_object)
    context.fail!(error: err_object)
  end
end
