class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:index, :about]
  before_action :authenticate_current_user_with_otp!, except: [:about]
  layout 'dashboard'

  def index;
    # redirect_to admin_dashboard_path
  end

  def product

  end

  def receipt
    @no_navbar = true
    @order = Order.find(params[:id])
  end

  def products
    @product = Product.find(params[:id])
    @review = Review.find_by(product_id: params[:id], user_id: current_user.id) || Review.new
    @cart = Cart.find_by(product_id: params[:id], user_id: current_user.id) || Cart.new(product_id: params[:id], user_id: current_user.id, quantity: 1)
  end

  def review
    @product = Product.find(params[:id])
    @review = Review.find_by(product_id: params[:id], user_id: current_user.id) || Review.new(product_id: params[:id], user_id: current_user.id)
    @review.review = params[:review][:review]
    @review.rating = params[:review][:rating]

    if @review.save
      redirect_to home_product_path(@product.id), notice: "Review submitted successfully"
    else
      render :products
    end
  end

  def add_to_cart
    @product = Product.find(params[:id])
    @review = Review.find_by(product_id: params[:id], user_id: current_user.id) || Review.new(product_id: params[:id], user_id: current_user.id)
    @cart = Cart.find_by(product_id: params[:id], user_id: current_user.id) || Cart.new(product_id: params[:id], user_id: current_user.id)
    @cart.quantity = params[:cart][:quantity]
    @cart.price = @cart.quantity.to_s < @product.wholesale_minimum_quantity ? @product.price : @product.wholesale_price
    
    if current_user.user_type != "individual"
      if @cart.quantity.present? &&  @cart.quantity < @product.wholesale_minimum_quantity.to_i
        @cart.errors.add(:quantity, "should be greater than product's minimum wholesale quantity")
      end
    end
    if @cart.errors.count.zero? && @cart.save
      redirect_to home_cart_path, notice: "Product added to cart"
    else
      render :products
    end
  end

  def cart
    @order = Order.new
  end

  def destroy_cart
    Cart.find(params[:id]).destroy
    redirect_to home_cart_path, notice: "Item was removed from the cart list"
  end

  def orders

  end

  def checkout 
    
    @order = Order.new(
      user_id: current_user.id,
      status: "pending",
      note: params[:order][:note],
      contact_number: params[:order][:contact_number],
      address: params[:order][:address]
    )
    if @order.save
      current_user.carts.each do |cart|
        OrderItem.create(
          order_id: @order.id, 
          product_id: cart.product_id, 
          price: cart.price, 
          quantity: cart.quantity
        )
        cart.destroy
      end
      redirect_to orders_path, notice: "Order placed successfully"
    else
      render :cart
    end
  end

  def cancel_order
    @order = Order.find(params[:id])
    @order.update(status: "cancelled")
    redirect_to "/orders", notice: "Order cancelled successfully"
  end

  def about

  end

  def profile

  end

  def update_profile

  end

end
