---
title: Desktop flow invalid credentials error when using a Microsoft Entra account
description: Learn how to resolve InvalidConnectionCredentials, WindowsIdentityIncorrect, and AADSTS50126 errors in Power Automate desktop flows caused by Microsoft Entra account issues.
ms.reviewer: guco，aartigoyle, v-shaywood
ms.date: 08/20/2024
ms.custom: sap:Desktop flows\Cannot create desktop flow connection
---
# Desktop flow invalid credentials error when you use a Microsoft Entra account

This article provides resolutions for the `InvalidConnectionCredentials` or `WindowsIdentityIncorrect` errors that might occur when you run a desktop flow using a [Microsoft Entra account](/entra/fundamentals/whatis#terminology). These errors typically indicate issues with device join status, account synchronization, or credential mismatches between the desktop flow connection and the target machine. 

This article also covers the `AADSTS50126` error, which occurs when credential validation fails because of an invalid username or password, particularly in scenarios involving federated users.

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

You might also receive the following error message:

> AADSTS50126: Error validating credentials due to invalid username or password

## Cause

You might encounter the error when using a Microsoft Entra account for several reasons:

- You enter account credentials into the connection that don't match the credentials on the machine.
- The device isn't [Microsoft Entra joined](/entra/identity/devices/concept-directory-join) or [Microsoft Entra hybrid joined](/entra/identity/devices/concept-hybrid-join) to support [Microsoft Entra authentication](/entra/identity/authentication/overview-authentication).
- The Microsoft Entra account isn't synchronized to the machine.
- The user account attempting to connect is a [federated user (ADFS)](/windows-server/identity/ad-fs/ad-fs-overview) while the tenant is configured to run on Microsoft Entra ID.

## Solution

1. Ensure that the device is Microsoft Entra joined or domain-joined:

    1. Open a command prompt.
    2. Run the `dsregcmd /status` command.
    3. Check the `Device State` section.

       :::image type="content" source="media/troubleshoot-ui-flow-invalid-credentials-error-using-aad-account/command-output.png" alt-text="Screenshot of the device state in the command prompt when running dsregcmd /status.":::

       Make sure that one of the `DomainJoined` or `AzureAdJoined` values is `YES`.

       If this condition isn't true, you can't use a Microsoft Entra account unless the device is joined. For more information, see [How to join a device](/azure/active-directory/user-help/user-help-join-device-on-network#to-join-an-already-configured-windows-10-device).

1. Identify the Microsoft Entra account to use in the machine configuration:

    1. Open **Settings** and select **Accounts**.

    1. Select **Access work or school**.

    1. Make sure you see text like "Connected to <your_organization> Microsoft Entra ID." The account it's connected to can be used in the connection.

1. Synchronize the Microsoft Entra account on the device:

    1. Select the **Info** button when selecting your Microsoft Entra connection on the **Access work or school** page.

    1. This action opens a page that describes your connection information and device synchronization status. Select the **Sync** button at the end of the page, and wait for this process to complete.

1. Verify that the configured Microsoft Entra account can sign in to the device:

    1. Try to sign in to the machine by using the Microsoft Entra account you identified in step 2.
    1. The device authentication must be successful to use the account in a connection.

1. Make sure the flow is configured properly with the right username and password. This information must match the account on your computer.

### AADSTS50126 error

To resolve an AADSTS50126 error, the preferred and most secure method is to configure [Certificate-Based Authentication (CBA)](/power-automate/desktop-flows/configure-certificate-based-auth).

If you can't configure CBA, federated users can use an alternative approach when administrators of the on-premises Identity Provider (IdP) configure [password hash synchronization](/entra/identity/hybrid/connect/whatis-phs) (PHS) to synchronize password hashes to the cloud. In this scenario, federated users can authenticate directly against Microsoft Entra ID (ESTS) by configuring a [Home Realm Discovery](/entra/identity/enterprise-apps/home-realm-discovery-policy) (HRD) policy that explicitly allows cloud password validation.

To enable this configuration, set the following HRD policy value:

`"AllowCloudPasswordValidation": true`

For detailed instructions, see [Enable direct ROPC authentication of federated users for legacy applications](/entra/identity/enterprise-apps/home-realm-discovery-policy#enable-direct-ropc-authentication-of-federated-users-for-legacy-applications).

## More information

- [Create desktop flow connections](/power-automate/desktop-flows/desktop-flow-connections)
- [Invalid credentials error when running desktop flows in Power Automate for desktop](invalid-credentials-errors-running-desktop-flows.md)
- ["Logon type has not been granted" error when running a desktop flow or creating a connection](logon-type-has-not-been-granted.md)
- [What is federation with Microsoft Entra ID?](/entra/identity/hybrid/connect/whatis-fed)
