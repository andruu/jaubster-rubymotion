class JobsViewController < UIViewController

  def viewDidLoad
    super

    self.navigationItem.titleView = UIImageView.alloc.initWithImage(UIImage.imageNamed('logo.png'))
    self.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithImage(
      'search-icon.png'.uiimage, style:UIBarButtonItemStyleBordered, target:self, action:'search'
    )

    @table = UITableView.alloc.initWithFrame [[0, 0], [320, (480 - 44 - 20)]]
    self.view << @table

    @refresh_control = UIRefreshControl.new
    @refresh_control.addTarget(self, action:'loadDataWrapper', forControlEvents:UIControlEventValueChanged)

    @table.setRefreshControl(@refresh_control)

    @table.dataSource = self
    @table.delegate = self

    @data = []

    setLocation

    if @location_manager.location.respond_to? 'coordinate'
      @lat = @location_manager.location.coordinate.latitude
      @long = @location_manager.location.coordinate.longitude
      loadData(lat: @lat, long: @long)
    else
      loadData
    end

  end

  def setLocation(&block)
    if block_given?
      block_given = true
    else
      block_given = false
    end
    @location_manager = CLLocationManager.alloc.init
    @location_manager.desiredAccuracy = KCLLocationAccuracyNearestTenMeters
    @location_manager.startUpdatingLocation
    @location_manager.delegate = self
    @location_manager.stopUpdatingLocation

    @geoCoder = CLGeocoder.alloc.init
    @geoCoder.reverseGeocodeLocation(@location_manager.location, completionHandler:lambda { |placemarks, error|
      return ZAActivityBar.showErrorWithStatus('Connection appears to be offline.') if placemarks.empty?
      placemark = placemarks.first
      if block_given
        block.call(placemark)
      end
    })
  end

  def loadDataWrapper
    if @lat && @long
      loadData(lat: @lat, long: @long)
    else
      loadData
    end
  end

  def loadData(options = {}, &block)
    if block_given?
      block_given = true
    else
      block_given = false
    end
    ZAActivityBar.showWithStatus("Loading jobs...")
    GithubJobs.search(options) do |jobs|
      unless jobs.empty?
        ZAActivityBar.showSuccessWithStatus('Jobs loaded successfully!')
        @data = jobs
        @table.refreshControl.endRefreshing
        @table.reloadData
        @table.setContentOffset(CGPointZero, animated:true)
      else
        @table.refreshControl.endRefreshing
        ZAActivityBar.showErrorWithStatus('Connection appears to be offline.')
      end
      if block_given
        block.call
      end
    end
  end

  def search
    App.window.rootViewController.showRightPanel(true)
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier:@reuseIdentifier)
    end

    title = @data[indexPath.row][:title]

    cell.textLabel.text       = title.strip
    cell.textLabel.font       = UIFont.fontWithName('Avenir-Heavy', size:16)
    cell.detailTextLabel.text = @data[indexPath.row][:location].strip
    cell.detailTextLabel.font = UIFont.fontWithName('Avenir-Book', size:12)
    cell
  end

  def tableView(tableView, numberOfRowsInSection: section)
    @data.count
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)

    alert = UIAlertView.alloc.init
    alert.message = "#{@data[indexPath.row]} tapped!"
    alert.addButtonWithTitle "OK"
    alert.show
  end

end

