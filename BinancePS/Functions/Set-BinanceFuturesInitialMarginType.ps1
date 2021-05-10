<#
  .SUMMARY 
    Sets the initial margin type (isolated or cross) of a given symbol within the binance futures account.
#>
Function Set-BinanceFuturesInitialMarginType
{
  [CmdletBinding(DefaultParameterSetName="Single")]
  Param(
    [Parameter(Mandatory=$True, ParameterSetName="Single")]
    [ValidateNotNullOrEmpty()]
    [String] $Symbol,

    [Parameter(Mandatory=$True, ParameterSetName="Single")]
    [ValidateSet("Isolated", "Crossed")]
    [String] $MarginType
  )

  Begin
  {
    "Set-BinanceFuturesInitialMarginType - START" | Write-Verbose
    Get-BinanceApiContext -ErrorAction Stop | Out-Null
    $ApiSubUrl = "/fapi/v1/marginType"
  }

  Process 
  {
    $QueryString = "symbol={0}&marginType={1}" -f $Symbol.ToUpperInvariant(), $MarginType.ToUpperInvariant()

    Try
    {
      $Result = Invoke-BinanceFuturesApiRequest -ApiSuburl $ApiSubUrl -QueryString $QueryString -Method Post
    }
    Catch 
    {
      $Result = $_.ErrorDetails.Message | ConvertFrom-Json -ErrorAction SilentlyContinue
      If (-not $Result)
      {
        throw "Error occurred when setting margin type. Message: $($_.ErrorDetails.Message)."
        Return;
      }
    }

    If ($Result.code -eq 200 -or $Result.code -eq -4046)
    {
      "Initial margin type was set to '{0}' on symbol '{1}'." -f $MarginType.ToUpperInvariant(), $Symbol.ToUpperInvariant() | Write-Host
    }
    Else
    {
      "Error occurred when setting margin type. Message: {0}" -f $Result.msg | Write-Error 
    }
  }

  End 
  {
    "Set-BinanceFuturesInitialMarginType - END" | Write-Verbose
  }
}