# Automation Script

This document describes the workings and expected outcomes of the `automation.ps1` and the `template.json`.

## Script
At the current moment the script and template are under active development, therefore one of the first things it does is clean-up using `Remove-AzureRmResourceGroup`

For the same reason there is a registry key clean-up of an exsting Hybrid Worker registrion at `HKLM:\SOFTWARE\Microsoft\HybridRunbookWorker`

The following steps are performed by the script:

1. Remove resource group
2. Deploy ARM Template
3. Install Hybrid Worker on machine
4. Import runbooks and create web hooks

### Credentials 
This script will ask for crendentials on start. The user running this script should be account owner in Azure of the given subscription. 

Once the script will reach the step where it registers the `New-OnPremiseHybridWorker` it will ask for the same permission. This cmdlet is not under our control so we cannot change this.

The ARM Template deployment will ask for `credentials_0365_username` and `credentials_0365_password`. This account will be used by the runbooks to change things in Office365. Therefor the account should have the admin role in Office365.

## ARM Template
The Azure Resource Manager Template will deploy the following items into one resource group.
- Automation Account
    - Credential: Office365Admin
    - Module: MSOnline
- OMS Workspace

