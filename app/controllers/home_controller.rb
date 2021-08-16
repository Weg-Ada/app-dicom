class HomeController < ApplicationController
  def index
    if current_user.is_admin
    end
  end
end