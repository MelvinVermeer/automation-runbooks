param([object]$WebhookData)

$office365admin = Get-AutomationPSCredential -Name Office365Admin
Connect-MsolService -credential $office365admin

$settings = ConvertFrom-Json -inputobject $WebhookData.RequestBody

Set-MsolCompanySettings -SelfServePasswordResetEnabled $settings.SelfServePasswordResetEnabled

# Send HTTTP POST request to the webhook endpoint with the following JSON payload
#
# {
# 	"SelfServePasswordResetEnabled" : true
# } 