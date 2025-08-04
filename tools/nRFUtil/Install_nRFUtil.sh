echo "Downloading nrfutil:"
curl https://files.nordicsemi.com/artifactory/swtools/external/nrfutil/executables/x86_64-unknown-linux-gnu/nrfutil -o nrfutil

chmod +x nrfutil

echo "Installing nrfutil:"
echo 'export PATH="$PATH:~/.nrfutil/bin"' >> ~/.bashrc

echo "Checking For Updates:"
./nrfutil self-upgrade

echo "Installing Commands:"
./nrfutil install 91 ble-sniffer completion device npm nrf5sdk-tools sdk-manager suit toolchain-manager trace

echo "Checking For Updates:"
./nrfutil upgrade

echo "Removing Installer"
rm ./nrfutil

echo "Finished Install"
