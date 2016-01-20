class SubmissionController < ApplicationController

  def submission
    # identifiers = ["name", "age", "gender"]
    # non_identifiers = ["left_eye_tf", "right_eye_tf"]
    #
    # truevault = ::TrueVault::Client.new

    data = params[:xml_submission_file]

    xml = File.open(data.open).read

    puts '!-----@@-----!'
    puts xml.class

    Form.create(data: xml)

    render nothing: true
  end

  def view_doc

  end

  def postgres_submission

  end

end
