class StockListController < ApplicationController
  def add
  end

  def delete
    if params[:item_id]
      @item=StockList.find(params[:item_id])
    end    
  end

  def display
  	@items=StockList.sorted
    @items=@items.page(params[:page]).per(10)                
    
  end

  def create
  	puts "-----------"
  	p=params[:stock_list]

  	e=StockList.new(:item_name=>p[:item_name],:price =>p[:price],:MRP=>p[:MRP],:expiry_date=>p[:expiry_date],:stock=>p[:stock])
  	if e.save
   	    redirect_to({:action=>'display'})
  	else	
    	redirect_to({:action=>"add"})
    end	
  end	

  def update
  	if params[:item_id]
  		@item=StockList.find(params[:item_id])
      puts "--------------"
      puts @item
  	end

    if params[:stock_list]
        
        @item=StockList.find(params[:item_id])
        p=params[:stock_list]

        if p[:flag]=="1"
            p[:stock]=p[:stock_present].to_i+p[:stock].to_i 
            if @item.update_attributes({:item_name=>p[:item_name],:stock=>p[:stock],:price=>p[:price],:MRP=>p[:MRP],:expiry_date=>p[:expiry_date]})
                redirect_to({:action=>'display'})
            else  
                redirect_to({:action=>"update"})
            end            
        end

        if p[:flag]=="0"
            p[:stock]=p[:stock_present].to_i-p[:stock].to_i 
            if @item.update_attributes({:item_name=>p[:item_name],:stock=>p[:stock],:price=>p[:price],:MRP=>p[:MRP],:expiry_date=>p[:expiry_date]})
                redirect_to({:action=>'display'})
            else  
                redirect_to({:action=>"update"})
            end            
        end
    end

  end	

  def add_stock
      redirect_to({:action=>"display"})
  end   

  def sort
    if params[:sort_type]
      case params[:sort_type]
        when "1"
          @items=StockList.sort_by_price 
        when "2"
          @items=StockList.sort_by_price_desc 
        when "3"
          @items=StockList.sort_by_quantity_desc
        when "4"
          @items=StockList.sort_by_quantity
      end    
    end  
    @items=@items.page(params[:page]).per(10)                
    render :layout => false
  end
    
end
