platform :ios, '9.0'

workspace 'Tabman'

use_frameworks!

target 'Tabman' do
  project './Sources/Tabman.xcodeproj'
  workspace 'Tabman'
  target 'TabmanTests'

  pod 'Pageboy', '~> 0.4.0'
  pod 'PureLayout', '~> 3.0.0'
end

target 'Tabman-Example' do
  project './Example/Tabman-Example.xcodeproj'
  workspace 'Tabman'

  pod 'Tabman', :path => './'
end
