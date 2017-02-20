class PurchaseAccountController < ApplicationController
  def new
      p=params[:purchase_info]
      
      puts @current_user
      if p

          admin_info=Admin.find_by_email(session[:user])
          remaining_budget=admin_info[:budget].to_i - p[initial_payment].to_i
          if remaining_budget<0  
            # redirect_to(:action => 'error')
          end
          admin_info.update(:budget=>remaining_budget)
          
          company_name=p[:company_name]
          place=p[:place]
          total=params[:total]
          puts "------------in if-------------"
          new_purchase_bill=PurchaseAccount.new(:company_name => company_name,:cost => total,:place =>place,:admin_email=>session[:user])     
          new_purchase_bill.save
        
          initial_payment=p[:initial_payment]
          bill_no=new_purchase_bill.id
          new_payment=PaymentAccount.new(:purchase_account_id => bill_no,:amount => initial_payment,:payment_no => 1)  
          new_payment.save

          require 'json'
          h = JSON.parse params[:cart] rescue {} 
          h = Array(h)
          cart =[]

          h.each do |item|
            h1=item.to_h
            item = StockList.find(h1["item_id"])
            q=(item.stock+h1["quantity"]).to_i
            current_stock=item.stock.to_i
            new_stock=h1["quantity"].to_i

            if current_stock==0
               avg_price=h1["price"].to_i 
            else
                avg_price=((item.price.to_i * current_stock)+(new_stock * h1["price"].to_i))/(new_stock+current_stock)   
            end  

            item.update(stock: q)
            item.update(price: avg_price)

            @item=PurchaseDetail.new(:purchase_account_id =>bill_no,:stock_list_id => h1["item_id"],:quantity =>h1["quantity"],:price => h1["price"])
            @item.save
          end
       end
  end

  def bill
  end

  def displayallpurchase
      @purchases=PaymentAccount.joins{purchase_account.outer}.group("purchase_account_id").select("purchase_accounts.*,sum(amount) as total_payment_done,purchase_account_id").page params[:page]
  end

  def sort
    if params[:filter_type]      
      case params[:filter_type]
        when "date"
        @purchases=PaymentAccount.joins{purchase_account.outer}.group("purchase_account_id").select("purchase_accounts.*,sum(amount) as total_payment_done,purchase_account_id")
        @purchases=@purchases.where("DATE(purchase_accounts.created_at) IN (?)",(params[:from_date].to_date)..(params[:to_date].to_date))            
      end
    end  
      
    if params[:sort_type]
      @purchases=PaymentAccount.joins{purchase_account.outer}.group("purchase_account_id").select("purchase_accounts.*,sum(amount) as total_payment_done,purchase_account_id") 
      case params[:sort_type]
        when "1"
              @purchases=@purchases.sort_by_cost    
        when "2"
              @purchases=@purchases.sort_by_cost_desc
        when "3"
              @purchases=@purchases.sort_by_date_desc      
      end

      if params[:to_date]!="" && params[:from_date]!=""
        @purchases=@purchases.where("DATE(purchase_accounts.created_at) IN (?)",(params[:from_date].to_date)..(params[:to_date].to_date))            
      end
    end
    
    @purchases=@purchases.page(params[:page]).per(10)                
    render :layout => false
  end

  def search
      param=params[:ItemName]
      @items=StockList.where("item_name like ?", "#{param}%")    
  end

  def search_company
      param=params[:search_data]
      @companies=PurchaseAccount.where("company_name like ?", "#{param}%").distinct
  end

  def getpurchaseinfo
      if params
        p=params[:purchase_id]
        purchase=PurchaseDetail.where("purchase_account_id = #{p}")
        @single_purchase_info=Array.new
        purchase.each do |i|
          single_item={}
          
          single_item[:item_name]=StockList.find_by_item_id(i.stock_list_id).item_name
          single_item[:stock]=i.quantity
          single_item[:price]=i.price
          
          @single_purchase_info.push(single_item)
        end 

      end

  end

  def getpaymentinfo

      if params
        p=params[:purchase_id]
        @payment_info=PaymentAccount.where("purchase_account_id = #{p}")
      end
  end

  def addpayment
      if params 
          purchase_payment_detail=PaymentAccount.where("purchase_account_id=#{params[:purchase_id]}")
          payment_no=purchase_payment_detail.length  
          new_payment=PaymentAccount.new(:purchase_account_id => params[:purchase_id],:amount => params[:payment_amount],:payment_no => payment_no)  
          new_payment.save
          
          redirect_to(:action => 'displayallpurchase')
      end 
  end


end
