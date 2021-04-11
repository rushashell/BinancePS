<#

 .Synopsis
  Modulescript for exposing Binance API functionality through Powershell Cmdlets.

 .Description
  This module gives users possibility to request information from the Binance API through 
  simple to use Powershell Cmdlets.

#>

If($Verbose) 
{
  $VerbosePreference = "Continue" 
}

$ErrorActionPreference = "Stop"
$WarningPreference = "Continue"
$ProgressPreference = "SilentlyContinue"

# Global settings

$SharedTypesPath = Join-Path -Path $PSScriptRoot -ChildPath "Shared"
$FunctionsPath = Join-Path -Path $PSScriptRoot -ChildPath "Functions"
$PrivateFunctionsPath = Join-Path -Path $PSScriptRoot -ChildPath "Private"
$AssetsPath = Join-Path -Path $PSScriptRoot -ChildPath "Assets"
$LibPath = Join-Path -Path $PSScriptRoot -ChildPath "Lib"

$Imports = Get-ChildItem -Path $SharedTypesPath | Where-Object { $_.Name -like "*.ps1" }
ForEach($Import in $Imports)
{
  .$Import.FullName
}

$Imports = Get-ChildItem -Path $PrivateFunctionsPath | Where-Object { $_.Name -like "*.ps1" }
ForEach($Import in $Imports)
{
  .$Import.FullName 
}

$Imports = Get-ChildItem -Path $FunctionsPath | Where-Object { $_.Name -like "*.ps1" }
ForEach($Import in $Imports)
{
  .$Import.FullName 
}