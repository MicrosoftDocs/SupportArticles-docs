---
title: User personalization can't be started in Business Central
description: Provides troubleshooting steps to solve the personalization could not be started error during user personalization in Dynamics 365 Business Central.
author: SusanneWindfeldPedersen
ms.author: solsen
ms.reviewer: solsen
ms.date: 05/16/2024
---
# User personalization can't be started in Business Central

This article provides a resolution for the "personalization could not be started" error that occurs during user personalization in Dynamics 365 Business Central.

## Symptoms

When there are issues preventing the [user personalization](/dynamics365/business-central/ui-personalization-user) in Business Central, the user receives the following error message, and can't start user personalization.

> Sorry, something went wrong and personalization could not be started. Please try again later, or contact your system administrator.

## Resolution

> [!NOTE]
>
> - To solve this issue, you need tenant administrator permissions in Business Central.
> - The following steps will delete records with compilation errors and the specific user personalizations will be deleted. It's recommended to take a screenshot of any personalizations done, before deleting them.

Follow these steps to mitigate the issue:

1. In Business Central, in the [Tell Me](/dynamics365/business-central/dev-itpro/developer/devenv-al-menusuite-functionality) box, enter *Personalized Pages*, and then select the related link.
2. On the **Personalized Pages** page, use the filter pane to show records that belong to the impacted user.
3. Select the **Troubleshoot** button.

   You'll now get a list of all records that contain errors. These records must be removed to unblock the user from starting user personalization.  

4. Select the **Manage** action to delete the user personalizations with errors.
