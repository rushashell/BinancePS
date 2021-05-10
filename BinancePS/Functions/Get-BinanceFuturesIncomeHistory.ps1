<#
  .SUMMARY 
    Gets income history within the binance futures account.
#>
Function Get-BinanceFuturesIncomeHistory
{
  [CmdletBinding(DefaultParameterSetName="Single")]
  Param(
    [Parameter(Mandatory=$False, ParameterSetName="Single")]
    [ValidateNotNullOrEmpty()]
    [String] $Symbol,

    [Parameter(Mandatory=$False, ParameterSetName="Single")]
    [ValidateSet("Transfer", "Welcome_Bonus", "Realized_Pnl", "Funding_Fee", "Commission", "Insurance_Clear")]
    [String] $IncomeType = "",

    [Parameter(Mandatory=$False, ParameterSetName="Single")]
    [ValidateRange(1,1000)]
    [Int] $Limit = 100
  )

  Begin
  {
    "Get-BinanceFuturesIncomeHistory - START" | Write-Verbose
    Get-BinanceApiContext -ErrorAction Stop | Out-Null
    $ApiSubUrl = "/fapi/v1/income"
  }

  Process 
  {
    $QueryString = "limit={0}" -f $Limit
    If (-not[String]::IsNullOrEmpty($Symbol)) { $QueryString += "&symbol={0}" -f $Symbol.ToUpperInvariant() }
    If (-not[String]::IsNullOrEmpty($IncomeType)) { $QueryString += "&incomeType={0}" -f $IncomeType.ToUpperInvariant() }

    $Result = Invoke-BinanceFuturesApiRequest -ApiSuburl $ApiSubUrl -QueryString $QueryString
    Return $Result  
  }

  End
  {
    "Get-BinanceFuturesIncomeHistory - END" | Write-Verbose
  }
}