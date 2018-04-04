$ResourceGroupLocation = "westeurope"
$ResourceGroupName = "MyAutmationResourceGroup" 
$AutomationName = "Automation" 
$TenantId = "<not in source control>"

Login-AzureRmAccount -TenantId $TenantId

$OptionalParameters = New-Object -TypeName Hashtable
$OptionalParameters["automationName"] = $AutomationName
.\Deploy-AzureResourceGroup.ps1 -resourcegroupname $ResourceGroupName -ResourceGroupLocation $ResourceGroupLocation -OptionalParameters $OptionalParameters

