require 'rails_helper'

RSpec.describe User, type: :model do
  it "can run tests" do
    expect(true).to be true
  end

  it "can create a valid user" do
    valid_user_id = User.last ? ( User.last.id + 1) : 1
    valid_user = User.new(
      id: valid_user_id,
      first_name: 'User',
      last_name: "#{valid_user_id.humanize.capitalize}",
      phone_number: [*0..3, *0..3, *0..4].sample(7).join,
      email: "user#{valid_user_id}@gmail.com",
      username: "user#{valid_user_id.humanize}",
      password: '123456',
      password_confirmation: "123456"
    )
    valid_user.skip_confirmation!
    valid_user.save

    expect(valid_user.valid?).to be true

    valid_user.destroy
  end
end
