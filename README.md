# Automation Script

This document describes the workings and expected outcomes of the `automation.ps1` and the `template.json`.

## Script
The following steps are performed by the script:

1. Deploy ARM Template

### Credentials 
This script will ask for crendentials on start. The user running this script should be account owner in Azure of the given subscription. 

## ARM Template
The Azure Resource Manager Template will deploy the following items into one resource group.
- Automation Account
    - Module: MSOnline