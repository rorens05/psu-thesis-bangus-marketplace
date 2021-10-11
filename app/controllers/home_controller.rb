class HomeController < ApplicationController
  before_action :authenticate_user!

  layout 'dashboard'

  def index;
    # redirect_to admin_dashboard_path
  end

end
