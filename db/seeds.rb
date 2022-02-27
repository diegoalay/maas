# load tools
load "#{Rails.root}/db/seed/tools.rb"

# load seed depending on the environment
load "#{Rails.root}/db/seed/#{Rails.env.downcase}.rb"
