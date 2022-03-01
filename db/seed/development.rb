# create users
create_user({first_name: "Diego", last_name: "Alay", email: "diego@maas-system.com", role: "admin"})

# create employees
create_user({first_name: "Ernesto", last_name: "", email: "ernesto@maas-system.com", role: "employee", color: "#f4aa65"})
create_user({first_name: "Bárbara", last_name: "", email: "barbara@maas-system.com", role: "employee", color: "#bc7096"})
create_user({first_name: "Benjamín", last_name: "", email: "benjamin@maas-system.com", role: "employee", color: "#6295e0"})

# create a default service
service = Service.find_or_initialize_by(name: "Recorrido.cl")
service.user_creator = User.first
service.schedule = [{
  start_at: 19,
  end_at: 24,
  status: true
},{
  start_at: 19,
  end_at: 24,
  status: true
},{
  start_at: 19,
  end_at: 24,
  status: true
},{
  start_at: 19,
  end_at: 24,
  status: true
},{
  start_at: 19,
  end_at: 24,
  status: true
},{
  start_at: 10,
  end_at: 24,
  status: true
},{
  start_at: 10,
  end_at: 24,
  status: true
}]

service.save!


puts "FINISHED"