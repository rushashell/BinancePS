Function Set-BinanceApiContext
{
  [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$True)]
    [String] $ApiKey,

    [Parameter(Mandatory=$False)]
    [String] $SecretKey,

    [Parameter(Mandatory=$False)]
    [ValidateRange(1000, 60000)]
    [Int] $DefaultRecvWindow = 60000
  )

  $Context = [PSCustomObject] @{
    RootApiUrl = $BinanceRootApiUrl;
    ApiKey = $ApiKey;
    SecretKey = $SecretKey;
    DefaultRecvWindow = $DefaultRecvWindow;
  }

  Set-Variable -Name "BinanceApiContext" -Value $Context -Scope Script | Out-Null
  Write-Host "Context to Binance API is set."
}