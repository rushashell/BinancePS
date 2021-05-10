<#
  .SUMMARY 
    Gets information about a specific position of a given symbol within the binance futures account.
#>
Function Get-BinanceFuturesPosition
{
  [CmdletBinding(DefaultParameterSetName="Single")]
  Param(
    [Parameter(Mandatory=$True, ParameterSetName="Single")]
    [ValidateNotNullOrEmpty()]
    [String] $Symbol
  )

  Begin
  {
    "Get-BinanceFuturesPosition - START" | Write-Verbose
    Get-BinanceApiContext -ErrorAction Stop | Out-Null
    $ApiSubUrl = "/fapi/v2/positionRisk"
  }

  Process 
  {
    $QueryString = "symbol={0}" -f $Symbol.ToUpperInvariant()
    $Result = Invoke-BinanceFuturesApiRequest -ApiSuburl $ApiSubUrl -QueryString $QueryString
    Return $Result  
  }

  End
  {
    "Get-BinanceFuturesPosition - END" | Write-Verbose
  }
}