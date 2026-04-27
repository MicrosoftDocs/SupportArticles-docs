---
title: Troubleshoot Failed state issues on Application Gateway
description: Identify the last failed operation and root cause when Application Gateway enters a Failed provisioning state, then use these steps to resolve it.
ms.date: 04/07/2026
ms.author: iskau
ms.editor: v-jsitser
ms.reviewer: giverm
ms.service: azure-application-gateway
ms.topic: troubleshooting-general
ms.custom: sap:Issues with Create, Update and Delete (CRUD)

---

# Troubleshoot Failed state issues on Azure Application Gateway

## Summary

This article explains how to investigate an Azure Application Gateway that is stuck in **Failed** provisioning state.

A failed state typically indicates a misconfiguration during the most recent create or update operation. The following steps help you identify the customer-facing error message and the root cause in most cases.

## Symptoms

The **Provisioning** state of the Application Gateway shows **Failed** in:    

- The Azure portal (for example, the **Properties** blade).
- Azure PowerShell.
- Azure CLI.

## Identify the last failed operation

To identify the last failed operation that caused the Application Gateway to enter the **Failed** provisioning state, complete the following steps:

1. In the [Azure portal](https://portal.azure.com), go to **Application Gateway** > **Activity log**.
1. Apply the following filters: 

 - **Resource: [Your Application Gateway resource name]**
 - **Status: Failed**
 - **Time range: Relevant window when the issue occurred**  

:::image type="content" source="media/troubleshoot-appgw-failed-state-issues/application-gateway-activity-log-failed-operation.png" alt-text="Screenshot of the Application Gateway activity log details view." lightbox="media/troubleshoot-appgw-failed-state-issues/application-gateway-activity-log-failed-operation.png":::

1. Open the most recent failed event. If multiple failures exist, start with the first failed operation, as subsequent failures often are cascading effects.

4. Review the operation details.  

- **Operation name** indicates the failed action.
- **Error code** and **Error message** are visible in the **Summary** section.
- For detailed diagnostics, expand the event and review the **statusMessage** field inside **Properties** section in the **JSON** view.

1. (Optional) Check the change history. Select the **Change history** tab to see configuration changes made up to 30 minutes before and after the failed operation. This information can help you pinpoint the change that triggered the failure.  

> [!NOTE]
> Azure Monitor collects activity log entries by default with no required configuration. Azure retains activity log events for 90 days and then deletes them. You aren't charged for entries during this time, regardless of volume.

## Common error messages

### ApplicationGatewayKeyVaultSecretException 

If you encounter this error message or "Problem occurred while accessing and validating KeyVault Secrets associated with Application Gateway", verify the following configuration prerequisites:
  
- Ensure the user‑assigned managed identity associated with the Application Gateway has `Get` permission on secrets in the Key Vault. For more information, see [Delegate user-assigned managed identity to Key Vault](/azure/application-gateway/key-vault-certs#delegate-user-assigned-managed-identity-to-key-vault).
- If you're using service endpoints to access the Key Vault, the Application Gateway virtual network and subnet must be explicitly allowed in the Key Vault firewall and virtual network settings. For more information, see [Verify Firewall Permissions to Key Vault](/azure/application-gateway/key-vault-certs#verify-firewall-permissions-to-key-vault).
- If you're using private endpoints to access Key Vault, subnet allow listing isn't required in the vault's settings. However, you need to link the `privatelink.vaultcore.azure.net` private DNS zone (which contains the corresponding record to the referenced Key Vault) to the virtual network containing the Application Gateway. For more information, see [Understanding DNS resolution in Application Gateway](/azure/application-gateway/application-gateway-dns-resolution).  
- Confirm that the managed identity assigned to the Application Gateway exists and isn't deleted.
- Confirm that the associated Key Vault and the certificate object aren't deleted or soft-deleted. 
- Confirm that the referenced secret and certificate are in an **Enabled** state.

### Internal Server Error

This error message isn't indicative of the cause of failure. In this case, open a [support request](/azure/azure-portal/supportability/how-to-create-azure-support-request) and provide the failed operation timestamp along with the **correlationId**  found in the **Properties** section of the failed activity log event in the **JSON** view. 
