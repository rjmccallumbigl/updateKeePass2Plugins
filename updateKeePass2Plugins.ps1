[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls"

# Declare variables
$date = Get-Date -Format "yyyy-MM-dd"
$filename = "HaveIBeenPwnedPlugin.dll", "YetAnotherFaviconDownloader.plgx"
$sources = "https://github.com/kapsiR/HaveIBeenPwnedKeePassPlugin/releases/latest/download/$($filename[0])", "https://github.com/navossoc/KeePass-Yet-Another-Favicon-Downloader/releases/latest/download/$($filename[1])"
$destinations = "C:\Program Files\KeePass Password Safe 2\Plugins\"

# Loop through each plugin
for ($i = 0; $i -lt $filename.Count; $i++) {
    $destinationFile = "$($destinations)$($filename[$i])"

    # Move old file to archive folder
    if (Test-Path $destinationFile) {
        Move-Item -Path $destinationFile -Destination "$($destinations)\archive\$($filename[$i])_$($date)" -Force
    }

    # Download file and place in folder
    $wc = New-Object System.Net.WebClient
    $wc.DownloadFile($sources[$i], $destinationFile)
}

# Restart KeePass
& "C:\Program Files\KeePass Password Safe 2\KeePass.exe" /exit-all
& "C:\Program Files\KeePass Password Safe 2\KeePass.exe"
