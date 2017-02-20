class ExpenseAccountController < ApplicationController

  def add
 	
  end

  def display
    puts session[:user]
  	@expenses=ExpenseAccount.sorted
    @expenses=@expenses.page(params[:page]).per(10)
  end

  def update
    @expense=ExpenseAccount.find_by(:e_id =>params[:e_id])
  end

  def create 
    p=params[:expense]
    puts session[:user]
    exp=ExpenseAccount.new(:title=>p[:type],:description =>p[:description],:cost=>p[:cost],:dated=>p[:date],:admin_email=>session[:user])
  	
    admin=Admin.find_by_email(session[:user])

    remaining_budget=admin[:budget]-p[:cost].to_i

    if remaining_budget > 0
        if exp.save
            admin.update_attributes(:budget => remaining_budget)
            redirect_to({:action=>'display'})       
        else	
       	  	redirect_to({:action=>"update"})
        end
    end  
  end	

  def delete
    expense=ExpenseAccount.find_by(:e_id =>params[:e_id])
    expense.destroy
    redirect_to({:action=>'display'})
  end	

  def expense_params 
    params.require(:expense).permit(:cost,:description,:type,:dated)
  end

  def update_expense

    p=params[:expense_account]
    expense=ExpenseAccount.find_by(:e_id =>p[:e_id]);

    if expense.update_attributes({:title=>p[:title],:cost=>p[:cost],:description=>p[:description],:dated=>p[:date]})
      redirect_to(:action=>'display') 
    else
      redirect_to(:action=>'update') 
    end
   
   end

  def sort

    @expenses=ExpenseAccount.select("*") 
    if params[:filter_type]
      case params[:filter_type]
        when "date"
          @expenses=@expenses.where(:dated =>params[:from_date]..params[:to_date])
      end
    end
    
    if params[:sort_type]!=""
      if params[:to_date]!="" && params[:from_date]!=""
        @expenses=@expenses.where(:dated =>params[:from_date]..params[:to_date])
      end
      case params[:sort_type]
        when "1"
          puts params[:sort_type]
          @expenses=@expenses.sort_by_cost      
        when "2"
          @expenses=@expenses.sort_by_cost_desc  
        when "3"
          @expenses=@expenses.sort_by_date_desc
      end
    end
    @expenses=@expenses.page(params[:page]).per(10)      
  end

end
 
