class BaseModelSerializer < ApplicationSerializer
  attributes :status, :message, :data

  def data
    serializer = ActiveModel::Serializer.serializer_for(object.data)
    return {} unless serializer

    return serializer.new(object.data) if object.data.respond_to? :each
    serializer.new(object.data).serializable_hash
  end
end
