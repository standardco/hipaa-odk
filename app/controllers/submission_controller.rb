class SubmissionController < ApplicationController

  def submission
    identifiers = ["name", "age", "gender"]
    non_identifiers = ["left_eye_tf", "right_eye_tf"]

    truevault = ::TrueVault::Client.new

    data = params[:xml_submission_file]

    xml = File.open(data.open).read

    hash = Hash.from_xml(xml)

    puts '!-----@@-----!'
    pg_data = hash["data"]
    tv_data = hash["data"]

    identifiers.each do |i|
      tv_data = tv_data.dup.except!("#{i}")
    end

    non_identifiers.each do |i|
      pg_data = pg_data.dup.except!("#{i}")
    end

    puts '!-----@@-----!'

    response = truevault.create_document(ENV['TV_TEST_VAULT'], tv_data)

    render nothing: true
  end

  def view_doc
    truevault = ::TrueVault::Client.new
    @response = truevault.show_document(ENV['TV_TEST_VAULT'], params[:id])
  end

  def postgres_submission

  end

end
