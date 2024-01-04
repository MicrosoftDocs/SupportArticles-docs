---
title: A user in a Field Service error message can't be identified 
description: Resolves issues trying to identify the user in an error message in Dynamics 365 Field Service.
author: jasonxian-msft
ms.author: jasonxian
ms.reviewer: v-wendysmith
ms.date: 01/04/2024
---
# A user in a Field Service error message can't be identified

This article helps administrators resolve issues identifying a user in a Field Service error message that contains a user ID.

## Prerequisites

You have administrator permissions in Dynamics 365 Field Service.

## Symptoms

A user ID is listed in an error message from Dataverse and I can't identify the user.

## Resolution

Dataverse errors relating to a user show the Field Service user ID, not the Microsoft Entra ID. The Dataverse user ID is specific to the environment. To identify the user:

1. In the Field Service app, select your Field Service environment.

1. On the bottom left, select **Settings** > **Users**.

1. Select any user so that the `systemuser&id` appears at the end of the URL.

   :::image type="content" source="media/fs-user-id.png" alt-text="Screenshot of Field Service Settings Users page with the systemuser&id highlighted.":::

1. Replace the ID number with the ID in the error message and press **Enter**. The user's account tied to this ID appears.
