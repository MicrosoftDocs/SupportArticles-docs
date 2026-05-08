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

This article explains how to investigate a gateway in Microsoft Azure Application Gateway that's stuck in **Failed** provisioning state.

A failed state typically indicates a misconfiguration during the most recent create or update operation. The following steps help you identify the customer-facing error message and the root cause in most cases.

## Symptoms

The **Provisioning** state of the application gateway appears as **Failed** in the following locations:

- The Azure portal (for example, the **Properties** blade)
- Azure PowerShell
- Azure CLI

## Identify the last failed operation

To identify the last failed operation that caused the application gateway to enter the **Failed** provisioning state, follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to **Application Gateway** > **Activity log**.
1. Apply the following filters: 

   - **Resource: [Your Application Gateway resource name]**
   - **Status: Failed**
   - **Time range: Relevant window when the issue occurred**  

:::image type="content" source="media/troubleshoot-appgw-failed-state-issues/activitylog.png" alt-text="Screenshot of activity log filters." lightbox="media/troubleshoot-appgw-failed-state-issues/activitylog.png":::

1. Open the most recent failed event. If multiple failures exist, start with the first failed operation because, often, subsequent failures are cascading effects.

4. Review the operation details:

   - **Operation name** indicates the failed action.
   - **Error code** and **Error message** are visible in the **Summary** section.
   - For detailed diagnostics, expand the event, and review the **statusMessage** field inside the **Properties** section in the **JSON** view.

1. (Optional) Check the change history. Select the **Change history** tab to see configuration changes that were made up to 30 minutes before and after the failed operation. This information can help you pinpoint the change that triggered the failure.  

> [!NOTE]
> Azure Monitor collects activity log entries by default without a required configuration. Azure retains activity log events for 90 days, and then deletes them. You aren't charged for entries during this time, regardless of volume.

## Common error messages

### ApplicationGatewayKeyVaultSecretException 

If you receive this error message, or the "Problem occurred while accessing and validating KeyVault Secrets associated with Application Gateway" error message, verify the following configuration prerequisites:
  
- Make sure that the user‑assigned managed identity that's associated with the application gateway has `Get` permission on secrets in the key vault. For more information, see [Delegate user-assigned managed identity to Key Vault](/azure/application-gateway/key-vault-certs#delegate-user-assigned-managed-identity-to-key-vault).
- If you're using service endpoints to access the key vault, the Application Gateway virtual network and subnet must be explicitly allowed in the Azure Key Vault firewall and virtual network settings. For more information, see [Verify Firewall Permissions to Key Vault](/azure/application-gateway/key-vault-certs#verify-firewall-permissions-to-key-vault).
- If you're using private endpoints to access Azure Key Vault, a subnet allow listing isn't required in the vault's settings. However, you have to link the `privatelink.vaultcore.azure.net` private DNS zone to the virtual network that contains the gateway. This private DNS zone also contains the corresponding record to the referenced key vault. For more information, see [Understanding DNS resolution in Application Gateway](/azure/application-gateway/application-gateway-dns-resolution).  
- Verify that the managed identity that's assigned to the application gateway exists and isn't deleted.
- Verify that the associated key vault and the certificate object aren't deleted or soft-deleted. 
- Verify that the referenced secret and certificate are in an **Enabled** state.

### Internal Server Error

This error message doesn't indicate the cause of failure. In this case, open a [support request](/azure/azure-portal/supportability/how-to-create-azure-support-request). Provide the failed operation timestamp together with the **correlationId** from the **Properties** section of the failed activity log event in the **JSON** view. 
