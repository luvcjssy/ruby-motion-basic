class FavoritesViewController < UIViewController
  def init
    super

    self.tabBarItem = UITabBarItem.alloc.initWithTabBarSystemItem(UITabBarSystemItemFavorites, tag: 3)

    self
  end

  def viewDidLoad
    self.title = 'Favorites'
  end

  def loadView
    self.view = UIView.new
    view.backgroundColor = UIColor.greenColor

    label = UILabel.new
    label.textColor = UIColor.blackColor
    label.frame = [[20,200],[200,30]]
    label.text = 'This is the Favorites Controller'
    view.addSubview(label)
  end
end