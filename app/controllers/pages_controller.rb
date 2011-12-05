class PagesController < ApplicationController
  def home
    @title = "Home"
  end

  def contact
    @title = "Contact"
  end

  def about
    @title = "About"
  end

  def help
    @title = "Help"
  end
  def manageadmin
	if params!=nil and params[:id]!=nil
		user=User.find(params[:id])
		user.isadmin=not(user.isadmin)
		user.save
	end
  end
end
