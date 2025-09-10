---
title: Description of the Connection Status dialog box
description: Describes the Connection Status dialog box in the June 26, 2012, hotfix packages for Outlook 2007 and Outlook 2010.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Exchange Mailbox Accounts\Other
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: aruiz, tasitae, philclod
appliesto: 
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Microsoft Office Outlook 2007
search.appverid: MET150
ms.date: 01/30/2024
---
# Description of the Connection Status dialog in Outlook

_Original KB number:_ &nbsp; 2737188

## Summary

In the June 26, 2012 hotfix packages for Microsoft Office Outlook 2007 and Microsoft Outlook 2010, the Connection Status dialog box was updated to provide additional details. Additionally, Outlook 2013 and Outlook 2016 include other columns. These are especially helpful when you connect to Microsoft Exchange Online accounts in a Microsoft 365 environment.

## More information

To view the Outlook connection status properties, follow these steps:

1. Press and hold Ctrl, and then select the **Microsoft Outlook** icon in the notification area.

    > [!NOTE]
    > By default in Windows 7, the Outlook icon is hidden from view in the notification area.

2. Select **Connection Status**.

### Column descriptions

#### For Outlook 2007 and Outlook 2010

The June 26, 2012, hotfix packages for Outlook 2007 and Outlook 2010 introduced several changes to the Exchange Server Connection Status dialog box. These include several new columns and the ability to resize the Connection Status dialog box. See the example in the following screenshot.

:::image type="content" source="media/description-of-the-connection-status-dialog-box/exchange-connection-status.png" alt-text="Screenshot of Microsoft Exchange Connection Status.":::

- CID

  Indicates the connection ID. This information is used together with Outlook troubleshooting log data to help Microsoft Support professionals diagnose connectivity problems.

- SMTP Address

  Because Outlook supports multiple Exchange accounts, this column indicates the account that is associated with a given connection.

- Proxy Server

  Indicates the proxy server through which Outlook connects. If you are connected to a server that is running Microsoft Exchange Server and that uses RPC over TCP (RPC/TCP), the proxy name does not appear. Only the RPC server appears under the **Server name** column (**Server name** column omitted from screenshot).

- Authn

  Indicates the authentication type that a given Outlook connection uses. Possible values include:

  ERROR  
  CLEAR (Outlook uses **clear** to indicate basic authentication - typically used together with SSL)  
  NTLM  
  NEGO  
  KERBEROS  
  ANONYMOUS  
  BEARER

    Outlook can display multiple values in the **Authn** column if a connection is using multiple protocols. When this occurs, the values are separated by a space. The example screenshot shows the following value:

  Clear [Anonymous]

  The image shows that the **connection protocol** column is RPC/HTTP. The **Authn** column shows that the RPC portion of this connection object is using anonymous authentication and that the HTTP portion is using Basic (Clear).

  > [!NOTE]
  > The **Authn** column alone does not fully define the security of an Outlook connection. The security of a connection must be verified by cross-referencing the **Conn** (connection) and **Encrypt** (encryption) columns.

- Encrypt

  This column indicates the type of encryption used by a connection. Possible values include:

  ERROR  
  NONE  
  SSL  
  NO  
  YES

  Like the **Authn** column, the **Encrypt** column may contain information about multiple protocols. In that case, information about each protocol is separated by space. The example screenshot shows the following value:

  SSL[No]

  In the example screenshot, the **connection protocol** column value shows RPC/HTTP. The **Encrypt** column indicates that the HTTP portion of this connection object is encrypted by using SSL, and that the RPC portion has no encryption.

- RPCPort

  These values let you quickly determine the port on which Outlook is connecting and whether connection consolidation is working correctly.

- Type

  Indicates the Exchange endpoint for the connection. Values include mail, directory, GC (legacy), and public (public folder store).

- Avg Resp

  Shows the average round trip request or response time for client requests. This value includes server and connection latency. When you consider average response times, larger sample sizes give a truer indication of latency. For example, a large sample size could be 100 request/response pairs.

- Avg Proc

  Shows the average server processing time for client-side requests that are reported to Outlook by Exchange.

- Sess type

  Specifies whether Outlook is connected to the Exchange mailbox in Cached Exchange Mode or online mode. This information is useful when you troubleshoot latency issues. Possible values include Forground, Background, Spooler, and Cache.

- Interface

  Shows the local network card that is used by a given Outlook connection.

- Conn

  Describes the connection protocol binding that is used by a given connection. Values include HTTP, RPC, and TCP.

- Version

  Lists the Exchange Server version for a given connection.

#### For Outlook 2013 and Outlook 2016

Outlook 2013 and Outlook 2016 support Modern Authentication. Modern Authentication uses Azure Active Directory Authentication Library (ADAL). By default, Outlook 2016 is enabled for Modern Authentication. Modern Authentication can be enabled for Outlook 2013. For more information about Modern Authentication, see [Updated Microsoft 365 modern authentication](https://www.microsoft.com/microsoft-365/blog/2015/11/19/updated-office-365-modern-authentication-public-preview/).

- CID

  Indicates the connection ID. This information is used in together with Outlook troubleshooting log data to help Microsoft support professionals diagnose connectivity problems.

- SMTP Address

  Because Outlook supports multiple Exchange accounts, this column indicates the account that is associated with a given connection.

- Display name

  Contains the name of the message store as displayed in the **Outlook Navigation Pane** and **Folder List**.

- Proxy Server

  Indicates the proxy server through which Outlook connects. If you are connected to a server that is running Exchange Server and that uses RPC over TCP (RPC/TCP), the proxy name does not appear. Only the RPC server appears under the **Server name** column (**Server name** column omitted from screenshot).

- Server name

  Specifies the actual URL that is used to connect to the resource.

- Status

  Use this column to determine the current status of the connection to the Exchange Server resource.

- Protocol

  Specifies the protocol that is used for the connection.

- Authn

  Indicates the authentication type that a given Outlook connection uses. Possible values include:

  ERROR  
  CLEAR - (Outlook uses **clear** to indicate basic authentication - typically used together with SSL)  
  NTLM  
  NEGO  
  KERBEROS  
  ANONYMOUS  
  AUTOLOGON

  Outlook can display multiple values in the **Authn** column if a connection is using multiple protocols. When this occurs, the values are separated by a space. The sample screenshot shows the following value:

  Clear [Anonymous]

  In the example screenshot, the **connection protocol** column is RPC/HTTP. The **Authn** column shows that the RPC portion of this connection object is using anonymous authentication and that the HTTP portion is using Basic (Clear).

  > [!NOTE]
  > The **Authn** column alone does not fully define the security of an Outlook connection. The security of a connection must be verified by cross-referencing the **Conn**(connection) and **Encrypt** (encryption) columns.

- Encrypt

  Indicates the type of encryption that is used by a connection. Possible values include:

  ERROR  
  NONE  
  SSL  
  NO  
  YES

  Like the **Authn** column, the **Encrypt** column may contain information about multiple protocols. In that case, information about each protocol is separated by space. The example screenshot shows the following value:

  SSL[No]

  In the example screenshot, the **connection protocol** column value shows RPC/HTTP. The **Encrypt** column indicates that the HTTP portion of this connection object is encrypted by using SSL, and that the RPC portion has no encryption.

- RPCPort

  These values let you quickly determine the port on which Outlook is connecting and whether connection consolidation is working correctly.

- Type

  These values indicate the Exchange endpoint for the connection. Values include mail, directory, GC (legacy), and public (public folder store).

- Req/Fail

  Lists the number of requests that are made during the session and the number of those requests that failed for the specific connection.

- Avg Resp

  Shows the average round trip request or response time for client requests. This value includes server and connection latency. When you consider average response times, larger sample sizes give a truer indication of latency. For example, a large sample size could be 100 request/response pairs.

- Avg Proc

  Shows the average server processing time for client-side requests reported to Outlook by Exchange.

- Sess type

  Specifies whether Outlook is connected to the Exchange mailbox in Cached Exchange Mode or online mode. This information is useful when you troubleshoot latency issues. Possible values include Forground, Background, Spooler, and Cache.

- Interface

  Shows the local network card that is used by a given Outlook connection.

- Conn

  Describes the connection protocol binding that is used by a given connection. Values include HTTP, RPC, and TCP.

- Notif

  Indicates the notification process type. Possible values include:

  - Async
  - UDP
  - Poll

- RPC

  Indicates the value of the RPC connection.

- Version

  Lists the Exchange Server version for a given connection.

- Network Cost

  Provides access to property values that indicate the current cost of a network connection.
