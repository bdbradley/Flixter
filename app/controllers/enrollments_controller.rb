class EnrollmentsController < ApplicationController
  before_action :authenticate_user!

  def create
    #Do below if course premium
    if current_course.premium?

    # Amount in cents
    @amount = 500

    customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      source: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      #Sets what value name is when cust charged
      description: 'Flixter Premo Content',
      #Sets amount of course price
      
      currency: 'usd'
    )
  end
    
  current_user.enrollments.create(course: current_course)
  redirect_to course_path(current_course)
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to root_path
  end

  private

  def current_course
    @current_course ||= Course.find(params[:course_id])
  end
end