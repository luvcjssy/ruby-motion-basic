class ContactViewController < UIViewController
  attr_accessor :first_name, :phone_number
  def init
    super
    self.tabBarItem = UITabBarItem.alloc.initWithTitle('Contacts', image: UIImage.imageNamed('icon'), tag: 7)
    self
  end

  def loadView
    self.view = UIView.new
    view.backgroundColor = UIColor.whiteColor
    button = UIButton.new
    button.frame = [[20,200],[300,30]]
    button.setTitle('View Contacts', forState: UIControlStateNormal)
    button.setTitleColor(UIColor.blackColor, forState: UIControlStateNormal)
    button.addTarget(self, action: :show_contacts, forControlEvents: UIControlEventTouchUpInside)
    view.addSubview(button)

    @first_name = UILabel.new
    @first_name.text = 'First Name Here'
    @first_name.frame = [[20,100],[300,30]]
    view.addSubview(@first_name)

    @phone_number = UILabel.new
    @phone_number.text = 'Phone Number Here'
    @phone_number.frame = [[20,150],[300,30]]
    view.addSubview(@phone_number)
  end

  def show_contacts
    contacts_controller = CNContactPickerViewController.new
    contacts_controller.delegate = self
    self.presentViewController(contacts_controller, animated: true, completion: nil)
  end

  def contactPicker(picker, didSelectContact: contact)
    @first_name.text = contact.givenName
    if contact.isKeyAvailable(CNContactPhoneNumbersKey)
      @phone_number.text = contact.phoneNumbers.first.value.stringValue.to_s
      puts contact.phoneNumbers.first.value.stringValue
    end
    self.dismissViewControllerAnimated(true, completion: nil)
  end

  def contactPickerDidCancel(picker)
    self.dismissViewControllerAnimated(true, completion: nil)
    puts 'Contact picker Cancelled'
  end
end