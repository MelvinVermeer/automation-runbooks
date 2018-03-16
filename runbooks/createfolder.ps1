param([object]$WebhookData)
$Data = ConvertFrom-Json -inputobject $WebhookData.RequestBody

$Folder = "C:\Temp\" + $Data.FolderName

New-Item -ItemType directory -Path $Folder