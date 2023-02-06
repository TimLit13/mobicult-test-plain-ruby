class Player
  class << self
    attr_accessor :players
  end

  attr_reader :first_name, :last_name
  attr_accessor :team

  @players = []

  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
    @team = nil

    Player.players.push(self)
  end
end
