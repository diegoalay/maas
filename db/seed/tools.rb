def create_user(user_details)
  user = User.find_or_initialize_by(
    first_name: user_details[:first_name],
    email: user_details[:email]
  )

  user.assign_attributes({
    color: user_details[:color],
    role: user_details[:role],
    last_name: user_details[:last_name],
    user_creator: user.role == 'employee' ? User.first : nil,
    password: '123456'
  })

  user.save!
end
