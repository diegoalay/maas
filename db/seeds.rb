#  load tools
load Rails.root.join('db/seed/tools.rb')

#  load seed depending on the environment
load Rails.root.join("db/seed/#{Rails.env.downcase}.rb")
