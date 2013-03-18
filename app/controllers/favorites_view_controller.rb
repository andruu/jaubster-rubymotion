class FavoritesViewController < UIViewController
  def viewDidLoad
    titleView = UILabel.alloc.initWithFrame [[0, 0], [180, 44]]
    titleView.textAlignment = UITextAlignmentCenter
    titleView.text = "Favorites"
    titleView.textColor = UIColor.whiteColor
    titleView.font = UIFont.fontWithName('Avenir-Heavy', size:18)
    titleView.shadowColor = UIColor.blackColor
    titleView.backgroundColor = UIColor.clearColor
    self.navigationItem.titleView = titleView

    @table = UITableView.alloc.initWithFrame([[0, 0], [320, (480-20)]])
    @table.delegate = self
    @table.dataSource = self

    @table.scrollEnabled = false
    self.view << @table
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end

    cell.textLabel.text = ''

    cell
  end

  def tableView(tableView, numberOfRowsInSection: section)
    0
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  end
end