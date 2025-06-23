$labname = 'Get'
$domainName = 'contoso.com'
$imageUI = 'Windows Server 2022 Datacenter (Desktop Experience)'

New-LabDefinition -Name $labname -DefaultVirtualizationEngine HyperV

$PSDefaultParameterValues['Add-LabMachineDefinition:Memory'] = 2GB
$PSDefaultParameterValues['Add-LabMachineDefinition:OperatingSystem'] = $imageUI
$PSDefaultParameterValues['Add-LabMachineDefinition:DomainName'] = $domainName

Add-LabMachineDefinition -Name GetDC -Roles RootDC
Add-LabMachineDefinition -Name GetPolicy
Add-LabMachineDefinition -Name GetAdminHost
Add-LabMachineDefinition -Name GetConfig

Install-Lab

Install-LabWindowsFeature -ComputerName GetAdminHost -FeatureName NET-Framework-Core, NET-Non-HTTP-Activ, GPMC, RSAT-AD-Tools

Invoke-LabCommand -ActivityName "Setting Keyboard Layout" -ComputerName (Get-LabVM).Name -ScriptBlock { Set-WinUserLanguageList -LanguageList 'de-de' -Confirm:$false -Force }
Restart-LabVM -ComputerName (Get-LabVM).Name