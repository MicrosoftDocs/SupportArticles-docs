---
title: TLS 1.2 upgrade workflow
description: This article describes the upgrade steps and some important points to be done before upgrading the TLS protocol.
ms.date: 01/02/2024
ms.custom: sap:Connection issues
author: Malcolm-Stewart 
ms.author: mastewa
ms.reviewer: jopilov, haiyingyu, prmadhes, v-jayaramanp
---

# Basic guide to upgrading SQL Server and clients to TLS 1.2

Transport Layer Security (TLS) 1.2 is a cryptographic protocol that provides secure communication and is a more secure protocol than TLS 1.0, which SQL Server has used historically. This article describes the workflow that's an ideal order of upgrade steps and discusses some things to keep in mind while performing the upgrade.

For more information about which SQL servers and drivers and other components can and need to be upgraded, see [TLS 1.2 support for Microsoft SQL Server](tls-1-2-support-microsoft-sql-server.md).

For more information about SharePoint-specific TLS 1.2 upgrade, see [Enable TLS and SSL support in SharePoint 2013](/SharePoint/security-for-sharepoint-server/enable-tls-and-ssl-support-in-sharepoint-2013?redirectedfrom=MSDN).

## Implementing TLS 1.2

To implement TLS 1.2, follow these steps:

1. Identify SQL Servers and install the latest patches on them.

1. Make sure TLS 1.2 isn't disabled and it's enabled by default. If you aren't sure if it's enabled, run **[SQLCHECK](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SQLCHECK)**.

1. Identify client machines and applications that connect to SQL Server and apply patches on them. For client driver updates, see [Client component downloads](tls-1-2-support-microsoft-sql-server.md#client-component-downloads).

1. [Disable TLS 1.0](/answers/questions/1093730/how-to-disable-in-os-and-iis-from-tls-and-ssl-1-0) on client machines.

1. Disable TLS 1.0 on the servers. When you do so, you might be able to find client machines that were disabled.

### Challenges of implementing TLS 1.2

There are many challenges about implementing TLS 1.2.

- Identifying the SQL Servers that need to be patched is relatively easy. The real challenge is in identifying the clients that require updates and the updates they need. A single machine might have applications that use several different drivers such as Object Linking and Embedding, Database (OLE DB), Open Database Connectivity (ODBC), and .NET. This might require a careful and thorough inventory.

- Some drivers can't be patched to TLS 1.2. The most common are the SQL Server 2000 legacy drivers that are shipped with Windows, such as `Provider=SQLOLEDB or Driver={SQL Server}`. In such cases, it will be necessary to rewrite or reconfigure the connecting application to use SQL 2008 or later driver or provider.

  > [!NOTE]
  > The SQL 2005 SNAC drivers `(Provider=SQLNCLI and Driver={SQL Server Native Client})` aren't supported anymore, unlike the drivers that are shipped with Windows.

- You can't disable TLS 1.0 for a specific client or target server if the application can't be rewritten for reasons such as source code is lost or it's a third party application and the vendor went out of business or can't rewrite it.

- Turning off TLS 1.0 on the SQL Server might likely reveal some non compliant clients in the environment. DBAs have to work with the various application development teams to determine which drivers the applications use, upgrade, and test.

- Turning off TLS 1.0 on a client machine that otherwise fails to connect to a SQL machine running TLS 1.2 and has TLS 1.0 disabled might allow the application to connect. However, this isn't typically acceptable for the requirements of most enterprises and so should be avoided. Instead of trying to negotiate a Secure Sockets Layer (SSL) hash for the conversation, the client connects using an unencrypted Login7 packet, revealing user credentials to any listener on the connection. You can observe this scenario readily in a network trace if the client is installed on a different machine.

- You can use the IISCrypto tool to see what TLS and SSL client and server protocols are enabled and how to modify them. The tool also allows you to enable or disable various cipher suites. This can break existing applications in the environment if done incorrectly. We recommend you not to modify anything without the guidance of Microsoft Support. For more information about how to validate changes and configure changes, see [Restrict the use of certain cryptographic algorithms and protocols in Schannel.dll](../../../windows-server/windows-security/restrict-cryptographic-algorithms-protocols-schannel.md) and [IIS Crypto](https://www.nartac.com/Products/IISCrypto/).
  
  > [!WARNING]
  > Use IISCrypto with care as modifying the TLS settings can make the system or service unusable.

  > [!NOTE]
  > Export the registry branch using *Regedit.exe* so that you can back up the original settings.

  > [!NOTE]
  > IISCrypto is a non-Microsoft tool.

[!INCLUDE [third-party-disclaimer](../../../includes/third-party-disclaimer.md)]
