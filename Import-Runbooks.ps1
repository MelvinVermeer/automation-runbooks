Param(
    [string] [Parameter(Mandatory=$true)] $Folder,
    [string] $ResourceGroupName,
    [string] $AutomationName,
    [string] $HybridWorkerGroup
)

Get-ChildItem $Folder -Filter *.ps1 | 
Foreach-Object {
    Import-AzureRMAutomationRunbook -Path $_.FullName -ResourceGroupName $ResourceGroupName -AutomationAccountName $Account -Type PowerShell -Published:$true -Force | out-null
}

Write-Host 'Creating web hooks'
$Webhook1 = New-AzureRmAutomationWebhook `
-Name "newuser" `
-IsEnabled $true `
 -ExpiryTime "10/2/2019" `
 -RunbookName "newuser" `
 -ResourceGroup $ResourceGroupName `
 -AutomationAccountName $AutomationName `
 -Force
 
 $Webhook2 = New-AzureRmAutomationWebhook `
 -Name "createfolder" `
 -IsEnabled $true `
 -ExpiryTime "10/2/2019" `
 -RunbookName "createfolder" `
 -ResourceGroup $ResourceGroupName `
 -AutomationAccountName $AutomationName `
 -Force `
 -RunOn $HybridWorkerGroup 

Write-Host ''
Write-Host 'Copy web hook urls. For security reasons they are not retrievable after this moment.'
Write-Host ''
write-host "Web hook for folder creation (local)"
write-host $Webhook2.WebhookURI
Write-Host ''
write-host "Web hook for user creation (cloud)"
write-host $Webhook1.WebhookURI