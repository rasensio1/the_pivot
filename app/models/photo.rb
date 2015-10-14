class Photo < ActiveRecord::Base

  def standard_price_dollars
    dollars(standard_price)
  end

  def commercial_price_dollars
    dollars(commercial_price)
  end

  private

    def dollars(price)
      price.to_f / 100
    end

end
