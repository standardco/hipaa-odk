module TrueVault
  private

  #def self.get(key)
  #  TRUEVAULT_CONFIG[Rails.env][key]
  #end
end

module TrueVault
  class Parser < HTTParty::Parser
    SupportedFormats.merge!({"application/octet-stream" => :octet_stream})

    def parse
      case format
        when :html
          body
        when :json
          JSON.parse(body)
        when :octet_stream
          JSON.parse(Base64.decode64(body))
        else
          body
      end
    end
  end
end

module TrueVault
  class Client
    include HTTMultiParty

    base_uri 'https://api.truevault.com'
    parser Parser

    attr_accessor :api_key, :api_version, :account_id, :vault_id

    def initialize()

      #[ :api_key, :api_version, :account_id, :vault_id ].each do |key|

      #  instance_variable_set "@#{key}", (options[key] || TrueVault::get(key))
      #end
    end

    def create(query_key, query_value, options = {})
      options[:query] = { query_key => hash_to_base64_json(query_value) }
      request :post, index_path, options
    end

    def update(id, query_key, query_value, options = {})
      options[:query] = { query_key => hash_to_base64_json(query_value) }
      request :post, show_path(id), options
    end

    def show(id, options = {})
      request :get, show_path(id), options
    end

    def show_document(vault_id, document_id, options = {})
      request :get, show_document_path(vault_id, document_id), options
    end

    def documents_index(vault_id, options = {})
      request :get, documents_index_path(vault_id), options
    end

    def index(options = {})
      request :get, index_path, options
    end

    def create_user(username, password, options = {})
      attributes = { email: "#{username}" }
      attributes = hash_to_base64_json(attributes)
      options[:query] = {
        "username" => username,
        "password" => password,
        "attributes" => attributes
      }
   	  request :post, users_path, options
    end

    def update_user_password(user_id, password, options = {})
      options[:query] = { "password" => password }
      request :put, update_users_path(user_id), options
    end

    # Currently being used to set email as an attribute
    # This will update a user not their documents (which contains all their info)
    def update_user_attr(user_id, email, options = {})
      attributes = { email: "#{email}" }
      attributes = hash_to_base64_json(attributes)
      options[:query] = { "attributes" => attributes }
      request :put, update_users_path(user_id), options
    end

    def create_vault(vault_name, options = {})
      options[:query] = { "name" => vault_name}
      request :post, create_vault_path, options
    end

    def create_document(vault_id, document, options = {})
      document = hash_to_base64_json(document)
      options[:query] = { "document" => document}
      request :post, create_document_path(vault_id), options
    end
    
    def create_document_with_schema(vault_id, document, schema_id, options = {})
      document = hash_to_base64_json(document)
      options[:query] = { document: document, schema_id: schema_id }
      request :post, create_document_path(vault_id), options
    end

    def update_document(vault_id, document_id, document, options = {})
      document = hash_to_base64_json(document)
      options[:query] = { "document" => document}
      request :put, update_document_path(vault_id, document_id), options
    end
    
    def create_schema(vault_id, schema, options = {})
      schema = hash_to_base64_json(schema)
      options[:query] = { 'schema': schema }
      request :post, create_schema_path(vault_id), options
    end
    
    def update_schema(vault_id, schema_id, schema, options = {})
      schema = hash_to_base64_json(schema)
      options[:query] = { 'schema': schema }
      request :put, update_schema_path(vault_id, schema_id), options
    end

    def login(username, password, options = {})
   	   options[:query] = {
        "username" => username,
        "password" => password,
        "account_id" => TRUEVAULT_ACCOUNT_ID
      }
      request :post, login_path, options
    end

    def destroy(id, options = {})
      request :delete, show_path(id), options
    end

    def show_user_schema(options = {})
      request :get, user_schema_path, options
    end

    def create_user_schema(schema, options = {})
      schema = hash_to_base64_json(schema)
      options[:query] = { "schema" => schema }
      request :post, user_schema_path, options
    end

    def update_user_schema(options = {})
      request :put, user_schema_path, options
    end

    def delete_user_schema(options = {})
      request :delete, user_schema_path, options
    end

    def user_search(search_option, options = {})
      search_option = hash_to_base64_json(search_option)
      options[:query] = { "search_option" => search_option }
      request :post, user_search_path, options
    end
    
    def search_documents(vault_id, search_option, options = {})
      search_option = hash_to_base64_json(search_option)
      options[:query] = { "search_option" => search_option }
      request :post, search_documents_path(vault_id), options
    end

    def list_users
      request :get, list_users_path
    end

    private

    def list_users_path
      "/#{TRUEVAULT_API_VERSION}/users"
    end

    def user_search_path
      "/#{TRUEVAULT_API_VERSION}/users/search"
    end

    def user_schema_path
      "/#{TRUEVAULT_API_VERSION}/accounts/#{TRUEVAULT_ACCOUNT_ID}/user_schema"
    end

    def vault_path
      "/#{TRUEVAULT_API_VERSION}/vaults/#{vault_id}"
    end

    def show_path(id)
      "#{index_path}/#{id}"
    end

    def login_path
      "/#{TRUEVAULT_API_VERSION}/auth/login"
    end

    def create_vault_path
    	"/#{TRUEVAULT_API_VERSION}/vaults"
    end

    def show_document_path(vault_id, document_id)
      "/#{TRUEVAULT_API_VERSION}/vaults/#{vault_id}/documents/#{document_id}"
    end

    def documents_index_path(vault_id)
      "/#{TRUEVAULT_API_VERSION}/vaults/#{vault_id}/documents"
    end

    def create_document_path(vault_id, document_id = '')
      "/#{TRUEVAULT_API_VERSION}/vaults/#{vault_id}/documents"
    end

    def update_document_path(vault_id, document_id)
      "/#{TRUEVAULT_API_VERSION}/vaults/#{vault_id}/documents/#{document_id}"
    end
    
    def create_schema_path(vault_id)
      "/#{TRUEVAULT_API_VERSION}/vaults/#{vault_id}/schemas"
    end
    
    def update_schema_path(vault_id, schema_id)
      "/#{TRUEVAULT_API_VERSION}/vaults/#{vault_id}/schemas/#{vault_id}"
    end

    def users_path
      "/#{TRUEVAULT_API_VERSION}/users"
    end

    def update_users_path(user_id)
      "/#{TRUEVAULT_API_VERSION}/users/#{user_id}"
    end
    
    def search_documents_path(vault_id)
      "/#{TRUEVAULT_API_VERSION}/vaults/#{vault_id}/search"
    end

    def default_options
      { basic_auth: { username: TRUEVAULT_API_KEY, password: nil } }
    end

    def hash_to_base64_json(hash = {})
      Base64.encode64(hash.to_json).gsub /\n/, ''
    end

    def request(verb, url, options = {})
      options = default_options.merge(options)
      puts options
      puts verb
      puts url
      response = HashWithIndifferentAccess.new self.class.send(verb, url, options)

      puts response

      return response
    end
  end
end

module TrueVault
  class Document < Client
    def create(data, options = {})
      super(:document, data, options)
    end

    def update(id, data, options = {})
      super(id, :document, data, options)
    end

    private

    def index_path
      "#{vault_path}/documents"
    end
  end
end

module TrueVault
  class Vault < Client



    private

    def index_path
      "/#{TRUEVAULT_API_VERSION}/accounts/#{TRUEVAULT_ACCOUNT_ID}/vaults"
    end
  end
end

module TrueVault
  class Schema < Client
    # Optional:  specify :schema_id in options to enable searching
    def create(schema, options = {})
      super(:schema, schema, options)
    end

    def update(id, schema, options = {})
      super(id, :schema, schema, options)
    end

    def search(search_option = {}, options = {})
      url = "#{vault_path}/?search_option=#{hash_to_base64_json search_option}"
      request :get, url, options
    end

    private

    def index_path
      "#{vault_path}/schemas"
    end
  end
end
