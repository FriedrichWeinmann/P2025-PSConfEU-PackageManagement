# failsafe
return

<#
Github:
https://github.com/PowershellFrameworkCollective/PSFramework.NuGet

PSGallery:
https://www.powershellgallery.com/packages/PSFramework.NuGet
#>

#-----------------------------------------------------------------------------#
#                                    Setup                                    #
#-----------------------------------------------------------------------------#

# v1: Install-Module
Install-Module PSFramework.NuGet -Scope CurrentUser

# v2: bootstrap
Invoke-WebRequest https://raw.githubusercontent.com/PowershellFrameworkCollective/PSFramework.NuGet/refs/heads/master/bootstrap.ps1 | Invoke-Expression

#-----------------------------------------------------------------------------#
#                                     Use                                     #
#-----------------------------------------------------------------------------#

# Show Repositories
Get-PSRepository
Get-PSResourceRepository
Get-PSFRepository

# Install To Local
Install-PSFModule EntraAuth
Install-PSFModule PSUtil

# Scopes Extended
Get-PSFModuleScope
Get-PSFModuleScope | Format-List *
Register-PSFModuleScope -Name local -Path C:\temp\demo -Persist
Install-PSFModule EntraAuth -Scope Local

#-----------------------------------------------------------------------------#
#                               New Repository                                #
#-----------------------------------------------------------------------------#

# Filesystem
Set-PSFRepository -Name Local -Uri C:\Temp\Repository -Trusted $true -Type All
Get-PSFRepository
Publish-PSFModule -Path (Get-Module PSFramework).ModuleBase -Repository Local
Publish-PSFModule -Path (Get-Module PSFramework).ModuleBase -Repository Local -SkipDependenciesCheck

# Azure Container Registry
$url = 'https://psconfeudemo.azurecr.io'
Set-PSFRepository -Name ACR -Priority 10 -Uri $url -Trusted $true -Type V3
Publish-PSFModule -Path (Get-Module PSFramework).ModuleBase -Repository ACR -SkipDependenciesCheck
Find-PSFModule -Repository ACR


# Persist
# Credential
# Deploy


#-----------------------------------------------------------------------------#
#                             Remote Installation                             #
#-----------------------------------------------------------------------------#

$computers = 'getadmin', 'getpolicy', 'getconfig'

#-----------------------------------------------------------------------------#
#                        Remote/Offline Bootstrapping                         #
#-----------------------------------------------------------------------------#


#-----------------------------------------------------------------------------#
#                                    Tools                                    #
#-----------------------------------------------------------------------------#

#-> Module Signature
Save-PSFModule SqlServer -Path .
Get-PSFModuleSignature -Path .\SqlServer\22.4.5.1\

#-> Module Manifests
Update-PSFModuleManifest -

#-----------------------------------------------------------------------------#
#                              Resource Modules                               #
#-----------------------------------------------------------------------------#

42 > answer.txt
Publish-PSFResourceModule -Name TestData -Path .\* -Repository Local
Find-PSFModule -Repository Local
Remove-Item .\* -Force -Recurse
dir
Save-PSFResourceModule -Name TestData -Repository Local -Path .
dir