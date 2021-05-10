<#
  .SUMMARY 
    Get account balance information about the binance futures account.
#>
Function Get-BinanceFuturesAccountBalance
{
  [CmdletBinding()]
  Param(
  )

  Get-BinanceApiContext -ErrorAction Stop | Out-Null

  $ApiSubUrl = "/fapi/v2/balance"
  $Result = Invoke-BinanceFuturesApiRequest -ApiSuburl $ApiSubUrl 

  Return $Result  
}