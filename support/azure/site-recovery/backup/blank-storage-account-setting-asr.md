---
title: Storage account setting is blank in Azure Site Recovery
description: Fixes an issue in which the Storage Account list is blank when you try to configure protection group settings in Azure Site Recovery.
ms.date: 10/10/2020
ms.service: azure-site-recovery
ms.author: jarrettr
author: JarrettRenshaw
ms.reviewer: markstan
ms.custom: sap:I need help with Azure Backup
---
# Storage account setting is blank in Azure Site Recovery

_Original product version:_ &nbsp; Azure Backup  
_Original KB number:_ &nbsp; 3093586

## Symptoms

When you try to configure protection group settings in Microsoft Azure Site Recovery, the **Storage Account** list may be blank. This issue prevents the wizard from being able to finish.

:::image type="content" source="media/blank-storage-account-setting-asr/create-protection-group.png" alt-text="Screenshot of specifying Protection Group Settings in Microsoft Azure Site Recover.":::

The setup process is described in the following article: [Set up protection between on-premises VMware virtual machines or physical servers and Azure](/azure/site-recovery/vmware-azure-tutorial).

## Cause

This error may occur if the storage account isn't configured to be geo-redundant. Storage accounts are geo-redundant by default. You can manually disable geo-redundancy during account setup.

## Resolution

To fix this issue, follow these steps:

1. Cancel the Create Protection Group wizard.
2. Either create a new storage account or change the replication setting to **geo redundant**. This setting is located under the storage account settings properties on the **Configure** tab in the Azure portal.
3. Click Save to commit the change.
4. Restart the Create Protection Group wizard.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
