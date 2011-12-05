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
  def userstats
  end
  def manageadmin
	if user_signed_in? and (current_user.id == User.find(:all,:limit=>1)[0].id )
		if params!=nil and params[:id]!=nil
			user=User.find(params[:id])
			user.isadmin=not(user.isadmin)
			user.save
			if user.isadmin
				noti=' has been granted administartive priviledges.'
			else
				noti=' has lost administartive priviledges.'				
			end
			redirect_to manageadmin_path, notice: 'User '+user.email+noti
		end
	else
		redirect_to home_path,:alert => 'You must be the most senior user to manage Administrative rights'
	end
  end
end
