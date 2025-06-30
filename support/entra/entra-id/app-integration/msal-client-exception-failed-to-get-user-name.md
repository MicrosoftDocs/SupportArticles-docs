---
title: MsalClientException - Failed to Get User Name
description: Resolves the Failed to get user name error when an application uses Integrated Windows Authentication (IWA) with Microsoft Authentication Library (MSAL).
ms.service: entra-id
ms.date: 06/30/2025
ms.reviewer: willfid, v-weizhu
ms.custom: sap:Developing or Registering apps with Microsoft identity platform
---

# Microsoft.Identity.Client.MsalClientException: Failed to get user name

This article provides a solution to the "Failed to get user name" error that occurs when an application uses Integrated Windows Authentication (IWA) together with Microsoft Authentication Library (MSAL).

## Symptoms

When your application uses IWA with together MSAL, if calling the `AcquireTokenByIntegratedWindowsAuth` method as follows:

```csharp
result = await app.AcquireTokenByIntegratedWindowsAuth(scopes)
```

You encounter one of the following errors:  

- > Microsoft.Identity.Client.MsalClientException: Failed to get user name —>  
  > System.ComponentModel.Win32Exception: No mapping between account names and security IDs was done 

- > Microsoft.Identity.Client.MsalClientException: Failed to get user name —>  
  > System.ComponentModel.Win32Exception: Access Denied

## Cause

The error originates from Windows. It occurs because MSAL calls the [GetUserNameEx](/windows/win32/api/secext/nf-secext-getusernameexa) function from `secur32.dll`. For more information, see [MSAL WindowsNativeMethods.cs - GetUserNameEx](https://github.com/AzureAD/microsoft-authentication-library-for-dotnet/blob/01ecd12464007fc1988b6a127aa0b1b980bca1ed/src/client/Microsoft.Identity.Client/Platforms/Features/DesktopOS/WindowsNativeMethods.cs#L66).

## Solution

> [!NOTE]
> Before you begin, ensure the following minimum requirements are met:
>
> - Run the application as a local Active Directory user, not a local computer user account.
> - The device running the application is joined to the domain.

To resolve this issue, pass the username to `AcquireTokenByIntegratedWindowsAuth`.

If the username is known beforehand, you can manually pass it to MSAL as follows:

`result = await app.AcquireTokenByIntegratedWindowsAuth(scopes).WithUsername("<service-account>@contoso.com")`

If the username isn't known beforehand, dynamically retrieve the username and then pass it to `AcquireTokenByIntegratedWindowsAuth` by using one of the following methods:

- Use `System.Security.Principal.WindowsIdentity.GetCurrent()`

    Here's the code example:

    ```csharp
    string username = System.Security.Principal.WindowsIdentity.GetCurrent().Name;
    result = await app.AcquireTokenByIntegratedWindowsAuth(scopes).WithUsername(username)
    ```

    > [!NOTE]
    > If the returned username doesn't include a domain, this method fails and returns different errors. For proper integration with Microsoft Entra ID, you must pass the username in the format of a user principal name.

- Use `PublicClientApplication.OperatingSystemAccount.Username`

    Here's the code example:

    ```csharp
    string username = PublicClientApplication.OperatingSystemAccount.Username;
    result = await app.AcquireTokenByIntegratedWindowsAuth(scopes).WithUsername(username)
    ```

    > [!NOTE]
    > This method tries to access the Windows Account Broker to sign the user into the device. It doesn't work if the application runs on Internet Information Services (IIS) or Windows Server.

## Reference

[Using MSAL.NET with Integrated Windows Authentication (IWA)](/entra/msal/dotnet/acquiring-tokens/desktop-mobile/integrated-windows-authentication)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
