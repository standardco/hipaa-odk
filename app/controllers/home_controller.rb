class HomeController < ApplicationController

  def index

  end

  def forms
    render :content_type => "text/xml"

  end

end
