Function Append-TimestampToQueryString
{
  [CmdletBinding()]
  [OutputType([String])]
  Param(
    [Parameter(Mandatory=$False, ValueFromPipeline)]
    [String] $QueryString = ""
  )

  $Timestamp = [Math]::Floor((New-TimeSpan -Start (Get-Date "01/01/1970") -End ((Get-Date).ToUniversalTime())).TotalMilliseconds)
  $QueryString = "{0}&timestamp={1}" -f $QueryString, $Timestamp
  $QueryString
}