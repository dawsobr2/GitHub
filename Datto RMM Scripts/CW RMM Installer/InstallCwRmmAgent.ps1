
$InstallerSetupToken = $env:CW_RMM_DPMA_TOKEN
$DesktopDownloadURL = "https://prod.setup.itsupport247.net/windows/DPMA/32/SeattleComputing_DPMA_ITSPlatform_TKN7e3d2331-1288-49b6-8d26-a262a11f3b49/MSI/setup"
$ServerDownloadURL = "https://prod.setup.itsupport247.net/windows/MSMA/32/SeattleComputing_MSMA_ITSPlatform_TKN7e3d2331-1288-49b6-8d26-a262a11f3b49/MSI/setup"
$TempDir = $env:TEMP

if (!($InstallerSetupToken)) {
    Write-Host "No Setup Token Found. Exiting..."
    exit 1
}
#Detect Workstation or Server
$osInfo = Get-CimInstance -ClassName Win32_OperatingSystem

if ($osInfo.ProductType -eq 1) {
    <# Download the Desktop Installer #>
    Invoke-WebRequest -Uri $DesktopDownloadURL -OutFile "$TempDir\installer.msi"
}
else {
    <# Download the Server Installer #>
    Invoke-WebRequest -Uri $ServerDownloadURL -OutFile "$TempDir\installer.msi"
}

#Run Installer with Token parameter
msiexec -i "$TempDir\installer.msi" TOKEN=$InstallerSetupToken /q