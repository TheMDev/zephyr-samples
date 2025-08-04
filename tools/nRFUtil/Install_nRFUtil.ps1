echo "Downloading nrfutil:"
curl https://files.nordicsemi.com/artifactory/swtools/external/nrfutil/executables/x86_64-pc-windows-msvc/nrfutil.exe -o nrfutil.exe

echo "Old Path:"
$regPath = "HKCU:Environment"
$oldPath = (Get-ItemProperty $regPath ).Path
echo $oldPath

echo "New Path:"
$newPath = -join("$oldPath","%USERPROFILE%\.nrfutil\bin",";")
echo $newPath

echo "Installing nrfutil:"
Remove-ItemProperty -Path $regPath -Name "Path" -Force
New-ItemProperty -Path "$regPath" -PropertyType "ExpandString" -Name "Path" -Value "$newPath"

echo "Checking For Updates:"
nrfutil.exe self-upgrade

echo "Installing Commands:"
nrfutil.exe install 91 ble-sniffer completion device npm nrf5sdk-tools sdk-manager suit toolchain-manager trace

echo "Checking For Updates:"
nrfutil.exe upgrade

echo "Removing Installer"
Remove-Item nrfutil.exe

echo "Finished Install"
