---
title: Failed cloud service update because of ongoing migration progress
description: Resolve a cloud service update failure that occurs during a migration from Azure Cloud Services (classic) to Azure Cloud Services (extended support).
ms.date: 09/26/2022
editor: v-jsitser
ms.reviewer: v-maallu, piw, prpillai, v-leedennis
ms.service: cloud-services
ms.subservice: troubleshoot-deployment-classic
#Customer intent: As a cloud service user, I want to resolve a cloud service update failure that occurs when I migrate from Azure Cloud Services (classic) to Azure Cloud Services (extended support) so that I can avoid or reduce downtime.
---

# Azure Cloud Services update fails during a migration

This article discusses how to resolve a failed update to your cloud service that occurs during an in-place migration from Microsoft Azure Cloud Services (classic) to Azure Cloud Services (extended support).

## Symptoms

During a migration of your cloud service, you receive a `ChangeDeploymentConfigurationOperationFailed` error message in Azure Cloud Services (classic) or an `OperationNotAllowed` error message in Azure Cloud Services (extended support). These messages resemble the following examples.

### Azure Cloud Services (classic)

```output
"statusMessage": "{
    \"error\":{
        \"code\":\"ChangeDeploymentConfigurationOperationFailed\",
        \"message\":\"The Change Deployment Configuration operation failed for the
            domain '<classic cloud service name>' in the deployment slot 'production' with
            the name '<classic cloud service name>- x/xx/2022 xx:xx:xxPM': 'Deployment xx
                in HostedService <classic cloud service name> is in the process of
                being migrated and hence cannot be changed.'.\"
    }
}",
```

### Azure Cloud Services (extended support)

```output
"statusMessage": "{
    \"error\":{
        \"code\":\"OperationNotAllowed\",
        \"message\":\"The operation cannot be performed on cloud service
            '<classic cloud service name>' because a migration is in progress.
            Commit the migration to start managing the cloud service.\"
    }
}"
```

## Cause: Resources are locked after migration preparation

This error occurs after the in-place migration process from Azure Cloud Services (classic) to Azure Cloud Services (extended support) completes the preparation stage. At this point, resources are locked, and you can't continue the update process.

The following table describes the [stages of in-place migration](/azure/cloud-services-extended-support/in-place-migration-overview#migration-steps). After you complete the second stage (prepare migration), the resources are locked. If you try to update your cloud service during the next stage (to abort or commit the migration), you receive a notification that indicates that you can't update your cloud service.

| Stage name | Stage description |
|--|--|
| Validate migration | Validates that migration can still proceed during common unsupported scenarios. |
| Prepare migration | Duplicates the resource metadata in Azure Resource Manager. To make sure that resource metadata is in sync across Azure Server Manager and Azure Resource Manager, all resources are locked for create, update, and delete operations. However, all read operations will continue to work by using the APIs for both Azure Cloud Services (classic) and Azure Cloud Services (extended support). |
| Abort migration | Removes resource metadata from Azure Resource Manager. It unlocks all resources for create, update, and delete operations. |
| Commit migration | Removes resource metadata from Azure Service Manager. It unlocks the resource for create, update, and delete operations. Abort is no longer allowed after a commit is tried. |

## Solution 1: Abort the migration before you try the cloud service update

Before you update your cloud service, abort the ongoing migration from Azure Cloud Services (classic) to Azure Cloud Services (extended support). You can abort the migration by using the Azure portal or Azure PowerShell.

### [Portal](#tab/azure-portal)

To abort the migration in the Azure portal, follow these steps:

1. In the [Azure portal](https://portal.azure.com), search for and select **Cloud services (classic)**.

1. In the list of classic cloud services, select the cloud service that you want to migrate.

1. In the menu pane of your classic cloud service, select **Migrate to ARM**.

1. Repeat the actions to complete the "validate" and "prepare" stages, as described in [Migrate to Azure Cloud Services (extended support) using the Azure portal](/azure/cloud-services-extended-support/in-place-migration-portal).

1. Under the **3. Commit or abort** heading, select the **Abort** button.

1. If the abort initially fails, select the **Retry abort** button. The second attempt should fix the previous issue.

### [Azure PowerShell](#tab/azure-powershell)

Use the [Move-AzureService](/powershell/module/servicemanagement/azure/move-azureservice) cmdlet to abort the migration, as shown in the following code snippet:

```azurepowershell
$abortMigrationDetails = @{
    Abort = $True
    ServiceName = "<name-of-your-cloud-service>"
    DeploymentName = "<name-of-your-cloud-service-deployment>"
}
Move-AzureService @abortMigrationDetails
```

For more information, see [Migrate to Azure Cloud Services (extended support) using PowerShell](/azure/cloud-services-extended-support/in-place-migration-powershell).

---

After you abort the migration, all the extended-support cloud service resources are deleted automatically. Then, you can successfully update your classic cloud service.

## Solution 2: Commit the migration before you try the cloud service update

Before you update your cloud service, commit the ongoing migration from Azure Cloud Services (classic) to Azure Cloud Services (extended support). You can commit the migration by using the Azure portal or Azure PowerShell.

### [Portal](#tab/azure-portal)

To commit the migration in the Azure portal, follow these steps:

1. In the [Azure portal](https://portal.azure.com), search for and select **Cloud services (classic)**.

1. In the list of classic cloud services, select the cloud service that you want to migrate.

1. In the menu pane of your classic cloud service, select **Migrate to ARM**.

1. Repeat the actions to complete the "validate" and "prepare" stages, as described in [Migrate to Azure Cloud Services (extended support) using the Azure portal](/azure/cloud-services-extended-support/in-place-migration-portal).

1. Under the **3. Commit or abort** heading, enter **yes** in the box to confirm that you want to proceed, and then select the **Commit** button.

### [Azure PowerShell](#tab/azure-powershell)

Use the [Move-AzureService](/powershell/module/servicemanagement/azure/move-azureservice) cmdlet to commit the migration, as shown in the following code snippet:

```azurepowershell
$commitMigrationDetails = @{
    Commit = $True
    ServiceName = "<name-of-your-cloud-service>"
    DeploymentName = "<name-of-your-cloud-service-deployment>"
}
Move-AzureService @commitMigrationDetails
```

For more information, see [Migrate to Azure Cloud Services (extended support) using PowerShell](/azure/cloud-services-extended-support/in-place-migration-powershell).

---

After you commit the migration, your classic cloud service is migrated to the corresponding extended-support cloud service. The classic cloud service is then deleted, and you can update the migrated, extended-support cloud service successfully.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
