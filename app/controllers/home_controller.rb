class HomeController < ApplicationController

  def index
    truevault = ::TrueVault::Client.new
    doc_list = truevault.documents_index(ENV['TV_TEST_VAULT'])

    @docs = Array.new

    doc_list[:data][:items].each do |d|
      @docs << d[:id]
    end

  end

  def forms
    render :content_type => "text/xml"

  end

end
