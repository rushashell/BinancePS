If (-not [System.AppDomain]::CurrentDomain.GetAssemblies() | Where-Object Location | Where-Object { $_.Location -like "*System.Web.dll" })
{
  Add-Type -AssemblyName "System.Web"
}

Function New-BinanceSignature
{
  [CmdletBinding()]
  [OutputType([String])]
  Param(
    [Parameter(Mandatory=$True)]
    [ValidateNotNullOrEmpty()]
    [String] $SecretKey,

    [Parameter(Mandatory=$True)]
    [ValidateNotNullOrEmpty()]
    [String] $QueryString
  )
    
  $Hmacsha = New-Object System.Security.Cryptography.HMACSHA256
  $Hmacsha.key = [Text.Encoding]::ASCII.GetBytes($SecretKey)
  $Signature = $Hmacsha.ComputeHash([Text.Encoding]::ASCII.GetBytes($QueryString))
  $Signature = [System.BitConverter]::ToString($Signature).Replace('-', '').ToLower()
  $Signature
}