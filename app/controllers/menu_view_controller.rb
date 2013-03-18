class MenuViewController < UIViewController

  def nav_items
    [
      {
        title: 'Jobs',
        icon: 'jobs.png',
        controller: 'main'
      },
      {
        title: 'Favorites',
        icon: 'favorites.png',
        controller: 'favorites',
        count: 12
      },
      {
        title: 'Saved Searches',
        icon: 'saved.png',
        controller: 'saved',
        count: Search.where(:saved).eq(true).all.count
      },
      {
        title: 'Recent Searches',
        icon: 'recent.png',
        controller: 'recent',
        count: Search.where(:saved).eq(false).all.count
      },
      {
        title: 'Help',
        icon: 'help.png',
        controller: 'help'
      }
    ]
  end

  def reloadData
    @table.reloadData if @table
  end

  def loadView
    @table = UITableView.alloc.initWithFrame([[0, 0], [320, (480-20)]])
    @table.delegate = self
    @table.dataSource = self
    @table.separatorColor = UIColor.clearColor;

    @table.backgroundColor = UIColor.alloc.initWithPatternImage('left-bg.png'.uiimage)

    @table.scrollEnabled = false
    self.view = @table
  end

  def viewDidLoad

  end

  def tableView(tableview, heightForRowAtIndexPath:indexPath)
    60
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      cell = TDBadgedCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
      cell.textLabel.font = UIFont.fontWithName('Avenir-Heavy', size:16)
      cell.textLabel.textColor = UIColor.whiteColor
      cell.textLabel.shadowColor = UIColor.blackColor
      cell.textLabel.backgroundColor = UIColor.clearColor
      cell.textLabel.shadowOffset = [0, 1]
      bg_image = UIImageView.alloc.initWithFrame([[0, 0], [320, 50]])
      bg_image.image = 'menu-bg.png'.uiimage
      bg_image.alpha = 0.3
      cell.backgroundView = bg_image

      bg_image2 = UIImageView.alloc.initWithFrame([[0, 0], [320, 50]])
      bg_image2.image = 'menu-sbg.png'.uiimage
      bg_image2.alpha = 0.2
      cell.selectedBackgroundView = bg_image2

      cell
    end

    cell.imageView.image = nav_items[indexPath.row][:icon].uiimage
    cell.textLabel.text = nav_items[indexPath.row][:title]


    unless nav_items[indexPath.row][:count].blank?
      cell.badgeString = nav_items[indexPath.row][:count].to_s;
      cell.badgeRightOffset = 80
      cell.badge.radius = 10;
      cell.badge.fontSize = 14
      cell.badgeColor = UIColor.whiteColor
    end

    if indexPath.row == 0
      tableView.selectRowAtIndexPath(indexPath, animated:false, scrollPosition:UITableViewScrollPositionNone)
    end

    cell
  end

  def tableView(tableView, numberOfRowsInSection: section)
    nav_items.count
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    App.delegate.slideController.centerPanel = App.delegate.send("#{nav_items[indexPath.row][:controller]}Controller")
  end
end