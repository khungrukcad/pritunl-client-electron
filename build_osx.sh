rm -rf build/osx

# Pritunl
mkdir -p build/osx/Applications
./node_modules/.bin/electron-packager ./ Pritunl --platform=darwin --arch=x64 --version=0.27.3 --icon=./www/img/pritunl.icns --out=build/osx/Applications

# Service
cd service
go build -a
cd ..
mkdir -p build/osx/usr/local/bin
cp service/service build/osx/usr/local/bin/pritunl-service

# Service Daemon
mkdir -p build/osx/Library/LaunchDaemons
cp service_osx/com.pritunl.service.plist build/osx/Library/LaunchDaemons

# Tuntap
mkdir -p build/osx/Library/Extensions
cp -pR tuntap_osx/pritunl-tap.kext build/osx/Library/Extensions/
cp -pR tuntap_osx/pritunl-tun.kext build/osx/Library/Extensions/
mkdir -p build/osx/Library/LaunchDaemons
cp tuntap_osx/com.pritunl.tuntaposx.pritunl-tap.plist build/osx/Library/LaunchDaemons/
cp tuntap_osx/com.pritunl.tuntaposx.pritunl-tun.plist build/osx/Library/LaunchDaemons/

# Openvpn
mkdir -p build/osx/usr/local/bin
cp openvpn_osx/openvpn build/osx/usr/local/bin/pritunl-openvpn

# Package
cp install_osx.sh build/osx/install.sh
sed -i '' 's|build/osx|.|g' build/osx/install.sh
cp uninstall_osx.sh build/osx/uninstall.sh
sed -i '' 's|build/osx|.|g' build/osx/uninstall.sh
cd build
mv osx pritunl_0.1.0-osx
zip -r pritunl_0.1.0-osx.zip pritunl_0.1.0-osx
mv pritunl_0.1.0-osx osx
cd ..
rm build/osx/install.sh
rm build/osx/uninstall.sh
