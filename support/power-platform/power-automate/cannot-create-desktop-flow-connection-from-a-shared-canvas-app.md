---
title: Can't create a desktop flows connection from a shared canvas app
description: Provides a workaround for an issue where a canvas app embedding a desktop flows connection is shared.
ms.reviewer: 
ms.author: cvassallo
author: V-Camille
ms.date: 03/15/2023
ms.subservice: power-automate-desktop-flows
---
# Can't create a desktop flows connection from a shared canvas app

This article provides a workaround for a scenario where a canvas app embedding a desktop flows connection is shared. In this scenario, if the user to whom the app is shared doesn't have a desktop flows connection, the user is asked to create a new one from an embedded window in the canvas app, which doesn't work properly.

_Applies to:_ &nbsp; Power Automate for desktop, Power Apps canvas

## Symptoms

Mira has been shared a Power Apps canvas app from Jefferson (the app embeds a desktop flows connection). The following screenshot shows what appears in Mira's apps list:

:::image type="content" source="media/cannot-create-desktop-flow-connection-from-a-shared-canvas-app/app-list.png" alt-text="Screenshot shows that the shared app is shown in the app list in Power Apps.":::

> [!NOTE]
> Whether the app was shared with Mira as a user or co-owner makes no difference in this scenario.

When Mira runs the app:

- Mira is asked to provide her own desktop flows connection because Mira has none already created connection in this environment.

  :::image type="content" source="media/cannot-create-desktop-flow-connection-from-a-shared-canvas-app/provide-connection.png" alt-text="Screenshot that shows the dialog box asks to provide your own desktop flows connection.":::

- To do so, Mira selects **Sign in** to create the new connection. The following form appears:

  :::image type="content" source="media/cannot-create-desktop-flow-connection-from-a-shared-canvas-app/create-connection.png" alt-text="The broken desktop flows connection creation form.":::

- On this form:

  - The **Machine or machine group** field is malfunctioning as it should provide a list of user-available machines or machine groups.
  - Instead, the field shows as a free text input. It expected a **machine group id**, which isn't transcribed on the UI.

## Resolution

The workaround for this issue is to create a connection from the **Connections** page and then reopen the app. Here are the steps:

1. Close the shared app.
2. Open the **Connections** page.
3. Select **New connection** > **Desktop flows**.
4. Create your connection. The **Machine or machine group** field is functional and provides a list of user-available devices.

   :::image type="content" source="media/cannot-create-desktop-flow-connection-from-a-shared-canvas-app/correct-connection-creation-form.png" alt-text="Screenshot that shows the correct desktop flows connection creation form.":::

5. Reopen the shared app. The previously created connection is auto-selected.

   :::image type="content" source="media/cannot-create-desktop-flow-connection-from-a-shared-canvas-app/auto-selected-connection.png" alt-text="Screenshot that shows that the previously created connection is auto-selected to allow the permissions.":::

6. Select **Allow**.

You now have access to the running canvas app.
