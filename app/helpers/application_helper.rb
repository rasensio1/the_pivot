module ApplicationHelper

  def dollars(cents)
    number_to_currency(cents.to_f / 100)
  end

end
