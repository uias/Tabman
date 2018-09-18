platform :ios, '9.0'

def lib_pods

  pod 'Pageboy', :git => 'https://github.com/uias/Pageboy', :branch => 'pageboy3'
  pod 'AutoInsetter', '~> 1.3.0'

end

target 'Tabman-Example' do
  workspace 'Tabman'
  project './Example/Tabman-Example.xcodeproj'

  use_frameworks!
  lib_pods

  pod 'BulletinBoard', '~> 2.0.2'
  pod 'SnapKit', '~> 4.0.1'

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