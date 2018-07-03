platform :ios, '9.0'

def lib_pods

  pod 'Pageboy', :git => 'https://github.com/uias/Pageboy', :branch => 'pageboy3'
  pod 'AutoInsetter', '~> 1.2.0'
  pod 'SnapKit', '~> 4.0'

end

target 'Tabman-Example' do
  workspace 'Tabman'
  project './Example/Tabman-Example.xcodeproj'

  use_frameworks!
  lib_pods

end

target 'Tabman-UITests' do
  workspace 'Tabman'
  project './UI Tests/Tabman-UITests.xcodeproj'

  use_frameworks!
  lib_pods

  pod 'PureLayout', '~> 3.0'

end

target 'Tabman' do
  workspace 'Tabman'
  project './Sources/Tabman.xcodeproj'

  use_frameworks!
  lib_pods

  target 'TabmanTests' do
    inherit! :search_paths
    # Pods for testing
  end

end
