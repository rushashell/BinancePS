Function Get-BinanceApiContext
{
  [CmdletBinding()]
  Param(
  )

  $Result = Get-Variable -Name "BinanceApiContext" -Scope Script -ErrorAction SilentlyContinue
  If (-not $Result)
  {
    Throw "No Binance API Context was set. Please run Set-BinanceContext first."
  }

  Return $Result.Value;
}