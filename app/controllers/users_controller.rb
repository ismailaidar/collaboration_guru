class UsersController < ApplicationController
  def fetch_users
    users = if params[:userInput].present?
              User.where('email LIKE ?', "#{params[:userInput]}%").limit(5)
            else
              User.none
            end
    render json: users
  end
end
