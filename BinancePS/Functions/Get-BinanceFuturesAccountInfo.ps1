<#
  .SUMMARY 
    Get information about the binance futures account.
#>
Function Get-BinanceFuturesAccountInfo
{
  [CmdletBinding()]
  Param(
  )

  Get-BinanceApiContext -ErrorAction Stop | Out-Null

  $ApiSubUrl = "/fapi/v2/account"
  $Result = Invoke-BinanceFuturesApiRequest -ApiSuburl $ApiSubUrl 

  Return $Result  
}