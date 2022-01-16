class SolitairePlayerObject

  attr_reader :firstname, :lastname, :email

  def initialize(attr = {})
    @firstname = attr[:firstname]
    @lastname = attr[:lastname]
    @email = attr[:email]
  end

  def full_name
    %Q(#{firstname} #{lastname})
  end
end