class UsersController < ApplicationController
    before_action :find_user, only: %i[index]

    def index;end

    private

    def find_user
        @user = User.find(params[:id])
    end
end
