<#
  .SUMMARY 
    Get information of coins (available for deposit and withdraw) for user.
#>
Function Get-BinanceCoinsAvailable
{
  [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$False)]
    [Switch] $WithBalanceOnly
  )

  Get-BinanceApiContext -ErrorAction Stop | Out-Null

  $WalletApiSubUrl = "/sapi/v1/capital/config/getall"
  $Result = Invoke-BinanceApiRequest -ApiSuburl $WalletApiSubUrl

  If (-not $WithBalanceOnly.IsPresent -or -not $WithBalanceOnly)
  {
    Return $Result;
  }

  $Result | Where-Object { $_.free -gt 0 -or $_.locked -gt 0 -or $_.freeze -gt 0 -or $_.withdrawing -gt 0 }
}