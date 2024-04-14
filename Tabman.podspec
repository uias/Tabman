Pod::Spec.new do |s|
  
  s.name         = "Tabman"
  s.platform     = :ios, "12.0"
  s.requires_arc = true

  if s.respond_to? 'swift_versions'
    s.swift_versions = ['5.0']
  end

  s.version      = "3.2.0"
  s.summary      = "A powerful paging view controller with indicator bar."
  s.description  = <<-DESC
            Tabman is a highly customisable, powerful and extendable paging view controller with indicator bar.
                   DESC

  s.homepage          = "https://github.com/uias/Tabman"
  s.license           = "MIT"
  s.author            = { "Merrick Sapsford" => "merrick@sapsford.tech" }
  s.social_media_url  = "http://twitter.com/MerrickSapsford"

  s.source       = { :git => "https://github.com/uias/Tabman.git", :tag => s.version.to_s }
  s.source_files = "Sources/Tabman/**/*.{h,m,swift}"

  s.resource_bundles = {'Tabman' => ['Sources/Tabman/PrivacyInfo.xcprivacy']}

  s.dependency 'Pageboy', '~> 4.2.0'
  
end
