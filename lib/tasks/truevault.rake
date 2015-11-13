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
  
  desc "Add name index schema to the vault"
  task :name_index => :environment do
    schema = {
       name: "name",
       fields: [
          {
             name: "Name",
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
            "type": "wildcard",
            "value": "123*",
            "case_sensitive": false
        }
      },
      "full_document": true,
      "filter_type": "and",
      "page": 1,
      "per_page": 500
    }
    client = TrueVault::Client.new
    puts "Searching vault..."
    response = client.search_documents(ENV['TV_TEST_VAULT'], search_option)
    puts "Response from TrueVault: #{response}"
  end
  
  desc "Add a document to the vault"
  task :add_document => :environment do
    eu_schema_id = "9d1589cd-5984-4b5f-8b6b-89da46c8985f"
    document = {
      id: "Project_Resident_surveyv3",
      startTime: "2015-11-10T12:33:20.004-05",
      endTime: "2015-11-10T12:37:24.936-05",
      ResEU: "12345",
      ResCluster: "89",
      ResHouseholdID: "Scott",
      Name: "Jonathan",
      Sex: "1",
      Age: "31",
      Examined: "1",
      RightEyeTT: "1",
      OfferedSurgeryRightEye: "0",
      OfferedEpiRightEye: "1",
      ScarringRightEye: "0",
      RightEyeTF: "0",
      RightEyeTI: "0",
      LeftEyeTT: "0",
      LeftEyeTF: "1",
      LeftEyeTI: "0",
      ResNotes: "The sun finally came out today",
      meta: {
        instanceID: "uuid:152b13aa-e8a0-491f-9d3c-65e155090778"
      }
    }
    client = TrueVault::Client.new
    puts "Adding document..."
    response = client.create_document_with_schema(ENV['TV_TEST_VAULT'], document, eu_schema_id)
    puts "Response from TrueVault: #{response}"
  end
  
  desc "Add many documents to the vault"
  task :add_many_documents => :environment do
    eu_schema_id = "9d1589cd-5984-4b5f-8b6b-89da46c8985f"
    client = TrueVault::Client.new
    for i in 1..5000
      if (i % 2) == 1
        name = "Jonathan"
      else
        name = "Michael"
      end
      document = {
        id: "Project_Resident_surveyv3",
        startTime: "2015-11-10T12:33:20.004-05",
        endTime: "2015-11-10T12:37:24.936-05",
        ResEU: "12345",
        ResCluster: "89",
        ResHouseholdID: "Scott",
        Name: name,
        Sex: "1",
        Age: "31",
        Examined: "1",
        RightEyeTT: "1",
        OfferedSurgeryRightEye: "0",
        OfferedEpiRightEye: "1",
        ScarringRightEye: "0",
        RightEyeTF: "0",
        RightEyeTI: "0",
        LeftEyeTT: "0",
        LeftEyeTF: "1",
        LeftEyeTI: "0",
        ResNotes: "The sun finally came out today",
        meta: {
          instanceID: "uuid:152b13aa-e8a0-491f-9d3c-65e155090778"
        }
      }
      puts "Adding document..."
      response = client.create_document_with_schema(ENV['TV_TEST_VAULT'], document, eu_schema_id)
      puts "Response from TrueVault: #{response}"
    end
  end
  
end