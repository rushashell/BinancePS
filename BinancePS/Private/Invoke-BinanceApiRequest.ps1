Function Invoke-BinanceApiRequest
{
  [CmdletBinding()]
  #[OutputType([Object])]
  Param(
    [Parameter(Mandatory=$True)]
    [ValidateNotNullOrEmpty()]
    [String] $ApiSubUrl,

    [Parameter(Mandatory=$False)]
    [String] $QueryString = "",

    [Parameter(Mandatory=$False)]
    [ValidateRange(0, 60000)]
    [Int] $RecvWindow,

    [Parameter(Mandatory=$False)]
    [Switch] $NoSignature
  )
  
  $Context = Get-BinanceApiContext -ErrorAction Stop;

  If (-not $ApiSubUrl.StartsWith("/")) { $ApiSubUrl = "/" + $ApiSubUrl }
  If ($RecvWindow -lt 1000) { $RecvWindow = $Context.DefaultRecvWindow }
  If ($QueryString.StartsWith("?")) { $QueryString = $QueryString.SubString(1) }
  
  If (-not $NoSignature.IsPresent -or -not $NoSignature)
  {
    $QueryString = "{0}&recvWindow={1}" -f $QueryString, $RecvWindow;
    $QueryString = Append-TimestampAndSignatureToQueryString -QueryString $QueryString -SecretKey $Context.SecretKey;
  }  

  $Headers = @{'Accept' = 'application/json'; 'X-MBX-APIKEY' = $Context.ApiKey }
  $FullUrl = "{0}{1}?{2}" -f $Context.RootApiUrl, $ApiSubUrl, $QueryString

  $Result = Invoke-WebRequest -UseBasicParsing -Uri $FullUrl -Headers $Headers 
  $Result.Content | ConvertFrom-Json
}