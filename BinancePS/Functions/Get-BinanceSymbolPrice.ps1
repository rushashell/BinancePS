<#
  .SUMMARY 
    Get priceinformation of specific coins through the cryptocompare api.
#>
Function Get-BinanceSymbolPrice
{
  [CmdletBinding(DefaultParameterSetName="None")]
  [OutputType([PSCustomObject[]])]
  Param(
    [Parameter(Mandatory=$True, ParameterSetName="Single")]
    [ValidateNotNullOrEmpty()]
    [String] $Symbol,

    [Parameter(Mandatory=$True, ParameterSetName="Multiple")]
    [String[]] $Symbols,

    [Parameter(Mandatory=$False, ParameterSetName="Single")]
    [Parameter(ParameterSetName="Multiple")]
    [ValidateSet("BTC", "USDT", "ETH")]
    [String] $Currency = "USDT"
  )

  Get-BinanceApiContext -ErrorAction Stop | Out-Null

  $PriceTickerSubUrl = "/api/v3/ticker/price"
  If ($PSCmdlet.ParameterSetName -eq "None")
  {
    Return Invoke-BinanceApiRequest -ApiSuburl $PriceTickerSubUrl -NoSignature
  }

  If ($PsCmdlet.ParameterSetName -eq "Single")
  {
    $Symbols += $Symbol
  }

  $Res = [PSCustomObject[]] @()
  ForEach($Sym in $Symbols)
  {
    $QueryString = "symbol=$($Sym)$($Currency)"
    $Res += Invoke-BinanceApiRequest -ApiSuburl $PriceTickerSubUrl -QueryString $QueryString -NoSignature
    Start-Sleep -Milliseconds 100;
  }
  
  Return ,$Res;
}