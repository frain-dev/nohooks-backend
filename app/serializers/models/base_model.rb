module Models
  class BaseModel < ActiveModelSerializers::Model
    attributes :status, :message, :data
  end
end

