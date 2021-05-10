<#
  .SUMMARY 
    Updates the margin for a specific position with isolated margin of a given symbol within the binance futures account.
#>
Function Update-BinanceFuturesPositionMargin
{
  [CmdletBinding(DefaultParameterSetName="Single")]
  Param(
    [Parameter(Mandatory=$True, ParameterSetName="Single")]
    [ValidateNotNullOrEmpty()]
    [String] $Symbol,

    [Parameter(Mandatory=$False, ParameterSetName="Single")]
    [ValidateSet("Both", "Long", "Short")]
    [String] $PositionSide = "Both",

    [Parameter(Mandatory=$True, ParameterSetName="Single")]
    [ValidateRange(0, 999999999)]
    [Decimal] $Amount,

    [Parameter(Mandatory=$True, ParameterSetName="Single")]
    [ValidateSet("Add", "Reduce")]
    [String] $Type
  )

  Begin
  {
    "Set-BinanceFuturesPositionMargin - START" | Write-Verbose
    Get-BinanceApiContext -ErrorAction Stop | Out-Null
    $FuturesBalanceApiSubUrl = "/fapi/v1/positionMargin"
  }

  Process 
  {
    $TypeInt = 1
    $TypeText = "added"
    If ($Type -eq "Reduce") { $TypeInt = 2; $TypeText = "removed" }
    $QueryString = "symbol={0}&positionSide={1}&amount={2}&type={3}" -f $Symbol.ToUpperInvariant(), $PositionSide.ToUpperInvariant(), $Amount, $TypeInt

    Try
    {
      $Result = Invoke-BinanceFuturesApiRequest -ApiSuburl $ApiSubUrlvApiSubUrl -QueryString $QueryString -Method Post
    }
    Catch 
    {
      $Result = $_.ErrorDetails.Message | ConvertFrom-Json -ErrorAction SilentlyContinue
      If (-not $Result)
      {
        throw "Error occurred when updating margin. Message: $($_.ErrorDetails.Message)."
        Return;
      }
    }

    If ($Result.code -eq 200)
    {
      "Margin was {0} with'{1}' on symbol '{2}'." -f $TypeText, $Amount, $Symbol.ToUpperInvariant() | Write-Host
    }
    Else
    {
      "Error occurred when updating margin size. Message: {0}" -f $Result.msg | Write-Error 
    }
  }

  End 
  {
    "Set-BinanceFuturesPositionMargin - END" | Write-Verbose
  }
}