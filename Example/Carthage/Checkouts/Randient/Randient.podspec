Pod::Spec.new do |s|

  s.name         = "Randient"

  s.ios.deployment_target = '9.0'
  s.swift_version = '4.2'

  s.requires_arc = true

  s.version      = "1.0.0"
  s.summary      = "Radient, random gradient views."
  s.description  = <<-DESC
  					Randomizable, animated gradients generated from uigradients.com.
                   DESC

  s.homepage          = "https://github.com/uias/Randient"
  s.license           = "MIT"
  s.author            = { "UI At Six" => "uias@sapsford.tech" }
  s.social_media_url  = "http://twitter.com/MerrickSapsford"

  s.source       = { :git => "https://github.com/uias/Randient.git", :tag => s.version.to_s }
  s.source_files = "Sources/Randient/**/*.{h,m,swift}", "Sources/gen/*.{swift}"

  s.prepare_command = './Scripts/update.sh ./Sources'

end
