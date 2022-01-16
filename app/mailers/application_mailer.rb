class ApplicationMailer < ActionMailer::Base
  default from: "mdk@example.com"
  layout "mailer"

  def solitaire_game(options = {})
    options[:subject] = 'Wylosowano gracza, z którym zmierzysz się w pasjansa'
    options[:message] = "Twoim przeciwnikiem w pasjansa będzie #{options[:opponent_full_name]}"

    send_mail(options)
  end

  private

  def send_mail(options)
    options in { subject: subject, to: email, message: message }

    mail(options) do |format|
      format.html { render "mailer/default", locals: { title: subject, message: message  } }
    end
  end
end
