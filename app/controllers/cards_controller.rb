class CardsController < ActionController::Base

  def member_card
    @user = User.find(params[:user_id])
    @image = params[:member_img]

    # pdf_html = render_to_string(template: 'users/member_id.html.erb')
    # pdf = WickedPdf.new.pdf_from_string(pdf_html)
    # send_data pdf, filename: 'file_name.pdf'

    render pdf: 'card', template: 'cards/member_card.html.erb'
  end
end
