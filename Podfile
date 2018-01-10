platform :ios, '9.0'

def shared_pods 

  pod 'Tabman', :path => './Tabman.podspec'

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

# target 'TabmanTests' do
#   workspace 'Tabman'
#   project './Sources/Tabman.xcodeproj'

#   use_frameworks!

#   pod 'Pageboy', '~> 2.0'

# end
