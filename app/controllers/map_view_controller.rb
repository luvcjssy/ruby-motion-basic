class MapViewController < UIViewController
  attr_accessor :region, :span, :pin
  def init
    super
    self.tabBarItem = UITabBarItem.alloc.initWithTitle('Map', image: UIImage.imageNamed('icon'), tag: 6)
    self
  end

  def loadView
    self.title = 'Map'
    self.view = MKMapView.new
    center_gumi
    @pin = MKPointAnnotation.new
    get_location
  end

  def get_location
    if CLLocationManager.locationServicesEnabled
      @location_manager = CLLocationManager.new
      @location_manager.delegate = self
      @location_manager.requestAlwaysAuthorization
      @location_manager.desiredAccuracy = KCLLocationAccuracyNearestTenMeters
      @location_manager.distanceFilter = 25.0
      @location_manager.startUpdatingLocation
    end
  end

  def center_gumi
    coordinates = CLLocationCoordinate2D.new
    coordinates.latitude = 10.775156
    coordinates.longitude = 106.688028

    @span = MKCoordinateSpan.new
    @span.latitudeDelta = 0.1
    @span.longitudeDelta = 0.1

    @region = MKCoordinateRegion.new
    @region.center = coordinates
    @region.span = @span

    self.view.setRegion(region, animated: true)
  end

  def locationManager(locationManager, didUpdateLocations: locations)
    # puts "Location coordinate = #{locations}"
    current_location = locations.first.coordinate
    puts "Latitude = #{current_location.latitude}"
    puts "Longitude = #{current_location.longitude}"
    @pin.coordinate = current_location
    @pin.title = 'Current Location'
    @pin.subtitle = 'This is where we are.'
    @region.center = current_location
    @region.span = @span
    view.showAnnotations([@pin], animated: true)
    view.setRegion(@region, animated: true)
  end
end