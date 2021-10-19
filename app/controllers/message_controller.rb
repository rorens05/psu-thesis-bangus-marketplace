class MessageController < ApplicationController
  before_action :authenticate_user!
  before_action :set_navigation_name
  layout 'dashboard'
  skip_before_action :verify_authenticity_token, only: :index

  def index
    @admins = AdminUser.all.order(updated_at: :desc)
    @admin = AdminUser.find_by_id(params[:admin_user_id]) || @admins.first
    @messages = current_user.messages.where(admin_user_id: @admin.id).order(created_at: :desc)
    
    
    render do |page|
      page.html {}
      page.js {}
    end
  end


  def create
    if params[:content].present? || params[:message][:attachment]
      message = Message.create(
        admin_user_id: params[:message][:admin_user_id],
        user_id: current_user.id,
        content: params[:content],
        sender: :user
      )
      message.attachment.attach params[:message][:attachment] if params[:message][:attachment].present?
    end
    redirect_to message_path(admin_user_id: params[:message][:admin_user_id])
  end

  private 

  def set_navigation_name 
    @navigation_name = "message"
  end
end
