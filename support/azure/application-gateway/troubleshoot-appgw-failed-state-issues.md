---
title: Troubleshoot Failed state issues on Application Gateway
description: Identify the last failed operation and the reason of failed provisioning state of the Application Gateway.
ms.date: 04/07/2026
ms.author: iskau
ms.editor: iskau
ms.reviewer: iskau
ms.service: azure-application-gateway
ms.topic: troubleshooting-general
ms.custom: sap:Issues with Create, Update and Delete (CRUD)

---

# Troubleshoot Failed state issues on Application Gateway

This article explains how to investigate an Azure Application Gateway that is stuck in **Failed** provisioning state.
A failed state typically indicates a misconfiguration during the most recent Create or Update operation. The steps below help identify the customer‑facing error message and the root cause in most cases.

## Symptoms

The Provisioning state of the Application Gateway shows Failed in:  
- Azure Portal (Properties blade), or
- Azure PowerShell / Azure CLI

## How to identify the last failed operation

1. In the Azure Portal, navigate to: Application Gateway → Activity log.
2. Apply the following filters:  
Status: Failed
Time range: Relevant window when the issue occurred  
![Activity Logs](/media/troubleshoot-appgw-failed-state-issues/activitylog.png)

3. Open the most recent failed event.  
If multiple failures exist, start with the first failed operation, as subsequent failures are often cascading effects.

4. Review the operation details:  
Operation name (for example: 
Create or Update Application Gateway) indicates the failed action.
The Error code and Error message are visible in the Summary section.
For detailed diagnostics, expand the event and review the statusMessage field inside Properties section in the JSON view.

5. (Optional) Check Change history:  
Select the Change history tab to see configuration changes made up to 30 minutes before and after the failed operation, which can help pinpoint the change that triggered the failure.  

> Azure Monitor collects activity log entries by default with no required configuration. Azure retains activity log events for 90 days and then deletes them. You aren't charged for entries during this time, regardless of volume.

## Common Error Messages

### ApplicationGatewayKeyVaultSecretException

If you encounter this error message or "Problem occured while accessing and validating KeyVault Secrets associated with Application Gateway", verify the following configuration prerequisites:  
1. Ensure the user‑assigned managed identity associated with the Application Gateway has Get permission on secrets in the Key Vault.  
Refer to: [Delegate user-assigned managed identity to Key Vault](/azure/application-gateway/key-vault-certs#delegate-user-assigned-managed-identity-to-key-vault )
2. If you are using Service Endpoints on App Gateway to access key vault, the Application Gateway virtual network and subnet must be explicitly allowed in the Key Vault Firewall and virtual network settings.  
Refer to:[Verify Firewall Permissions to Key Vault](/azure/application-gateway/key-vault-certs#verify-firewall-permissions-to-key-vault)
3. If using Private Endpoints to access key vault, subnet whitelisting is not required in the vault's settings but you must link the privatelink.vaultcore.azure.net private DNS zone, containing the corresponding record to the referenced Key Vault, to the virtual network containing Application Gateway.  
Refer to: [Understanding DNS resolution in Application Gateway](/azure/application-gateway/application-gateway-dns-resolution)  

4. Confirm that the managed identity assigned to the Application Gateway exists and has not been deleted.
5. The associated Key Vault and the certificate object is not deleted or soft-deleted. 
6. The referenced secret/certificate must be in enabled state.

### Internal Server Error

This error message is unfortunately not indicative of the cause of failure at this time. Please open a [Support Request](/azure/azure-portal/supportability/how-to-create-azure-support-request) and provide the failed operation timestamp along with the correlationId which can be found in the JSON View of Activity Logs. 
