platform :ios, '9.0'

workspace 'Tabman'

use_frameworks!

def shared_pods
  pod 'Pageboy', '~> 0.4.0'
  pod 'PureLayout', '~> 3.0.0'
end

target 'Tabman' do
  project './Sources/Tabman.xcodeproj'
  workspace 'Tabman'
  target 'TabmanTests'

  shared_pods
end

target 'Tabman-Example' do
  project './Example/Tabman-Example.xcodeproj'
  workspace 'Tabman'

  shared_pods
end
