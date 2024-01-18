---
title: Can't identify the user shown in an error message 
description: Resolves an issue where you can't identify the user shown in an error message in Microsoft Dynamics 365 Field Service.
author: jasonxian-msft
ms.author: jasonxian
ms.reviewer: v-wendysmith
ms.date: 01/18/2024
---
# Can't identify the user shown in an error message in Dynamics 365 Field Service

This article resolves an issue where you can't identify the user shown in a Field Service error message that contains the user ID.

## Symptoms

In Microsoft Dynamics 365 Field Service, you receive an error message that contains a user ID from Dataverse, but you can't identify the user.

## Cause

The Dataverse error message related to a user shows the Dynamics 365 Field Service user ID instead of the [Microsoft Entra ID](/entra/fundamentals/new-name) user ID. In addition, the Dataverse user ID is specific to the environment.

## Resolution

> [!NOTE]
> You need administrator permissions in Dynamics 365 Field Service to perform the steps.

To identify the user, follow these steps:

1. In the Field Service app, select your Field Service environment.
1. In the bottom left corner, select **Settings** > **Users**.
1. Select a user, and the `systemuser&id` appears at the end of the URL.

   :::image type="content" source="media/cant-identify-user/systemuser-id.png" alt-text="Screenshot that shows the Field Service Settings Users page with the systemuser&id highlighted." lightbox="media/cant-identify-user/systemuser-id.png":::

1. Replace the ID number with the ID shown in the error message, and then press <kbd>Enter </kbd>. The user's account tied to this ID appears.
