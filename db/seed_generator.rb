require_relative '../config/environment'

users = []
professions = []




tables = {
  :users => users,
  :professions => professions,
}

#  CREATE USERS ========================================
50.times do |id|

	uri = URI.parse("http://api.randomuser.me/?format=json")
	response = Net::HTTP.get_response(uri)
	r = JSON.parse(response.body)

	current_user = r['results'][0]['user']

  users.push({
		:name => current_user['name']['first'] + " " + current_user['name']['last'],
		:email => current_user['email'],
		:avatar => current_user['picture']['large'],
  })
end

#  CREATE PROFESSIONS ========================================
prof_names = [
	"Mechanic",
	"Carpenter",
	"Electrician",
	"Plumber",
	"IT Expert",
	"Home Audio Expert",
	"Programming Expert"
]

prof_names.each do |name|
	professions.push({
			:name => name,
		})
end

yaml = YAML.dump tables

path = File.join(File.dirname(__FILE__), 'seed_data.yaml')
File.write path, yaml
