require 'json'
package = JSON.parse(File.read('./package.json'))

Pod::Spec.new do |s|
  s.name                = "{{{pod_name}}}"
  s.version             = package["version"]
  s.summary             = package["description"]
  s.description         = <<-DESC
                          Analytics for React-Native provides a single API that lets you
                          integrate with over 100s of tools.

                          This is the {{{name}}} integration for the React-Native library.
                          DESC
   
  s.homepage            = "http://astronomer.io"
  s.license             =  { :type => 'MIT' }
  s.author              = { "Astronomer" => "info@astronomer.io" }
  s.source              = { :git => "https://github.com/super-collider/analytics-react-native.git", :tag => s.version.to_s }
  s.social_media_url    = 'https://twitter.com/segment'

  s.platform            = :ios, "9.0"
  s.source_files        = 'ios/main.m'
  s.static_framework    = true

  s.dependency          '{{{pod_dependency}}}'{{#pod_version}}, '~> {{{pod_version}}}'{{/pod_version}}
  s.dependency          'MetarouterAnalytics'
  s.dependency          'React'
end
