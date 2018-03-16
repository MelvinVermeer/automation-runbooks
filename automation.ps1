$ResourceGroupLocation = "westeurope"
$ResourceGroupName = "MyAutmation" 
$AutomationName = "Automation" 
$OmsWorkspaceName = "OmsLogging001" 
$HybridWorkerGroup = "HybridWorkers"
$TenantId = "<not in source control>"
$SubscriptionId = "<not in source control>" 

Login-AzureRmAccount -TenantId $TenantId
Write-Host 'Removing existing resource group'
Remove-AzureRmResourceGroup $ResourceGroupName -Force -ErrorAction: SilentlyContinue

$OptionalParameters = New-Object -TypeName Hashtable
$OptionalParameters["omsName"] = $OmsWorkspaceName
$OptionalParameters["automationName"] = $AutomationName
.\Deploy-AzureResourceGroup.ps1 -resourcegroupname $ResourceGroupName -ResourceGroupLocation $ResourceGroupLocation -OptionalParameters $OptionalParameters

##
## Installation on the hybrid worker - start
##
Write-Host 'Installing New-OnPremiseHybridWorker script on local machine'
Install-Script -Name New-OnPremiseHybridWorker -RequiredVersion 1.0 -Force

Write-Host 'Remove existing HybridWorker Connections on local machine'
$path = "HKLM:\SOFTWARE\Microsoft\HybridRunbookWorker"
(gci $path).PsPath  | foreach { if($_){Remove-Item $_ -Force} }

$currentpath = (Get-Item -Path ".\" -Verbose).FullName
Write-Host 'Installing HybridWorker on local machine'
New-OnPremiseHybridWorker -AutomationAccountName $AutomationName -ResourceGroupName $ResourceGroupName -HybridGroupName $HybridWorkerGroup -SubscriptionId $SubscriptionId -WorkspaceName $OmsWorkspaceName
Set-Location $currentpath
##
## Installation on the hybrid worker - end
##

Write-Host 'Importing runbooks'
.\Import-Runbooks.ps1 -folder "./runbooks" -ResourceGroupName $ResourceGroupName -AutomationName $AutomationName -HybridWorkerGroup $HybridWorkerGroup