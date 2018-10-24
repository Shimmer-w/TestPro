Pod::Spec.new do |s|
    s.name         = "TestPro"
    s.version      = "1.0"
    s.ios.deployment_target = '8.0'
    s.summary      = "A delightful setting interface framework."
    s.homepage     = "https://github.com/famerdream/TestPro"
    s.license              = { :type => "MIT", :file => "LICENSE" }
    s.author             = { "famerdream" => "306822374@qq.com" }
    s.source       = { :git => "https://github.com/famerdream/TestPro.git", :tag => s.version }
    s.source_files  = "TestPro/Code/*.{h,m}"
    s.requires_arc = true
end
