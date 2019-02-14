# Meeting Minutes
* February 13, 2019

## Topics

  * Summary review of some useful PS modules available on the PS gallery:
    * Carbon - https://www.powershellgallery.com/packages/carbon or http://get-carbon.org/
    * DbaTools - https://www.powershellgallery.com/packages/dbatools or https://dbatools.io
    * PlatyPS - https://www.powershellgallery.com/packages/PlatyPS
    * GpoDoc - https://www.powershellgallery.com/packages/GPODoc
  * Overview of a PowerShell module:
    * ```Install-Module``` then ```Import-Module``` (Import is optional with PS 5.x and later)
    * Also ```Update-Module``` and ```Remove-Module```
    * Reusable/Shareable collection of associated utilities (Dave's cheap analogy: _a module is like a toolbox filled with tools which relate to a particular type of need or purpose_)
    * Default path: %programfiles%\WindowsPowerShell\Modules
  * Module components:
    * ModuleName.PSM1 module file
    * ModuleName.PSD1 module manifest
    * Optional .PS1 files
    * .PSM1 file may contain all the code for the module, or may dot-source separate files (your choice)
    * Obtain API key from PS Gallery (keep it private/protected)
  * Commands discussed:
    * Install-Module _ModuleName_
    * Find-Module _ModuleName_
    * Get-Command -Module _ModuleName_
    * New-ModuleManifest
