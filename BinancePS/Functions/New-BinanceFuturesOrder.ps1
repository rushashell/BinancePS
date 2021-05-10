<#
  .SUMMARY 
    Places a new order for the given symbol within the binance futures account.
#>
Function New-BinanceFuturesOrder
{
  [CmdletBinding(DefaultParameterSetName="Single")]
  Param(
    [Parameter(Mandatory=$True, ParameterSetName="Single")]
    [ValidateNotNullOrEmpty()]
    [String] $Symbol,

    [Parameter(Mandatory=$True, ParameterSetName="Single")]
    [ValidateSet("Buy", "Sell")]
    [String] $Side,

    [Parameter(Mandatory=$False, ParameterSetName="Single")]
    [ValidateSet("Both", "Long", "Short")]
    [String] $PositionSide = "Both",

    [Parameter(Mandatory=$False, ParameterSetName="Single")]
    [ValidateSet("Market", "Limit", "Stop", "Take_Profit", "Stop_Market", "TAKE_PROFIT_MARKET", "TRAILING_STOP_MARKET")]
    [String] $Type = "Market",

    [Parameter(Mandatory=$False, ParameterSetName="Single")]
    [ValidateSet("GTC", "IOC", "FOK")]
    [String] $TimeInForce = "GTC",

    [Parameter(Mandatory=$True, ParameterSetName="Single")]
    [ValidateRange(0, 999999999)]
    [Decimal] $Quantity,

    [Parameter(Mandatory=$False, ParameterSetName="Single")]
    [ValidateRange(0, 999999999)]
    [Decimal] $Price = 0
  )

  Begin
  {
    "New-BinanceFuturesOrder - START" | Write-Verbose
    Get-BinanceApiContext -ErrorAction Stop | Out-Null
    $ApiSubUrl = "/fapi/v1/order"
  }

  Process 
  {
    If ($Type -eq "Market")
    {
      $QueryString = "symbol={0}&side={1}&positionSide={2}&type={3}&quantity={4}" -f $Symbol.ToUpperInvariant(), $Side.ToUpperInvariant(), $PositionSide.ToUpperInvariant(), $Type.ToUpperInvariant(), $Quantity
    }
    ElseIf ($Type -eq "Limit")
    {
      $QueryString = "symbol={0}&side={1}&positionSide={2}&type={3}&quantity={4}&price={5}" -f $Symbol.ToUpperInvariant(), $Side.ToUpperInvariant(), $PositionSide.ToUpperInvariant(), $Type.ToUpperInvariant(), $Quantity, $Price
    }    

    Try
    {
      $Result = Invoke-BinanceFuturesApiRequest -ApiSuburl $ApiSubUrl -QueryString $QueryString -Method Post
    }
    Catch 
    {
      $Result = $_.ErrorDetails.Message | ConvertFrom-Json -ErrorAction SilentlyContinue
      If (-not $Result)
      {
        throw "Error occurred when placing order. Message: $($_.ErrorDetails.Message)."
        Return;
      }
    }

    If ($Result.status -eq "new")
    {
      "{0} {1} order was placed on symbol '{2}'." -f $Type, $Side, $Symbol.ToUpperInvariant() | Write-Host
    }
    Else
    {
      "Error occurred when placing new order. Message: {0}" -f $Result.msg | Write-Error 
    }
  }

  End 
  {
    "New-BinanceFuturesOrder - END" | Write-Verbose
  }
}