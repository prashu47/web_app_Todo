# frozen_string_literal: true

class ShareController < ApplicationController
  # calling create share from share model
  def create_share
    share = Share.create_share(params)
  end
  # params

  private

  def share_params
    params.require(:share).permit(:id).merge(id: current_user.id)
  end
end
