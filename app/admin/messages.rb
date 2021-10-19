ActiveAdmin.register_page "Messages" do
  menu priority: 8

  controller do
    skip_before_action :verify_authenticity_token
  end

  page_action :create, method: :post do
    if params[:content].present? || params[:message][:attachment]
      message = Message.create(
        admin_user_id: current_admin_user.id,
        user_id: params[:message][:user_id],
        content: params[:content],
        sender: :admin_user
      )
      message.attachment.attach params[:message][:attachment] if params[:message][:attachment].present?

    end
    
    redirect_to admin_messages_path(user_id: params[:message][:user_id])
  end

  page_action :index, method: :get do
    @user = User.find_by_id(params[:user_id]) || User.all.first
    @users = User.all
    @messages = current_admin_user.messages.where(user_id: @user.id).order(created_at: :desc)
    render do |page|
      page.js {}
    end
  end

  content do
    user = User.find_by_id(params[:user_id]) || User.all.first

    render 'messages', users: User.all, messages: current_admin_user.messages.where(user_id: user.id).order(created_at: :desc), user: user
  end


end