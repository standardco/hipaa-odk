class HomeController < ApplicationController

  def index
    @data = Form.first
  end

  def forms
    puts request.headers.inspect.to_yaml

    # These two headers are required by ODK Collect to pull in the form list
    response.headers['X-OpenRosa-Version'] = '1'
    response.headers['Content-Type'] = 'text/xml; charset=utf-8'

  end

end
