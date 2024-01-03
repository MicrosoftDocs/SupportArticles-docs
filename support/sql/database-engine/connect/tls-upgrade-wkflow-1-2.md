---
title: TLS 1.2 upgrade workflow
description: This article discusses the steps to upgrade to the TLS 1.2 protocol for SQL Server.
ms.date: 01/02/2024
ms.custom: sap:Connection issues
author: Malcolm-Stewart 
ms.author: mastewa
ms.reviewer: jopilov, haiyingyu, prmadhes, v-jayaramanp
---

# Basic guide to upgrading SQL Server and clients to TLS 1.2

Transport Layer Security (TLS) 1.2 is a cryptographic protocol for secure communication. It's a more secure protocol than the version that Microsoft SQL Server has used historically, TLS 1.0. This article discusses the ideal upgrade workflow and important items to keep in mind when you upgrade TLS.

For more information about which SQL Server-based servers, drivers, and other components should be upgraded, see [TLS 1.2 support for Microsoft SQL Server](tls-1-2-support-microsoft-sql-server.md).

For more information about a SharePoint-specific TLS 1.2 upgrade, see [Enable TLS and SSL support in SharePoint 2013](/SharePoint/security-for-sharepoint-server/enable-tls-and-ssl-support-in-sharepoint-2013?redirectedfrom=MSDN).

## Implementing TLS 1.2

To implement TLS 1.2, follow these steps:

1. Install the latest updates on all SQL Server-based servers in the environment.

1. Make sure that TLS 1.2 is enabled by default on all servers. If you aren't sure about the TLS status, run **[SQLCHECK](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SQLCHECK)**.

1. Install the latest updates on all client computers and applications that connect to the SQL Server-based servers. For client driver updates, see [Client component downloads](tls-1-2-support-microsoft-sql-server.md#client-component-downloads).

1. [Disable TLS 1.0](/answers/questions/1093730/how-to-disable-in-os-and-iis-from-tls-and-ssl-1-0) on the client computers.

1. Disable TLS 1.0 on the servers. When you do this, you might also be able to see client computers that are disabled.

### Challenges of implementing TLS 1.2

You might encounter some challenges when you implement TLS 1.2:

- It's relatively easy to determine which servers have to be updated. The real challenge is to determine which clients require updates and which updates they need. A single client computer might have installed applications that use several different drivers, such as Object Linking and Embedding, Database (OLE DB), Open Database Connectivity (ODBC), and .NET. Developing the client list might require a careful and thorough inventory.

- Some drivers can't be updated to TLS 1.2. The most common examples of such drivers are the SQL Server 2000 legacy drivers that are shipped together with Windows, such as `Provider=SQLOLEDB or Driver={SQL Server}`. In these cases, you must rewrite or reconfigure the connecting application to use SQL Server 2008 or a later version driver or provider.

  > [!NOTE]
  > Unlike the drivers that are shipped together with Windows, the SQL Server 2005 SNAC drivers `(Provider=SQLNCLI and Driver={SQL Server Native Client})` are no longer supported.

- You can't disable TLS 1.0 for a specific client or target server if the application can't be rewritten for some reason. For example, this might occur if the source code is lost or if it's a third-party application and the vendor is now out of business.

- If you turn off TLS 1.0 on the server, this action might reveal some non-compliant clients in the environment. DBAs have to work with the various application development teams to determine which drivers the applications use, upgrade, and test.

- If you turn off TLS 1.0 on a client that otherwise can't connect to a server that's running TLS 1.2 and has TLS 1.0 disabled, the client application might be able to connect. However, this action typically isn't acceptable according to the requirements of most enterprises. Therefore, you should avoid doing it. Otherwise, instead of trying to negotiate a Secure Sockets Layer (SSL) hash for the conversation, the client connects by using an unencrypted Login7 packet. This method could reveal user credentials to any listener on the connection. You can easily observe this scenario in a network trace if the client is installed on a different computer.

- You can use the IISCrypto tool to determine which TLS and SSL client and server protocols are enabled and how to modify them. This tool also lets you enable or disable various cipher suites. However, doing this incorrectly can break existing applications in the environment. We recommend that you don't modify anything without having the guidance of Microsoft Support. For more information about how to verify and configure changes, see [Restrict the use of certain cryptographic algorithms and protocols in Schannel.dll](../../../windows-server/windows-security/restrict-cryptographic-algorithms-protocols-schannel.md) and [IIS Crypto](https://www.nartac.com/Products/IISCrypto/).
  
  > [!WARNING]
  > IISCrypto is a non-Microsoft tool. Use it carefully because any modifications to the TLS settings can make the system or service unusable. 

  > [!NOTE]
  > Use *Regedit.exe* to export the registry branch and back up the original settings.

[!INCLUDE [third-party-disclaimer](../../../includes/third-party-disclaimer.md)]
