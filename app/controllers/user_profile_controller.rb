# frozen_string_literal: true

class UserProfileController < ApplicationController
  # method to callback  class method edit_profile
  def edit_profile
    User.edit_profile(current_user)
  end

  # method to updtae user profile feild
  def update_profile
    @update_profile = User.find(current_user.id)
    current_email = @update_profile.update(email: user_profile_params[:email])
    current_name = @update_profile.update(name: user_profile_params[:name])
    current_mobile = @update_profile.update(mobile: user_profile_params[:mobile])
    @update_profile.save
    redirect_to root_path
  end

  # method to callback  class method delete_image_attachment
  def delete_image_attachment
    User.delete_image_attachment(params)
  end

  # method to  callback class method destroy
  def destroy
    User.destroy(current_user)
    redirect_to root_path
  end

  # method to  callback class method show
  def show
    User.show(current_user)
    redirect_to root_path
  end

  # method to  callback class method update_profile_pic
  def update_profile_pic
    User.update_profile_pic(params, current_user)
    redirect_to root_path
  end
    # params

    private

  def user_profile_params
    params.require(:user).permit(:id, :name, :email, :mobile)
  end

    private

  def todo_params
    params.require(:todo).permit(:body).merge(user_id: current_user)
  end
  end
