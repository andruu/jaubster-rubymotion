class HelpViewController < UIViewController

  def loadView
    self.view = UIWebView.alloc.initWithFrame [[0, 0], [320, 460]]
    self.view.delegate                 = self
    path = NSBundle.mainBundle.pathForResource('html/help', ofType: 'html')
    url  = NSURL.fileURLWithPath(path)
    self.view.loadRequest NSURLRequest.requestWithURL(url)
  end

  def viewDidLoad
    titleView = UILabel.alloc.initWithFrame [[0, 0], [180, 44]]
    titleView.textAlignment = UITextAlignmentCenter
    titleView.text = "Help"
    titleView.textColor = UIColor.whiteColor
    titleView.font = UIFont.fontWithName('Avenir-Heavy', size:18)
    titleView.shadowColor = UIColor.blackColor
    titleView.backgroundColor = UIColor.clearColor
    self.navigationItem.titleView = titleView
  end

end