---
title: Desktop flow invalid credentials error when using a Microsoft Entra account
description: Resolves the InvalidConnectionCredentials or WindowsIdentityIncorrect error that occurs when you run a desktop flow using a Microsoft Entra account.
ms.reviewer: guco，aartigoyle
ms.date: 08/20/2024
ms.custom: sap:Desktop flows\Cannot create desktop flow connection
---
# Desktop flow invalid credentials error when you use a Microsoft Entra account

This article provides a resolution for the `InvalidConnectionCredentials` or `WindowsIdentityIncorrect` error code that occurs when you run a desktop flow using a [Microsoft Entra account](/entra/fundamentals/whatis#terminology).

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4555623

## Symptoms

When you run a desktop flow using a Microsoft Entra account, it fails with the `InvalidConnectionCredentials` or `WindowsIdentityIncorrect` error code.

```json
{
    "error":{
        "code": "InvalidConnectionCredentials",
        "message": "Could not connect to the Power Automate UI flows Agent. Please make sure that the UI flows connection credentials are valid."
    }    
}
```

```json
{
    "error":{
        "code": "WindowsIdentityIncorrect",
        "message": "The credentials provided with the request are invalid."
    }    
}
```

## Cause

You might encounter the error when using a Microsoft Entra account for several reasons:

- The account credentials entered into the connection might not match those on the machine.
- The device might not be [Microsoft Entra joined](/entra/identity/devices/concept-directory-join) or [Microsoft Entra hybrid joined](/entra/identity/devices/concept-hybrid-join) to support [Microsoft Entra authentication](/entra/identity/authentication/overview-authentication).
- The Microsoft Entra account might not be synchronized to the machine.

## Resolution

1. Ensure that the device is Microsoft Entra joined or domain-joined:

    1. Open a command prompt.
    2. Run the `dsregcmd /status` command.
    3. Check the `Device State` section.

       :::image type="content" source="media/troubleshoot-ui-flow-invalid-credentials-error-using-aad-account/command-output.png" alt-text="Screenshot of the device state in the command prompt when running dsregcmd /status.":::

       Make sure that one of the `DomainJoined` or `AzureAdJoined` values is `YES`.

       If this isn't the case, a Microsoft Entra account can't be used unless the device is joined. For more information, see [How to join a device](/azure/active-directory/user-help/user-help-join-device-on-network#to-join-an-already-configured-windows-10-device).

2. Identify the Microsoft Entra account to use in the machine configuration:

    1. Open **Settings** and select **Accounts**.

    2. Select **Access work or school**.

    3. Make sure you see text like "Connected to <your_organization> Microsoft Entra ID." The account it's connected to can be used in the connection.

3. Synchronize the Microsoft Entra account on the device:

    1. Select the **Info** button when selecting your Microsoft Entra connection on the **Access work or school** page.

    2. This will open a page that describes your connection information and device synchronization status. Select the **Sync** button at the end of the page, and wait for this process to complete.

4. Verify that the configured Microsoft Entra account can sign in to the device:

    1. Try to sign in to the machine using the Microsoft Entra account identified in step 2.
    2. The device login must be successful in order to be used in a connection.

5. Make sure the flow is configured properly with the right username and password. This must match the account on your computer.

## More information

- [Create desktop flow connections](/power-automate/desktop-flows/desktop-flow-connections)
- [Invalid credentials error when running desktop flows in Power Automate for desktop](invalid-credentials-errors-running-desktop-flows.md)
- ["Logon type has not been granted" error when running a desktop flow or creating a connection](logon-type-has-not-been-granted.md)
