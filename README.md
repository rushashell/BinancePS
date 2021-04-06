# BinancePS
Powershell Module for requesting information from the Binance API through Powershell Cmdlets.

# Usage
This Powershell module can be used on windows by starting PowerShell, navigating to the folder that holds the BinancePS folder: 
```powershell
Set-Location "C:\Git\BinancePS"

Import-Module .\BinancePS

# Set context to Binance API first
Set-BinanceApiContext -ApiKey "aabbcc" -SecretKey "ddeeff"

# Now request information
$Coins = Get-BinanceCoinsAvailable -WithBalanceOnly
$Coins | Select-Object coin, name, free, locked | Format-Table
```