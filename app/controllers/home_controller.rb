class HomeController < ApplicationController

  def index
    @data = Form.first
  end

  def forms
    render :content_type => "text/xml"

  end

end
