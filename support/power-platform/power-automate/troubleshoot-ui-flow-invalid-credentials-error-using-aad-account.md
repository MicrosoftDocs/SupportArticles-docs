---
title: Troubleshoot UI flow invalid credentials error using Microsoft Entra account
description: How to troubleshoot the errors of InvalidConnectionCredentials or WindowsIdentityIncorrect when running your UI flow.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: power-automate-flows
---
# Troubleshoot desktop flow invalid credentials error using Microsoft Entra account

This article provides a resolution to troubleshoot the errors of InvalidConnectionCredentials or WindowsIdentityIncorrect when running your UI flow.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4555623

## Symptoms

A flow that ran using a Microsoft Entra account fails with the **InvalidConnectionCredentials** or **WindowsIdentityIncorrect** error codes.

:::image type="content" source="media/troubleshoot-ui-flow-invalid-credentials-error-using-aad-account/error-invalid-connection-credentials.png" alt-text="Screenshot of the InvalidConnectionCredentials error code." lightbox="media/troubleshoot-ui-flow-invalid-credentials-error-using-aad-account/error-invalid-connection-credentials.png":::

:::image type="content" source="media/troubleshoot-ui-flow-invalid-credentials-error-using-aad-account/error-windows-identity-incorrect.png" alt-text="Screenshot of the WindowsIdentityIncorrect error code.":::

## Cause

There are many reasons you may get this error when using a Microsoft Entra account:

- The account credentials entered into the connection may not match those on the machine.
- The device may not be Microsoft Entra joined (or Microsoft Entra hybrid joined) to support Microsoft Entra authentication.
- The Microsoft Entra account may not be synchronized to the machine.

## Resolution

First, ensure that the device is Microsoft Entra joined or domain-joined:

1. Open a command prompt.
2. Run the command `dsregcmd /status`.
3. Check the Device State section.

:::image type="content" source="media/troubleshoot-ui-flow-invalid-credentials-error-using-aad-account/command-output.png" alt-text="Screenshot of the device state in the command prompt when running dsregcmd /status.":::

Make sure that one of the `DomainJoined` or `AzureAdJoined` values is **YES**.

If it is not the case, a Microsoft Entra account can't be used unless the device is joined, see the Microsoft documentation on [How to join a device](/azure/active-directory/user-help/user-help-join-device-on-network#to-join-an-already-configured-windows-10-device).

Second, identify the Microsoft Entra account to use in the machine configuration:

1. Open **Settings** and select **Accounts**.
2. Select **Access work or school**.
3. Make sure you see text that says something like, Connected to <your_organization> Microsoft Entra ID. The account by which it says it's connected can be used in the connection.

Third, synchronize the Microsoft Entra account on the device. To do this:

1. Select the **Info** button when selecting your Microsoft Entra connection in the **Access work or school** screen.
2. This will open a screen that describes your connection info and device sync status. There will be a button **Sync** at the end of this, select this button, and wait for this process to complete.

Fourth, check that the configured Microsoft Entra account can log into the device:

1. Try to sign in to the machine using the Microsoft Entra account identified in the step above.
2. The device login must be successful in order to be used in a connection.

Lastly, make sure the flow is configured properly with the right username and password. This much matches the account on your computer.
