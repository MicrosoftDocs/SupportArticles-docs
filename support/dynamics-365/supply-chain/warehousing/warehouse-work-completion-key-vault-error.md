---
title: Fix Warehouse work completion Key Vault error
description: Warehouse work completion fails and generates an Operation canceled error in Dynamics 365 Supply Chain Management if Key Vault parameters aren't configured.
ms.date: 06/10/2026
ms.reviewer: ivanma, v-shaywood
ms.custom: sap:Warehouse management
---
# Warehouse work completion fails if Key Vault isn't configured

## Summary

This article helps you fix an issue in which warehouse work completion fails and generates an "Operation canceled: Work" error. The failure occurs if an active [business event](/dynamics365/fin-ops-core/dev-itpro/business-events/home-page) is sent to an Azure endpoint whose secrets are stored in [Azure Key Vault](/azure/key-vault/general/overview), but the required Key Vault parameters aren't configured.

## Symptoms

When a warehouse worker completes work from the **All work** page (**Warehouse management** > **Work** > **All work**) or from the [Warehouse Management mobile app](/dynamics365/supply-chain/warehousing/install-configure-warehouse-management-app), the operation fails, and the worker receives an error message that resembles the following message:

> Operation canceled: Work

The failure occurs consistently during work completion in a sandbox environment. It often occurs after a [sandbox refresh from production](/dynamics365/fin-ops-core/dev-itpro/database/database-refresh).

The call stack for the failure resembles the following.

```text
WHSWorkComplete form -> ButtonComplete.clicked()
  -> WhsWorkCompleteForm.buttonComplete_clicked()
    -> WhsWorkManualComplete.executeWork()
      -> SysOperationSandbox.callStaticMethod()
        -> SysOperationSandbox.executeSandboxMethod()
          -> Business Events validation -> Key Vault params empty -> FAIL
            -> SysOperationSandbox_OperationCanceled: "Operation canceled: Work"
```

## Cause

A business event, typically **Warehouse work completed**, fires during work completion. The configuration for the business event sends it to one or more endpoints. One of the endpoints is an Azure endpoint whose secrets are stored in Key Vault. Because the required Key Vault parameters aren't configured in the environment, the system can't retrieve those secrets. Therefore, business events validation fails and cancels the work completion operation.

The following business events Key Vault parameters are empty:

- `BusinessEventsKeyVaultDnsName`
- `BusinessEventsKeyVaultSecretName`
- `BusinessEventsAzureAppId`
- `BusinessEventsAzureAppSecret`

> [!NOTE]
> For security, a sandbox refresh doesn't copy Key Vault secrets. You must re-enter the secrets manually after each refresh.

## Solution

Use one of the following options, depending on whether the business event is needed in the affected environment.

### Configure the Key Vault parameters

If the business event must continue to fire in the affected environment, configure the required Key Vault parameters:

1. Go to **System administration** > **Setup** > **Key Vault parameters**.
1. Create or update the entry that the business event endpoint uses, and enter the following values:

    - **Key Vault DNS Name** (for example, `https://<VaultName>.vault.azure.net/`)
    - **Key Vault Secret Name**
    - **Microsoft Entra ID Application ID**
    - **Microsoft Entra ID Application Secret**

1. To verify that the connection to Key Vault succeeds, select **Validate**.
1. To verify that the warehouse work completion succeeds, retry the operation.

### Disable the business event endpoint

If the business event isn't needed in the affected environment (for example, in a sandbox that's used only for testing), deactivate the endpoint:

1. Go to **System administration** > **Setup** > **Business events** > **Business events catalog**.
1. Locate the warehouse work completion business event (for example, **Warehouse work completed**).
1. Deactivate the endpoint whose secrets are stored in Key Vault.
1. To verify that the warehouse work completion succeeds, retry the operation.

## Related content

- [Troubleshoot business events](/dynamics365/fin-ops-core/dev-itpro/business-events/troubleshooting)
- [Manage business event endpoints](/dynamics365/fin-ops-core/dev-itpro/business-events/managing-business-event-endpoints)
