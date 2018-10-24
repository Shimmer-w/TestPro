@version = "1.0"

Pod::Spec.new do |s| 
s.name = "TestPro" 
s.version = @version 
s.summary = "简述" 
s.description = "描述" 
s.homepage = "https://github.com/famerdream/TestPro" 
s.license = { :type => 'MIT', :file => 'LICENSE' } 
s.author = { "famerdream" => "3068232374@qq.com" } 
s.ios.deployment_target = '8.0' 
s.source = { :git => "https://github.com/famerdream/TestPro.git", :tag => "v#{s.version}" } 
s.source_files = 'TestPro/Code/*.{h,m}' 
s.requires_arc = true 
s.framework = "UIKit" 
end