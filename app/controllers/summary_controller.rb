class SummaryController < ApplicationController
  def info
 	@current_user=current_admin[:email]
  end
end
