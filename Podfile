platform :ios, '9.0'

def shared_pods 

  pod 'Tabman', :path => './Tabman.podspec'
  pod 'AutoInsetter', :git => 'https://github.com/uias/AutoInsetter'

end

target 'Tabman-Example' do
  workspace 'Tabman'
  project './Example/Tabman-Example.xcodeproj'

  use_frameworks!
  shared_pods

end

target 'Tabman-UITests' do
  workspace 'Tabman'
  project './UI Tests/Tabman-UITests.xcodeproj'

  use_frameworks!
  shared_pods

end

target 'Tabman' do
  workspace 'Tabman'
  project './Sources/Tabman.xcodeproj'

  use_frameworks!
  shared_pods

  target 'TabmanTests' do
    inherit! :search_paths
    # Pods for testing
  end

end
