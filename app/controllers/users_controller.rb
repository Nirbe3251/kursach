class UsersController < ApplicationController
    before_action :find_user

    def index;end

    private

    def find_user
        @user = User.find(params[:id])
    end
end
