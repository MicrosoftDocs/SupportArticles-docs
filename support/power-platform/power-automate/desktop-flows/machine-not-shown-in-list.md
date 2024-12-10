---
title: Machine not listed when creating desktop flow connection 
description: Solves an issue where your machine isn't listed in the Machines or Group list when creating a desktop flow connection in Microsoft Power Automate for desktop.
author: ceporche
ms.author: ceporche
ms.writer: rbarni, alarnaud
ms.custom: sap:Desktop flows\Cannot create desktop flow connection
ms.date: 12/10/2024
---
# Your machine doesn't appear when creating a desktop flow connection 

This article helps you troubleshoot and resolve the issue that you might not see your machine listed in the **Machines** or **Group** drop-down list when creating a desktop flow connection in Microsoft Power Automate for desktop.

## Symptoms

When you [create a connection](/power-automate/desktop-flows/desktop-flow-connections) to run a desktop flow from the cloud, your machine isn't listed in the **Machines** or **Group** drop-down list.

## Cause

This issue might occur due to the following reasons:

- The machine is shared by another user, who either deleted or renamed the machine.
- The machine is part of a machine group. In this case, you can only create a connection with the machine group.

## Resolution

Follow these steps to troubleshoot and resolve the issue:

1. Open the Power Automate machine runtime app and verify that your machine is registered.

   :::image type="content" source="media/machine-not-shown-in-list/machine-registered-in-runtime-app.png" alt-text="The Your machine has been registered message is shown if your machine is registered in the Power Automate machine runtime app." lightbox="media/machine-not-shown-in-list/machine-registered-in-runtime-app.png":::

1. Go to the [Power Automate portal](https://make.powerautomate.com) and verify that you're using the same environment as your machine was in Power Automate for desktop.

    :::image type="content" source="media/machine-not-shown-in-list/current-environment-shown-in-power-automate-portal.png" alt-text="The environment shown in the Power Automate portal." lightbox="media/machine-not-shown-in-list/current-environment-shown-in-power-automate-portal.png":::

1. In Power Automate portal, check if your machine appears in the **Machines** list, and if it's part of a machine group.

   :::image type="content" source="media/machine-not-shown-in-list/machines-list-group-list.png" alt-text="The Machines and the Group lists shown in the Power Automate portal." lightbox="media/machine-not-shown-in-list/machines-list-group-list.png":::

    If the machine doesn't appear in the **Machines** list in the targeted environment, try [registering the machine](/power-automate/desktop-flows/manage-machines#register-a-new-machine) again in this environment.

    If the machine is part of a machine group, you can do one of the followings:

    - Select the machine group instead of an individual machine when you create the desktop flow connection.
    - Remove the machine from its group and select only that specific device for the desktop flow connection.
