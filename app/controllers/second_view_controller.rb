class SecondViewController < UIViewController
  def init
    super

    self.tabBarItem = UITabBarItem.alloc.initWithTitle('Second', image: UIImage.imageNamed('icon'), tag: 4)

    self
  end

  def viewDidLoad
    self.title = 'Second'
  end

  def loadView
    self.view = SecondView.new
    view.switch.addTarget(self, action: :on_action, forControlEvents: UIControlEventValueChanged)
    view.stepper.addTarget(self, action: :stepper_value, forControlEvents: UIControlEventValueChanged)
    view.slider.addTarget(self, action: :slider_value, forControlEvents: UIControlEventValueChanged)
  end

  def on_action
    if view.switch.on?
      puts "You're switch it on."
      @text_label = UILabel.new
      @text_label.text = 'This is hidden no more!'
      @text_label.frame = [[20,300],[300,30]]
      @text_label.textColor = UIColor.blackColor
      view.addSubview(@text_label)
    else
      puts "You're switch it off."
      @text_label.removeFromSuperview
    end
  end

  def stepper_value
    puts view.stepper.value
    view.stepper_label.text = view.stepper.value.to_s
  end

  def slider_value
    puts view.slider.value
    view.slider_label.text = view.slider.value.to_i.to_s
  end
end