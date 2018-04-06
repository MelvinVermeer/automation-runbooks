$ConfigurationLocation = "https://raw.githubusercontent.com/MelvinVermeer/automation-runbooks/master/configuration.xml"

[xml]$Xml = Invoke-WebRequest $ConfigurationLocation

.\set-companysettings.ps1 -CompanySettings $Xml.Configuration.CompanySettings