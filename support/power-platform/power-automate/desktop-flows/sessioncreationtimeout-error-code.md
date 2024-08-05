---
title: Desktop flow fails with SessionCreationTimeout error code
description: Provides a resolution for the issue that desktop flow unattended runs fail with error code SessionCreationTimeout in Power Automate.
ms.reviewer: moelaabo
ms.date: 09/21/2022
ms.custom: sap:Desktop flows\Power Automate for desktop errors
---
# Desktop flow fails with the SessionCreationTimeout error code

This article provides a resolution to an issue where desktop flow unattended runs fail and you receive the **SessionCreationTimeout** error code in Microsoft Power Automate for desktop.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 5016026

## Symptoms

Your desktop flow unattended runs fail with the error code **SessionCreationTimeout** (see the below screenshot).

:::image type="content" source="media/sessioncreationtimeout-error-code/sessioncreationtimeout-error-code.png" alt-text="The details of the SessionCreationTimeout error code.":::

## Cause

When creating a Windows session for unattended runs, Power Automate for desktop has a default timeout of 3 minutes. Thus, if a remote desktop connection to your machine takes more than 3 minutes, your unattended runs will fail.

## Resolution

The first thing to do is to make sure that you have the latest version of Power Automate for desktop. If you still have the issue, you may need to increase the timeout duration of the Windows session creation. Note that these steps are only supported on versions 2.21 or later. To do this, follow these steps:

1. Open the Registry Editor. To open it, you can open the Start menu and type _Run_ to get the Run application. Type _regedit_ in the text field and select **OK**.

   :::image type="content" source="media/sessioncreationtimeout-error-code/type-regedit.png" alt-text="Steps to open the Registry Editor." border="false":::

2. In the path _Computer\HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Power Automate Desktop\Service_, create a new DWORD and give it the name _SessionCreationTimeoutSeconds_. The value you should assign to it is the maximum duration in seconds allowed for session creation. The below screenshot shows a new timeout value of five minutes.

   :::image type="content" source="media/sessioncreationtimeout-error-code/create-sessioncreationtimeoutseconds.png" alt-text="Steps to create a new DWORD SessionCreationTimeoutSeconds with a timeout value.":::

3. Restart Power Automate service. To do this, open Services application, right-click **Power Automate service** and select **Restart**.

   :::image type="content" source="media/sessioncreationtimeout-error-code/restart-power-automate-service.png" alt-text="Steps to restart the Power Automate service.":::
