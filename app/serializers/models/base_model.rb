module Models
  class BaseModel < ActiveModelSerializers::Model
    attributes :status, :message, :data, :errors
  end
end

