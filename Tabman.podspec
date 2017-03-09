Pod::Spec.new do |s|

  s.name         = "Tabman"
  s.platform     = :ios, "9.0"
  s.requires_arc = true

  s.version      = "0.4.0.beta.1"
  s.summary      = "A powerful paging view controller with indicator bar for iOS"
  s.description  = <<-DESC
  					Tabman is a powerful paging view controller with indicator bar, with simple but extensive customisation.
                   DESC

  s.homepage          = "https://github.com/MerrickSapsford/Tabman"
  s.license           = "MIT"
  s.author            = { "Merrick Sapsford" => "merrick@sapsford.tech" }
  s.social_media_url  = "http://twitter.com/MerrickSapsford"

  s.source       = { :git => "https://github.com/MerrickSapsford/Tabman.git", :tag => s.version.to_s }
  s.source_files = "Sources/Tabman/**/*.{h,m,swift}"

  s.dependency 'Pageboy', '~> 0.4.0'
  s.dependency 'PureLayout', '~> 3.0.0'

end
