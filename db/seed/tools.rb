def create_user(user)
  user = User.find_or_create_by!(
    first_name: user[:first_name],
    last_name: user[:last_name],
    email: user[:email],
  )

  user.password = "123456"
  user.save!
end

def create_employee(employee)
  Employee.find_or_create_by!(
    user_creator: User.first,
    first_name: employee[:first_name]
  )
end