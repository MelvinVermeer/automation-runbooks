param([object]$WebhookData)

$office365admin = Get-AutomationPSCredential -Name Office365Admin
Connect-MsolService -credential $office365admin

$user = ConvertFrom-Json -inputobject $WebhookData.RequestBody

New-MsolUser -DisplayName $user.DisplayName `
-FirstName $user.FirstName `
-LastName $user.LastName `
-UserPrincipalName $user.UserPrincipalName

# Send HTTTP POST request to the webhook endpoint with the following JSON payload
#
# {
# 	"DisplayName" : "SampleUser",
# 	"FirstName" : "Sample",
# 	"LastName" : "User",
# 	"UserPrincipalName" : "Sample.User@yourdomain.onmicrosoft.com"
# }