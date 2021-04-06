Function Get-BinanceWalletCoins
{
  [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$False)]
    [Switch] $All
  )

  Get-BinanceApiContext -ErrorAction Stop | Out-Null

  $WalletApiSubUrl = "/sapi/v1/capital/config/getall"
  Invoke-BinanceApiRequest -ApiSuburl $WalletApiSubUrl
}