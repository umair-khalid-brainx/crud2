class OrdersController < ApplicationController
  def create
    @order = Order.new(order_params)
    @order.avatar.attach(params[:order][:avatar])
    if @order.avatar.attached?
      puts "==========================ORDER ATTACHED WITH AVATAR================================"
    else
      puts "==========================ORDER NOT ATTACHED WITH AVATAR================================"
    end
    # debugger
    if @order.save
      OrderMailer.with(order: @order).new_order_email.deliver_later

      flash[:success] = "Thank you for your order! We'll get contact you soon!"
      redirect_to root_path
    else
      flash.now[:error] = "Your order form had some errors. Please check the form and resubmit."
      render :new
    end
  end

  def show
    @author = Order.find(params[:id])
  end

  def new
    @order = Order.new
  end

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    # redirect_to Current.order.url
  end

  def destroy
    puts "===============Entered Delete Function==============="
    @order = Order.find(params[:id])
    @order.destroy
    @order.avatar.purge
    redirect_to orders_path, status: :see_other
    puts "===============Left Delete Function==============="
  end

  private
  def order_params
    params.require(:order).permit(:name, :email, :address, :phone, :message, :avatar)
  end
end
