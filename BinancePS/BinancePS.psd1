#
# Module manifest for module 'BinancePS'
#
# This module is using the Binance API: https://binance-docs.github.io/apidocs/spot/en/#deposit-address-user_data
#

@{
  
  # Script module or binary module file associated with this manifest.
  RootModule = 'BinancePS.psm1'
  
  # Version number of this module.
  ModuleVersion = '1.0.0'
  
  # Supported PSEditions
  CompatiblePSEditions = @("Desktop")
  
  # ID used to uniquely identify this module
  GUID = '0c22a9e3-20f9-424b-b277-580457128302'
  
  # Author of this module
  Author = 'rushashell'
  
  # Company or vendor of this module
  CompanyName = 'rushashell'
  
  # Copyright statement for this module
  Copyright = '(c) 2021 rushashell. All rights reserved.'
  
  # Description of the functionality provided by this module
  Description = 'This module exposes Binance API functionality through Powershell Cmdlets.'
  
  # Minimum version of the Windows PowerShell engine required by this module
  PowerShellVersion = '5.1'
  
  # Name of the Windows PowerShell host required by this module
  # PowerShellHostName = ''
  
  # Minimum version of the Windows PowerShell host required by this module
  # PowerShellHostVersion = ''
  
  # Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
  # DotNetFrameworkVersion = ''
  
  # Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
  # CLRVersion = ''
  
  # Processor architecture (None, X86, Amd64) required by this module
  # ProcessorArchitecture = ''
  
  # Modules that must be imported into the global environment prior to importing this module
  RequiredModules = @()
  
  # Assemblies that must be loaded prior to importing this module
  # RequiredAssemblies = @()
  
  # Script files (.ps1) that are run in the caller's environment prior to importing this module.
  ScriptsToProcess = @("Shared\*.ps1")
  
  # Type files (.ps1xml) to be loaded when importing this module
  # TypesToProcess = @()
  
  # Format files (.ps1xml) to be loaded when importing this module
  # FormatsToProcess = @()
  
  # Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
  # NestedModules = @()
  
  # Functions to export from this module
  FunctionsToExport = @(
    "Set-BinanceApiContext",
    "Get-BinanceCoinsAvailable",
    "Get-BinanceSymbolPrice",

    "Get-BinanceFuturesAccountBalance",
    "Get-BinanceFuturesAccountInfo",
    "Get-BinanceFuturesPosition",
    "Get-BinanceFuturesTradeList",
    "Get-BinanceFuturesIncomeHistory",
    "Get-BinanceFuturesSymbolCommissionRate",
    "New-BinanceFuturesOrder",
    "Set-BinanceFuturesInitialLeverage",
    "Set-BinanceFuturesInitialMarginType",
    "Update-BinanceFuturesPositionMargin"
  )
  
  # Cmdlets to export from this module
  CmdletsToExport = @()
  
  # Variables to export from this module
  VariablesToExport = ''
  
  # Aliases to export from this module
  AliasesToExport = @()
  
  # DSC resources to export from this module
  # DscResourcesToExport = @()
  
  # List of all modules packaged with this module
  # ModuleList = @("")
  
  # List of all files packaged with this module
  # FileList = @()
  
  # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
  PrivateData = @{
  
      PSData = @{
  
          # Tags applied to this module. These help with module discovery in online galleries.
          Tags = @("Binance", "Powershell", "rushashell")
  
          # A URL to the license for this module.
          LicenseUri = 'https://github.com/rushashell/'
  
          # A URL to the main website for this project.
          ProjectUri = 'https://github.com/rushashell/BinancePS'
  
          # A URL to an icon representing this module.
          #IconUri = ''
  
          # ReleaseNotes of this module
          # ReleaseNotes = ''

          # Prerelease string of this module
          Prerelease = 'preview'
  
      } # End of PSData hashtable
  
  } # End of PrivateData hashtable
  
  # HelpInfo URI of this module
  # HelpInfoURI = ''
  
  # Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
  # DefaultCommandPrefix = ''
}