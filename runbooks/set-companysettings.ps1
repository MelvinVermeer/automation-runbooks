param([object]$CompanySettings)
Write-Output "Company Settings"
$CompanySettings | Format-List

$office365admin = Get-AutomationPSCredential -Name Office365Admin
Connect-MsolService -credential $office365admin

Set-MsolCompanySettings -SelfServePasswordResetEnabled $CompanySettings.SelfServePasswordResetEnabled