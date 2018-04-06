param([object]$WebhookData)
$WebhookConfig = ConvertFrom-Json -inputobject $WebhookData.RequestBody

.\set-companysettings.ps1 -CompanySettings $WebhookConfig.CompanySettings

# Send HTTTP POST request to the webhook endpoint with the following JSON payload
#
# {
#   "CompanySettings" : {
#    "SelfServePasswordResetEnabled" : true
#   }
# } 
