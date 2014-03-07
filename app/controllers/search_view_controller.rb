class SearchViewController < UIViewController

  def loadView
    self.view = UIWebView.alloc.initWithFrame [[0, 0], [320, 460]]
    self.view.delegate                 = self
    self.view.scrollView.scrollEnabled = false
    self.view.scrollView.bounces       = false
    path = NSBundle.mainBundle.pathForResource('html/search', ofType: 'html')
    url  = NSURL.fileURLWithPath(path)
    self.view.loadRequest NSURLRequest.requestWithURL(url)
  end

  def viewDidLoad
    titleView = UILabel.alloc.initWithFrame [[0, 0], [320, 44]]
    titleView.textAlignment = UITextAlignmentRight
    titleView.text = "Search for Jobs  "
    titleView.textColor = UIColor.whiteColor
    titleView.font = UIFont.fontWithName('Avenir-Heavy', size:18)
    titleView.shadowColor = UIColor.blackColor
    titleView.backgroundColor = UIColor.clearColor
    self.navigationItem.titleView = titleView

    @web_view = UIWebView.alloc.initWithFrame [[0, 0], [320, 460]]
    @web_view.delegate                 = self
    @web_view.scrollView.scrollEnabled = false
    @web_view.scrollView.bounces       = false
    path = NSBundle.mainBundle.pathForResource('html/search', ofType: 'html')
    url  = NSURL.fileURLWithPath(path)
    @web_view.loadRequest NSURLRequest.requestWithURL(url)
  end

  def webView(webView, shouldStartLoadWithRequest:inRequest, navigationType:inType)
    matches = /^myapp:\/\/([a-zA-z0-9_-]+)/.match(inRequest.URL.absoluteString)
    if matches
      search   = webView.stringByEvaluatingJavaScriptFromString('document.getElementById("search").value')
      location = webView.stringByEvaluatingJavaScriptFromString('document.getElementById("location").value')
      method   = matches[1]
      case method
      when 'search'
        Search.create search: search, location: location, saved: 'f' unless search.blank? && location.blank?
        App.delegate.menuController.reloadData
        App.delegate.jobsController.loadData(search: search, location: location) {
          App.delegate.slideController.centerPanel = App.delegate.mainController
        }
      when 'save'
        if search.blank? && location.blank?
          UIAlertView.alert "Enter in a search term or location"
        else
          Search.create search: search, location: location, saved: 't'
          App.delegate.menuController.reloadData
          ZAActivityBar.showSuccessWithStatus('Search saved successfully')
        end
      when 'update-location'
        App.delegate.jobsController.setLocation do |placemark|
          ZAActivityBar.showSuccessWithStatus('Location updated!')
          webView.stringByEvaluatingJavaScriptFromString(
            "document.getElementById('location').value = '#{placemark.locality}, #{placemark.administrativeArea}'"
          )
        end
      end
      false
    end
    true
  end
end