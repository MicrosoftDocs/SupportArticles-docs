---
title: HTTP Error 401 Unauthorized when accessing CRM via NLB address
description: The error HTTP Error 401 - Unauthorized occurs when you access Microsoft Dynamics CRM using the Network Load Balancing (NLB) address. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# HTTP Error 401 Unauthorized error when you access Microsoft Dynamics CRM using the NLB address

This article provides a resolution for the issue that you may receive an **HTTP Error 401 - Unauthorized** error when you access Microsoft Dynamics CRM by using the Network Load Balancing (NLB) address.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2642455

## Symptoms

When you access Microsoft Dynamics CRM by using the Network Load Balancing (NLB) address, a prompt for credentials appears and it is not possible to sign in to Microsoft Dynamics CRM using these credentials. You receive the following error message:

> HTTP Error 401 - Unauthorized

The following conditions are true:

- The Microsoft Dynamics CRM Application Pool runs under a domain user account.
- In Internet Information Services (IIS) 7.0 and IIS 7.5, the **Enable Kernel-mode authentication** option is enabled.

## Cause

By default, the IIS 7.0 and IIS 7.5 has the feature Enable Kernel-mode Authentication enabled. This feature decrypts the Kerberos ticket used by a specific application, using the Local Machine Account (Local system) of the IIS server.

When this occurs, the Local Machine Account does not have enough privilege to run Microsoft Dynamics CRM. In addition, when using Service Accounts with NLB, the service accounts on each Microsoft Dynamics CRM server and the NLB Virtual Node must be the same service account. By default, these accounts will not have Service Principal Names configured.

## Resolution

1. Sign in to each Microsoft Dynamics CRM Server.
2. Install the [IIS 7 Admin Pack](https://www.iis.net/downloads/microsoft/administration-pack).
   > [!NOTE]
   > The IIS 7 admin pack is installed by default in Windows Server 2008 R2.
3. On the **Start** menu, point to **Administrative Tools**, and then select **IIS Manager**.
4. Expand the server, expand **Sites**, and then select **Microsoft Dynamics CRM**.
5. Under Management, select **Configuration Editor**.
6. For the Section location, expand system.webServer, expand **Security**, expand **Authentication**, and then select **Windows Authentication**.
7. In the **From** section above **Properties**, select **ApplicationHost.config**.
8. In the properties page, set **useAppPoolCredentials** to **True**, and then select **Apply**.
9. Restart IIS.

Next, you must configure two Service Principal Names (SPN) for each Microsoft Dynamics CRM Server and the virtual node. Each Microsoft Dynamics CRM Server and Virtual Node will consist of an SPN for the NetBIOS name and the Fully Qualified Domain Name (FQDN) for the service account being used.
