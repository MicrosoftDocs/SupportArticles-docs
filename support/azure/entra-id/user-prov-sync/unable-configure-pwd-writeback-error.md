---
title: Error (Unable to configure password writeback) when you run the Microsoft Entra Connect wizard
description: Describes an issue that triggers an error when you run the Microsoft Entra Connect wizard to set up password writeback. Provides a solution.
ms.date: 05/22/2020
ms.reviewer: vimals, willfid
ms.service: entra-id
ms.subservice: users
---
# Error when you run the Microsoft Entra Connect wizard: Unable to configure password writeback

This article describes an issue in which an error message appears when you run the Microsoft Entra Connect wizard to set up password writeback.

_Original product version:_ &nbsp; Microsoft Entra ID  
_Original KB number:_ &nbsp; 3185990

## Symptoms

When you run the Microsoft Entra Connect wizard, you receive the following error message during configuration of password writeback:

> Unable to configure password writeback. Ensure you have the required license.

## Cause

This issue occurs if one of the following conditions are true:

- The administrator account that's used to set up Microsoft Entra Connect does not have the appropriate license.
- The time on the server on which Microsoft Entra Connect is installed is out of sync.
- The TLS setting is configured correctly.

## Resolution

To reoslve this problem, follow these steps:

1. [Enable TLS 1.2](/azure/active-directory/hybrid/reference-connect-tls-enforcement).
2. Make sure that the administrator account that you use to enable password writeback is a cloud administrator account (created in Microsoft Entra ID) and not a federated account (created in the on-premises Active Directory and synchronized to Microsoft Entra ID). Also, make sure that the account has the appropriate Microsoft Entra subscription license.
3. Make sure that the time isn't skewed. On the authoritative time server, perform the steps in the **Configuring the Windows Time service to use an external time source** section of [How to configure an authoritative time server in Windows Server](https://support.microsoft.com/help/816042)

Make sure that the time on the server on which Microsoft Entra Connect is installed matches the time on the authoritative time server.

## More information

If the issue you're experiencing is a scenario in which there's a large time difference between your local environment and Microsoft cloud services,

you may see the following entries in the Microsoft Entra Connect Sync logs. The logs are located in the `%appdata%\Local\AADConnect` folder.

```console
Error <Date> <Time> ADSync 6306 Server "The server encountered an unexpected error while performing an operation for the client.

Error <Date> <Time> ADSync 6800 MA Extension "The password management extension encountered an error.
 The stack trace is:
 ""Couldn't connect to any service bus endpoint(s)

Error <Date> <Time> PasswordResetService 32001 None TrackingId: 3f369fe9-c121-4450-8661-82b095bdbf0a,
Couldn't connect to any service bus endpoint(s), Details:

Error <Date> <Time> PasswordResetService 31044 None TrackingId: 3f369fe9-c121-4450-8661-82b095bdbf0a,
Password writeback service is not in a healthy state. No serviceHost for service bus endpoints are in
running state. Please refer aka.ms/ssprtroubleshoot, Details: Version: 5.0.0.686
```

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
