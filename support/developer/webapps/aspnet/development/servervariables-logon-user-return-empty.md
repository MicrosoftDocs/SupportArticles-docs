---
title: Request.ServerVariables() returns empty
description: This article describes an problem that Request.ServerVariables() returns empty string in ASP.NET. Provides a resolution.
ms.date: 04/03/2020
ms.custom: sap:General Development
ms.reviewer: anandh
---
# Request.ServerVariables("LOGON_USER") returns empty string in ASP.NET

This article provides resolutions for the problem where the `Request.ServerVariables("LOGON_USER")` variable returns empty string in ASP.NET.

_Original product version:_ &nbsp; ASP.NET  
_Original KB number:_ &nbsp; 306359

## Symptoms

If you try to access the `Request.ServerVariables("LOGON_USER")` variable in ASP.NET, an empty string is returned.

If you are using Microsoft Visual C# .NET, the following syntax accesses this variable:

```csharp
Request.ServerVariables["LOGON_USER"]
```

## Cause

This problem occurs because the authentication-related variables in the `ServerVariables` collection are not populated if you use Anonymous Access security to access the .aspx page. This problem can also occur if you give the anonymous user access in the `<authorization>` section of the *web.config* file.

## Resolution

To populate the `LOGON_USER` variable when you use any authentication mode other than `None`, you can deny access to the anonymous user in the `<authorization>` section of the *web.config* file. To deny access to the anonymous user in the `<authorization>` section, follow these steps:

1. Change the authentication mode in the *web.config* file to anything other than `None`. For example, the following entry in the *web.config* file sets the authentication mode to Forms-based authentication:

    ```xml
    <authentication mode="Forms" />
    ```

2. To deny access to the anonymous user in the *web.config* file, use the following syntax:

    ```xml
    <authorization>
        <deny users = "?" /> <!-- This denies access to the anonymous user -->
        <allow users ="*" /> <!-- This allows access to all users -->
    </authorization>
    ```

If you are using Windows authentication, you can also use the following steps to resolve this problem:

1. Change the authentication mode in the *web.config* file to `Windows` as follows:

    ```xml
    <authentication mode="Windows" />
    ```

2. In the **Internet Services Manager**, right-click the .aspx file or the **Web Project** folder, and then select **Properties**.
3. If you select **Properties** for the **Web Project** folder, select the **Directory Security** tab. If you select **Properties** for the .aspx file, select the **File Security** tab.
4. Under **Anonymous Access and authentication control**, select **Edit**.
5. In the **Authentication methods** dialog box, clear the **Anonymous Access** check box, and then select the **Basic**, the **Digest**, or the **Integrated (NT Challenge/Response)** check box.
6. Select **OK** to close both dialog boxes.

## Status

This behavior is by design.

## More information

ASP.NET provides new authentication modes and authorization schemes, which you can configure in the .config files. For this reason, modifying the authentication modes in IIS alone may not always yield the desired results. Therefore, you must also consider the security settings in the .config files.

> [!NOTE]
> When you enable Anonymous authentication in conjunction with Windows authentication or if you grant access to the anonymous user in the `<authorization>` section while you are using any authentication mode other than `None`, other server variables such as `AUTH_USER` and `REMOTE_USER` (as well as the `HttpContext.Current.User.Identity.Name` property) also return an empty string. You can use the any of the above-mentioned resolutions to populate these variables.

In ASP.NET, you can also use the `IsAuthenticated` property of the `Request` object to determine whether the Anonymous Access security is being used. `IsAuthenticated` returns **false** if Anonymous Access is turned on and returns **true** if you use any other means of authentication such as `Forms`, `Passport`, `Integrated (NT Challenge/Response)`, or `Basic`.

## References

- [INFO: ASP.NET Security Overview](https://support.microsoft.com/help/306590)
