class SalesController < ApplicationController
  def new

      cust=params[:customer]
      if cust
          param=cust[:name]
          @cust_info=Customer.find_by_customer_name(param)
      end
        
      if @cust_info
          @cust_id=@cust_info[:c_id]
      else
        if cust
          new_cust=Customer.new(:customer_name => cust[:name],:contact_no => cust[:contact_no],:address => cust[:address])    
          if new_cust.save
              param=cust[:name]
              @cust_info=Customer.find_by_customer_name(param)
              @cust_id=@cust_info[:c_id]
          end
        end  
      end  

      require 'json'
      if params[:total]
        sale=Sale.new(:total => params[:total], :customer_id => @cust_id)
        sale.save   
      end    
      h = JSON.parse params[:cart] rescue {} 
      h = Array(h)
      cart =[]

      h.each do |item|
        h1=item.to_h
        item = StockList.find(h1["item_id"])
        q=(item.stock-h1["quantity"]).to_i
        item.update(stock: q)

        @item=SalesDetail.new(:sale_id =>sale.sale_no,:stock_list_id => h1["item_id"],:quantity =>h1["quantity"])
        @item.save
      end
  end

  def bill
  end

  def displaybill
  end

  def search
      param=params[:ItemName]
      @items=StockList.where("item_name like ?", "#{param}%")    
  end 

  def search_customer
      param=params[:search_data]
      @customers=Customer.where("customer_name like ?", "#{param}%")    
  end    

  def displayallsale
      @sales_info=Sale.select("sale_no,customer_id,total,sales.created_at,customer_name").joins{customer.outer}.sorted
      @sales_info=@sales_info.page(params[:page]).per(10)        
  end  

  def getsalesinfo
      if params
        p=params[:sale_id]
        sale=SalesDetail.where("sale_id = #{p}")
        @single_sales_info=Array.new
        sale.each do |i|
            single_item={}
            single_item=StockList.find_by_item_id(i.stock_list_id)
            single_item[:stock]=i.quantity
            @single_sales_info.push(single_item)
        end     
      end    
  end  

  def sort

    @sale=Sale.select("sale_no,customer_id,total,sales.created_at,customer_name")
    if params[:sort_type] 
      case params[:sort_type]
        when "1"
          @sales_info=@sale.joins{customer.outer}.sort_by_cost
        when "2"
          @sales_info=@sale.joins{customer.outer}.sort_by_cost_desc
        when "3"
          @sales_info=@sale.joins{customer.outer}.sort_by_date_desc
      end

      if params[:to_date]!="" && params[:from_date]!=""
          @sales_info=@sales_info.where("DATE(sales.created_at) IN (?)",(params[:from_date].to_date)..(params[:to_date].to_date))
      end

      @sales_info=@sales_info.page(params[:page]).per(10)            
    end 

    if params[:filter_type]
      
      case params[:filter_type]
        when "date"
        @sales_info=Sale.select("sale_no,customer_id,total,sales.created_at,customer_name").joins{customer.outer}.sorted            
        @sales_info=@sales_info.where("DATE(sales.created_at) IN (?)",(params[:from_date].to_date)..(params[:to_date].to_date))            
      end

      if params[:sort_type] 
        case params[:sort_type]
          when "1"
            @sales_info=@sales_info.joins{customer.outer}.sort_by_cost
          when "2"
            @sales_info=@sales_info.joins{customer.outer}.sort_by_cost_desc
          when "3"
            @sales_info=@sales_info.joins{customer.outer}.sort_by_date_desc
        end
      end

      @sales_info=@sales_info.page(params[:page]).per(10)                
    end 

    render :layout => false
  end  

end
