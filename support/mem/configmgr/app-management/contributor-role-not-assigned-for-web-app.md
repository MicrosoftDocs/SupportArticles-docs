---
title: Contributor role is no longer assigned for a web app at the subscription level
description: Introduces a change to Contributor role assignment when you create CMG with ARM deployment in Configuration Manager current branch version 1810 and later versions.
ms.date: 12/05/2023
ms.reviewer: kaushika
ms.custom: sap:Cloud Services\Cloud Management Gateway (CMG)
---
# Contributor role is no longer assigned for a web app at the subscription level in Azure

This article describes a change that **Contributor** role is no longer assigned for a web application at the subscription level in Configuration Manager current branch version 1810 and later versions.

_Original product version:_ &nbsp; Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 4483868

## Summary

Starting in Configuration Manager current branch version 1810, [the classic service deployment in Azure is deprecated](/mem/configmgr/core/plan-design/changes/deprecated/removed-and-deprecated-cmfeatures). When you create a cloud management gateway (CMG) by using the Azure Resource Manager (ARM) deployment type, **Contributor** role assignment is limited to resource groups when the service is deployed. **Contributor** role at the subscription level is no longer assigned for the web application. The web application will have only **Read** permission at the subscription level.

## More information

For existing CMG cloud services, **Contributor** role assignment remains at the subscription level. If you want to restrict web application permissions at the subscription level, remove the **Contributor** role assignment at this level only. To do this, follow these steps:

1. Open the **Access control (IAM)** blade for the resource group, and verify that the application has the **Contributor** role assigned.

    :::image type="content" source="media/contributor-role-not-assigned-for-web-app/access-control-in-resource-group.png" alt-text="Screenshot of the Role assignments tab in the Access control blade." lightbox="media/contributor-role-not-assigned-for-web-app/access-control-in-resource-group.png":::

2. Open the **IAM** blade for the subscription, and then remove the **Contributor** role assignment for the application.

    :::image type="content" source="media/contributor-role-not-assigned-for-web-app/access-control-in-subscription.png" alt-text="Screenshot of the Remove button in the Access control blade." lightbox="media/contributor-role-not-assigned-for-web-app/access-control-in-subscription.png":::

> [!NOTE]
> Don't delete the web app completely from the subscription. If you do that, Configuration Manager loses some dependencies on Azure objects.
