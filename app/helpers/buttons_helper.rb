module ButtonsHelper
  def not_authenticated?(token)
    token.nil?
  end

  def get_button(button)
    Button.find_by(core_id: button["id"])
  end
end
