class ImageSerializer < BaseSerializer
  attributes :id, :attachment

  def attachment
    object.attachment.url
  end

end