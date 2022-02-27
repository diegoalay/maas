def create_user(user_details)
  user = User.find_or_initialize_by(
    first_name: user_details[:first_name],
    last_name: user_details[:last_name],
    email: user_details[:email]
  )

  user.role = user_details[:role]
  user.user_creator = User.first if user.role == "employee"
  user.password = "123456"
  user.save!
end