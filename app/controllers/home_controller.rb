class HomeController < ApplicationController
  def index
  end

  def submission
    data = params[:xml_submission_file]

    puts '!----------@@----------!'
    puts data
    puts '!----------@@----------!'
  end
end
