FactoryBot.define do
  factory :routine do
    title { "MyString" }
    sequence(:user) { association(:user) }

    before(:create) do |routine|
      routine.avatar.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', 'routine.png')),
        filename: 'routine.png', content_type: 'image/png'
      )
    end
  end
end
