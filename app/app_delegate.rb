class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)

    # Reading file
    # p File.read('positions.json'.resource)

    Search.deserialize_from_file('search.dat')

    # ZAActivityBar.showErrorWithStatus('Internet connection is needed to search!') unless isConnected

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    navigationBar = UINavigationBar.appearance
    navigationBar.setBackgroundImage(UIImage.imageNamed('nav-background.png'), forBarMetrics: UIBarMetricsDefault)
    navigationBar.setTintColor '#003847'.uicolor

    slideController.leftPanel   = menuController
    slideController.centerPanel = mainController
    slideController.rightPanel  = UINavigationController.alloc.initWithRootViewController(SearchViewController.alloc.init)

    slideController.rightPanel.navigationBar.setBackgroundImage(UIImage.imageNamed('nav-background-alt.png'), forBarMetrics: UIBarMetricsDefault)
    slideController.rightPanel.navigationBar.setTintColor '#00a1c6'.uicolor

    @window.rootViewController = slideController

    @window.makeKeyAndVisible
    true
  end

  def isConnected
    reachability = SCNetworkReachability.alloc.initWithHostName('www.google.com')
    if reachability.status == SCNetworkStatusNotReachable
      return false
    else
      return true
    end
  end

  def menuController
    @menuController ||= MenuViewController.alloc.init
  end

  def slideController
    @slide_controller ||= JASidePanelController.alloc.init
  end

  def jobsController
    @jobsController ||= JobsViewController.alloc.init
  end

  def mainController
    @mainController ||= UINavigationController.alloc.initWithRootViewController(jobsController)
  end

  def savedController
    @savedController ||= UINavigationController.alloc.initWithRootViewController(SavedViewController.alloc.init)
  end

  def recentController
    @recentController ||= UINavigationController.alloc.initWithRootViewController(RecentViewController.alloc.init)
  end

  def favoritesController
    @favoritesController ||= UINavigationController.alloc.initWithRootViewController(FavoritesViewController.alloc.init)
  end

  def helpController
    @helpController ||= UINavigationController.alloc.initWithRootViewController(HelpViewController.alloc.init)
  end
end
