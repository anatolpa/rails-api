FactoryGirl.define do
  factory :image do
    attachment { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures', 'files', 'image.jpg')) }
  end
end