# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview
  def new_order_email
    # Set up a temporary order for the preview
    order = Order.new(name: "Zubair Khalid", email: "umair.khalid@brainxtech.com", address: "PIA Housing Society, Lahore", phone: "03200767431", message: "I want to place an order!")

    OrderMailer.with(order: order).new_order_email
  end
end
