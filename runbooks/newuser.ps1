param([object]$WebhookData)

$office365admin = Get-AutomationPSCredential -Name Office365Admin
Connect-MsolService -credential $office365admin

$user = ConvertFrom-Json -inputobject $WebhookData.RequestBody

New-MsolUser -DisplayName $user.DisplayName `
-FirstName $user.FirstName `
-LastName $user.LastName `
-UserPrincipalName $user.UserPrincipalName