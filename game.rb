require 'gosu'
require_relative 'player'
require_relative 'star'
require_relative 'config'


class GameWindow < Gosu::Window
  def initialize
    # Define window size (width, height, fullscreen)
    super 640, 480
    # Name of the window
    self.caption = "My first game"
    @background_image = Gosu::Image.new("media/space.png", :tileable => true)
    # Intagrate player to the window
    @player = Player.new
    @player.warp(320, 240)

    @star_anim = Gosu::Image.load_tiles("media/star.png", 25, 25)
    @stars = Array.new

    @font = Gosu::Font.new(20)
    @close = Gosu::Font.new(20)

  end

  # Define the logical of the game
  def update
    if Gosu.button_down? Gosu::KB_LEFT or Gosu::button_down? Gosu::GP_LEFT
      @player.turn_left
    end
    if Gosu.button_down? Gosu::KB_RIGHT or Gosu::button_down? Gosu::GP_RIGHT
      @player.turn_right
    end
    if Gosu.button_down? Gosu::KB_UP or Gosu::button_down? Gosu::GP_BUTTON_0
      @player.accelerate
    end
    @player.move
    @player.collect_stars(@stars)

    if rand(100) < 4 and @stars.size < 25
      @stars.push(Star.new(@star_anim))
    end
  end

  # Update game and game's events to the window
  def draw
    @background_image.draw(0, 0, ZOrder::BACKGROUND)
    @player.draw
    @stars.each { |star| star.draw }
    @font.draw("Score: #{@player.score}", 10, 10, ZOrder::UI, 1.0, 1.0, Gosu::Color::YELLOW)
    @close.draw("Echap: close", 520, 10, ZOrder::UI, 1.0, 1.0, Gosu::Color::YELLOW)
  end

  def button_down(id)
    if id == Gosu::KB_ESCAPE
      close
    else
      super
    end
  end
end

# Tutorial.new.show

# Start the game
game = GameWindow.new
# Create a window of the game
game.show
