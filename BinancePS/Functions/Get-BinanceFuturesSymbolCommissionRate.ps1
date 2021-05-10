<#
  .SUMMARY 
    Gets the commission rate of a specific symbol.
#>
Function Get-BinanceFuturesSymbolCommissionRate
{
  [CmdletBinding(DefaultParameterSetName="Single")]
  Param(
    [Parameter(Mandatory=$False, ParameterSetName="Single")]
    [ValidateNotNullOrEmpty()]
    [String] $Symbol
  )

  Begin
  {
    "Get-BinanceFuturesSymbolCommissionRate - START" | Write-Verbose
    Get-BinanceApiContext -ErrorAction Stop | Out-Null
    $ApiSubUrl = "/fapi/v1/commissionRate"
  }

  Process 
  {
    $QueryString = "symbol={0}" -f $Symbol.ToUpperInvariant()
    $Result = Invoke-BinanceFuturesApiRequest -ApiSuburl $ApiSubUrl -QueryString $QueryString
    Return $Result  
  }

  End
  {
    "Get-BinanceFuturesSymbolCommissionRate - END" | Write-Verbose
  }
}