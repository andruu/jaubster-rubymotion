class RecentViewController < UIViewController

  def loadView
    titleView = UILabel.alloc.initWithFrame [[0, 0], [180, 44]]
    titleView.textAlignment = UITextAlignmentCenter
    titleView.text = "Recent Searches"
    titleView.textColor = UIColor.whiteColor
    titleView.font = UIFont.fontWithName('Avenir-Heavy', size:18)
    titleView.shadowColor = UIColor.blackColor
    titleView.backgroundColor = UIColor.clearColor
    self.navigationItem.titleView = titleView

    @table = UITableView.alloc.initWithFrame([[0, 0], [320, (480-20)]])
    @table.delegate = self
    @table.dataSource = self

    self.view = @table
  end

  def viewDidLoad
    super
  end

  def viewWillAppear(animated)
    super
    @searches = Search.where(:saved).eq(false).all
    self.view.reloadData
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier:@reuseIdentifier)
    end

    if @searches[indexPath.row].search.blank?
      cell.textLabel.text = 'No search term provided'
      cell.textLabel.textColor = '#aaa'.uicolor
    else
      cell.textLabel.text = @searches[indexPath.row].search
      cell.textLabel.textColor = '#000'.uicolor
    end

    if @searches[indexPath.row].location.blank?
      cell.detailTextLabel.text = 'No location provided'
    else
      cell.detailTextLabel.text = @searches[indexPath.row].location
    end

    cell.textLabel.font       = UIFont.fontWithName('Avenir-Heavy', size:16)
    cell.detailTextLabel.font = UIFont.fontWithName('Avenir-Book', size:12)

    cell
  end

  def tableView(tableView, numberOfRowsInSection: section)
    @searches.count
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  end
end