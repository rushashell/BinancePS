<#
  .SUMMARY 
    Sets the initial leverage of a given symbol within the binance futures account.
#>
Function Set-BinanceFuturesInitialLeverage
{
  [CmdletBinding(DefaultParameterSetName="Single")]
  Param(
    [Parameter(Mandatory=$True, ParameterSetName="Single")]
    [ValidateNotNullOrEmpty()]
    [String] $Symbol,

    [Parameter(Mandatory=$True, ParameterSetName="Single")]
    [ValidateRange(1, 125)]
    [Int] $Leverage
  )

  Begin
  {
    "Set-BinanceFuturesInitialLeverage - START" | Write-Verbose
    Get-BinanceApiContext -ErrorAction Stop | Out-Null
    $ApiSubUrl = "/fapi/v1/leverage"
  }

  Process 
  {
    $QueryString = "symbol={0}&leverage={1}" -f $Symbol.ToUpperInvariant(), $Leverage
    $Result = Invoke-BinanceFuturesApiRequest -ApiSuburl $ApiSubUrl -QueryString $QueryString -Method Post
    Return $Result  
  }

  End
  {
    "Set-BinanceFuturesInitialLeverage - END" | Write-Verbose
  }
}