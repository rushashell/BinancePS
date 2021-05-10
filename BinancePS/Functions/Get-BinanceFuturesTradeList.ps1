<#
  .SUMMARY 
    Gets information about trades made with the given symbol within the binance futures account.
#>
Function Get-BinanceFuturesTradeList
{
  [CmdletBinding(DefaultParameterSetName="Single")]
  Param(
    [Parameter(Mandatory=$True, ParameterSetName="Single")]
    [ValidateNotNullOrEmpty()]
    [String] $Symbol,

    [Parameter(Mandatory=$False, ParameterSetName="Single")]
    [ValidateRange(1,1000)]
    [Int] $Limit = 500
  )

  Begin
  {
    "Get-BinanceFuturesPosition - START" | Write-Verbose
    Get-BinanceApiContext -ErrorAction Stop | Out-Null
    $ApiSubUrl = "/fapi/v1/userTrades"
  }

  Process 
  {
    $QueryString = "symbol={0}&limit={1}" -f $Symbol.ToUpperInvariant(), $Limit
    $Result = Invoke-BinanceFuturesApiRequest -ApiSuburl $ApiSubUrl -QueryString $QueryString
    Return $Result  
  }

  End
  {
    "Get-BinanceFuturesPosition - END" | Write-Verbose
  }
}