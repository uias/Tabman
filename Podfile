platform :ios, '9.0'

def example_pods 

  pod 'Tabman', :path => './Tabman.podspec'
  lib_pods

end

def lib_pods

  pod 'Pageboy', '~> 2.3.0'
  pod 'AutoInsetter', '~> 1.2.0'

end

target 'Tabman-Example' do
  workspace 'Tabman'
  project './Example/Tabman-Example.xcodeproj'

  use_frameworks!
  example_pods

end

target 'Tabman-UITests' do
  workspace 'Tabman'
  project './UI Tests/Tabman-UITests.xcodeproj'

  use_frameworks!
  example_pods

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
