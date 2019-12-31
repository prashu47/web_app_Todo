# frozen_string_literal: true

class UserProfile < ApplicationRecord
  belongs_to :user
  # for user profile picture
  has_one_attached :avatar
  attr_accessbile :avatar
  has_attached_file :avatar, styles: { tiny: '30x30>', thumb: '50x50>', profile: '100x100>' },
                             default_url: '/assets/images/users/:style/default.png',
                             url: '/assets/images/users/:id/:style/:basename.:extension',
                             path: ':rails_root/public/assets/images/users/:id/:style/:basename.:extension'
  # validation for profile picture
  validates_attachment_size :avatar, less_than: 5.megabytes
  validates_attachment_content_type :avatar, content_type: ['image/jpeg', 'image/png']
end
