<#
  .SUMMARY 
    Get information of coins (available for deposit and withdraw) for user.
#>
Function Get-BinanceCoinsAvailable
{
  [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$False)]
    [Switch] $WithBalanceOnly,

    [Parameter(Mandatory=$False)]
    [Switch] $IncludeValue,

    [Parameter(Mandatory=$False)]
    [Switch] $IncludeNetworklist
  )

  Get-BinanceApiContext -ErrorAction Stop | Out-Null

  $WalletApiSubUrl = "/sapi/v1/capital/config/getall"
  $Result = Invoke-BinanceApiRequest -ApiSuburl $WalletApiSubUrl

  If ($WithBalanceOnly.IsPresent -and $WithBalanceOnly)
  {
    $Result = $Result | Where-Object { $_.free -gt 0 -or $_.locked -gt 0 -or $_.freeze -gt 0 -or $_.withdrawing -gt 0 }
  }

  If ($IncludeValue.IsPresent -and $IncludeValue)
  {
    $Symbols = Get-BinanceSymbolPrice
    $BUSDValue = [Double] ($Symbols | Where-Object { $_.symbol -eq "BUSDUSDT" } | Select-Object -expandProperty price -First 1)
    $BTCValue = [Double] ($Symbols | Where-Object { $_.symbol -eq "BTCBUSD" } | Select-Object -expandProperty price -First 1)
    $EurValue = [Double] ($Symbols | Where-Object { $_.symbol -eq "EURBUSD" } | Select-Object -expandProperty price -First 1)
    
    ForEach($Coin in $Result)
    {
      $PriceBusd = [Double] ($Symbols | Where-Object { $_.symbol -eq "$($Coin.coin)BUSD" } | Select-Object -ExpandProperty price)
      $PriceUsdt = [Double] ($Symbols | Where-Object { $_.symbol -eq "$($Coin.coin)USDT" } | Select-Object -ExpandProperty price)
      $PriceBtc = [Double] ($Symbols | Where-Object { $_.symbol -eq "$($Coin.coin)BTC" } | Select-Object -ExpandProperty price)
      $PriceEur = [Double] ($Symbols | Where-Object { $_.symbol -eq "$($Coin.coin)EUR" } | Select-Object -ExpandProperty price)

      If ($Coin.coin -eq "USDT")
      {
        $PriceUsdt = 1;
        $PriceBtc = [Double]($BUSDValue / $BTCValue)
        $PriceEur = [Double]($BUSDValue / $EurValue)
      }

      If ($PriceUsdt -eq 0 -and $PriceBusd -gt 0)
      {
        $PriceUsdt = [Math]::Round([Double]($PriceBusd/$BUSDValue),4)
      }

      If ($PriceBtc -eq 0 -and $PriceBusd -gt 0)
      {
        $PriceBtc = [Double]($PriceBusd/$BTCValue)
      }

      If ($PriceEur -eq 0 -and $PriceBusd -gt 0)
      {
        $PriceEur = [Math]::Round([Double]($PriceBusd/$EurValue),4)
      }

      $Total = ([double]$Coin.free + [double]$Coin.locked + [double]$Coin.freeze + [double]$Coin.withdrawing)
      $ValueUsdt =  [Math]::Round($PriceUsdt * $Total, 2)
      $ValueBtc = [Math]::Round($PriceBtc * $Total, 4)
      $ValueEur = [Math]::Round($PriceEur * $Total, 2)      

      $Coin | Add-Member -MemberType NoteProperty -Name 'total' -Value $Total

      $Coin | Add-Member -MemberType NoteProperty -Name 'priceBTC' -Value $PriceBtc
      $Coin | Add-Member -MemberType NoteProperty -Name 'priceUSDT' -Value $PriceUsdt
      $Coin | Add-Member -MemberType NoteProperty -Name 'priceEUR' -Value $PriceEur

      $Coin | Add-Member -MemberType NoteProperty -Name 'valueBTC' -Value $ValueBtc
      $Coin | Add-Member -MemberType NoteProperty -Name 'valueUSDT' -Value $ValueUsdt
      $Coin | Add-Member -MemberType NoteProperty -Name 'valueEUR' -Value $ValueEur
    }
  }

  If (-not $IncludeNetworklist.IsPresent -or -not $IncludeNetworklist)
  {
    $Result = $Result | Select-Object -Property * -ExcludeProperty networkList #coin, name, depositAllEnable, withdrawAllEnable, free, locked, freeze, withdrawing, ipoing, ipoable, storage, isLegalMoney, trading, priceBTC, priceUSDT, priceEUR
  }  

  Return $Result  
}