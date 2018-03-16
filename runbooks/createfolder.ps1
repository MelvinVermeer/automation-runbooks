param([object]$WebhookData)
$Data = ConvertFrom-Json -inputobject $WebhookData.RequestBody

$Folder = "C:\Temp\" + $Data.FolderName

New-Item -ItemType directory -Path $Folder

# Send HTTTP POST request to the webhook endpoint with the following JSON payload
#
# {
# 	"FolderName" : "SampleFolder"
# }