namespace :truevault do
  
  desc "Add EU index schema to the residents vault"
  task :eu_index => :environment do
    schema = {
       name: "eu",
       fields: [
          {
             name: "ResEU",
             index: true,
             type: "string"
          }
       ]
    }
    client = TrueVault::Client.new
    puts "Creating schema..."
    response = client.create_schema(ENV['TV_TEST_VAULT'], schema)
    puts "Response from TrueVault: #{response}"
  end
  
  desc "Add age index schema to the residents vault"
  task :age_index => :environment do
    schema = {
       name: "age",
       fields: [
          {
             name: "Age",
             index: true,
             type: "string"
          }
       ]
    }
    client = TrueVault::Client.new
    puts "Creating schema..."
    response = client.create_schema(ENV['TV_TEST_VAULT'], schema)
    puts "Response from TrueVault: #{response}"
  end
  
end