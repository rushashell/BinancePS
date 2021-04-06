Function Append-TimestampAndSignatureToQueryString
{
  [CmdletBinding()]
  Param(
    [Parameter(Mandatory=$True)]
    [ValidateNotNullOrEmpty()]
    [String] $SecretKey,

    [Parameter(Mandatory=$False)]
    [String] $QueryString = ""
  )

  $QueryString = $QueryString | Append-TimestampToQueryString
  
  $Signature = New-BinanceSignature -SecretKey $SecretKey -QueryString $QueryString
  $QueryString = "{0}&signature={1}" -f $QueryString, $Signature
  $QueryString
}