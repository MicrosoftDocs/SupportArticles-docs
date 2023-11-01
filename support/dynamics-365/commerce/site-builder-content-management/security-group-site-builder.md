---
title: Can't configure a security group for Commerce site builder during initial deployment
description: Resolves an issue where the Microsoft Entra security group for Commerce site builder doesn't appear as an option when creating e-commerce components in Dynamics LCS during initial deployment of a new e-commerce tenant.
author: josaw1 
ms.author: josaw
ms.reviewer: rassadi, brstor
ms.date: 09/01/2023
---
# Can't configure a security group for Commerce site builder during initial deployment

This article provides a resolution for an issue where the Microsoft Entra security group for Commerce site builder doesn't appear as an option when you create [e-commerce components](/dynamics365/commerce/e-commerce-extensibility/ecommerce-components) in [Microsoft Dynamics Lifecycle Services (LCS)](https://lcs.dynamics.com/) during the initial deployment of a new e-commerce tenant.

## Symptoms

When you create the e-commerce components as part of the process of deploying a new e-commerce tenant that includes the Commerce site builder component, the Microsoft Entra security group doesn't appear as an option in the dialog box.

## Resolution

To solve this issue, provision the e-commerce site with a user in the correct tenant.

1. Go to the [Azure portal](https://portal.azure.com/).
1. Under the tenant where the LCS project for your e-commerce site was provisioned, follow the instructions in [Create a basic group and add members using Microsoft Entra ID](/azure/active-directory/fundamentals/active-directory-groups-create-azure-portal).
1. Go to [LCS](https://lcs.dynamics.com/) and sign in by using an account that shares the same tenant as the Microsoft Entra security group that you just created. The account must have access to view the Microsoft Entra security group.
1. Complete the setup steps to configure the e-commerce site. When you provision the e-commerce components, the security group should appear as an option in the dialog box.

> [!NOTE]
> To ensure that the field in the dialog box is filled with the list of security groups, you must select **Enter** after you enter the name of the Microsoft Entra security group that you created. The search results will list all the Microsoft Entra security groups that start with the search text, and that the user has access to. You can use a shorter search term to allow broader search results.

## More information

- [Create a basic group and add members using Microsoft Entra ID](/azure/active-directory/fundamentals/active-directory-groups-create-azure-portal)
- [Deploy a new e-commerce tenant](/dynamics365/commerce/deploy-ecommerce-site)
