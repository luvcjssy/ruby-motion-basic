class MainViewController < UIViewController
  def init
    super

    self.tabBarItem = UITabBarItem.alloc.initWithTitle('Second', image: UIImage.imageNamed('icon'), tag: 1)

    self
  end

  def viewDidLoad
    self.title = "Main"
  end

  def loadView
    self.view = MainView.new
    view.top_guide = self.topLayoutGuide
    view.view_constraints

    view.button.addTarget(self,
                          action: :alert_controller,
                          forControlEvents: UIControlEventTouchUpInside)
    view.todo_button.addTarget(self,
                          action: :add_todo,
                          forControlEvents: UIControlEventTouchUpInside)
    right_button = UIBarButtonItem.alloc.initWithTitle('Add', style: UIBarButtonItemStylePlain, target: self, action: :add_todo)
    left_button = UIBarButtonItem.alloc.initWithTitle('Delete', style: UIBarButtonItemStylePlain, target: self, action: nil)
    self.navigationItem.setRightBarButtonItem(right_button, animated: true)
    self.navigationItem.setLeftBarButtonItem(left_button, animated: true)

    manager = AFHTTPSessionManager.new
    manager.GET('https://qrng.anu.edu.au/API/jsonI.php?length=1&type=uint8', parameters: nil, progress: nil,
                success: lambda{|task, response| p response},
                failure: lambda{|task, error| p error.localizedDescription})
  end

  def alert_controller
    @alert_controller = UIAlertController.alertControllerWithTitle('Alert Title',
                                                                   message: 'This is the alert message',
                                                                   preferredStyle: UIAlertControllerStyleAlert)
    ok_action = UIAlertAction.actionWithTitle('OK',
                                              style: UIAlertActionStyleDefault,
                                              handler: Proc.new { |obj| ok_response })
    cancel_action = UIAlertAction.actionWithTitle('Cancel',
                                                  style: UIAlertActionStyleCancel,
                                                  handler: nil)
    @alert_controller.addAction(ok_action)
    @alert_controller.addAction(cancel_action)
    self.presentViewController(@alert_controller, animated: true, completion: nil)
  end

  def ok_response
    puts "You pressed okay!"
  end

  def add_todo
    navigationController.pushViewController(TodoViewController.new, animated: true)
  end
end