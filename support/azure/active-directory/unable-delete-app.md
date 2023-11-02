---
title: Unable to delete an application due to disabled Delete button
description: Understand why you're unable to delete an application due to disabled Delete button.
ms.date: 05/08/2023
author: bernawy
ms.author: bernaw
editor: v-jsitser
ms.reviewer: v-leedennis, jarrettr
ms.service: active-directory
ms.subservice: app-mgmt
content_well_notification: 
  - AI-contribution
---
# Unable to delete an application due to disabled Delete button

When deleting an app in Microsoft Entra ID, the Delete button may be disabled in certain scenarios. These scenarios include:

- For applications under Enterprise application, the Delete button will be disabled if you don't have one of the following roles: Global Administrator, Cloud Application Administrator, Application Administrator, or owner of the service principal.

- For Microsoft applications, you won't be able to delete them from the UI regardless of your role.

- For service principals that correspond to a managed identity, you can't delete the service principals in the Enterprise apps blade. You need to go to the Azure resource to manage it. To learn more about Managed Identity, please refer to the article [Managed Identity](/azure/active-directory/managed-identities-azure-resources/overview).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
