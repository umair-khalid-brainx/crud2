class OrderMailer < ApplicationMailer
  before_action { puts "========== BEFORE ACTION IN MAILER =========="}
  after_action { puts "========== AFTER ACTION IN MAILER =========="}
  default from: "umair.khalid.brainxtech.test@gmail.com"
  layout "mailer"
  def new_order_email
    @order = params[:order]
    # attachments.inline['image.jpg'] = File.read('app/assets/darth-vader.jpg')
    mail(to: @order.email, subject: "You got a new order!", template_path: 'order_mailer', template_name: 'new_order_email')
    puts "========== Mail sent =========="
  end

  def receive(email)
    order = Order.find_by(address: email.to.first)
    order.emails.create(
      subject: email.subject,
      body: email.body
    )
    if email.has_attachments?
      email.attachments.each do |attachment|
        page.attachments.create({ file: attachment, description: email.subject })
      end
    end
  end
end
