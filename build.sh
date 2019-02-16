
rm -rf Pods/
rm Podfile.lock
pod cache clean --all
pod repo update
pod install
