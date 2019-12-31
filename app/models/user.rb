# frozen_string_literal: true

class User < ApplicationRecord
  # Associstion
  has_one_attached :avatar
  has_one :user_profile
  has_many :shares
  has_many :todos, through: :shares
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # scope
  scope :share_user, ->(id) { joins(:shares).select('user_name,user_id').where('todo_id=?and is_owner=false', id) }

  # method for create new user
  def create
    user = User.create!(user_params)
    session[:user_id] = user.id
    redirect_to root_path
  end

  # class method for update profile
  def self.edit_profile(current_user)
    @edit_profile = User.find(current_user.id)
  end

  # class method for update profile picture
  def self.update_profile_pic(params, current_user)
    @user_profile = User.find(current_user.id)
    @user_profile.avatar.purge_later
    @user_profile.avatar = params[:user][:avatar]
    @user_profile.save
  end

  # class method to remove the attachment
  def self.delete_image_attachment(params) # model callbacks
    @image = ActiveStorage::Blob.find_signed(params[:id])
    @image.avtar.purge
  end

  # class method for delete attachment
  def self.destroy(current_user) # swhift to model
    if current_user.avatar.attached?
      @image = User.find(current_user.id)
      @image.avatar.destroy
   end
  end

  # class method for show
  def self.show(current_user)
    @user_profile = User.find(current_user.id)
  end
  # params

  private

  def user_params
    params.require(:user).permit(:id, :email_address, :password, :avatar)
  end
end
