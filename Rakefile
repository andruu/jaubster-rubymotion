# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")

require 'motion/project'
require 'bundler'
Bundler.setup
Bundler.require

require 'bubble-wrap/all'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'Jaubster'
  app.icons = ['Icon.png', 'Icon@2x.png']
  app.prerendered_icon = true
  app.frameworks += ['CoreData', 'CoreLocation', 'MapKit']
  app.pods do
    pod 'SCNetworkReachability'
    pod 'JASidePanels'
    pod 'PHFRefreshControl', '~> 1.0.0'
    pod 'ZAActivityBar', '~> 0.1.1'
    pod 'TDBadgedCell', '~> 2.1'
  end
end
