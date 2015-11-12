namespace :truevault do
  
  desc "Add EU index schema to the vault"
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
  
  desc "Add age index schema to the vault"
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
  
  desc "Search documents in the vault"
  task :search_documents => :environment do
    eu_schema_id = "9d1589cd-5984-4b5f-8b6b-89da46c8985f"
    search_option = {
      "filter": {
        "ResEU": {
            "type": "eq",
            "value": "12345",
            "case_sensitive": false
        }
      },
      "full_document": true,
      "filter_type": "and",
      "page": 1,
      "per_page": 3,
      "schema_id": eu_schema_id
    }
    client = TrueVault::Client.new
    puts "Searching vault..."
    response = client.search_documents(ENV['TV_TEST_VAULT'], search_option)
    puts "Response from TrueVault: #{response}"
  end
  
end