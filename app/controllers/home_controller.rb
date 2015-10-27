class HomeController < ApplicationController
  require 'active_support/core_ext'
  require 'nokogiri'

  def index
    truevault = ::TrueVault::Client.new
    doc_list = truevault.documents_index(ENV['TV_TEST_VAULT'])

    @docs = Array.new

    doc_list[:data][:items].each do |d|
      @docs << d[:id]
    end

  end

  def submission
    truevault = ::TrueVault::Client.new

    data = params[:xml_submission_file]

    xml = File.open(data.open).read

    hash = Hash.from_xml(xml)

    response = truevault.create_document(ENV['TV_TEST_VAULT'], hash)

    render nothing: true
  end

  def view_doc
    truevault = ::TrueVault::Client.new
    @response = truevault.show_document(ENV['TV_TEST_VAULT'], params[:id])
  end

end
