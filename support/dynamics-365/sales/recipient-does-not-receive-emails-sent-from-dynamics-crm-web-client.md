---
title: Recipient does not receive emails sent via CRM web client
description: Describes a problem that occurs because the SMTP configuration on the Microsoft Dynamics CRM server is not configured to forward email messages to the Exchange server.
ms.reviewer: frachkid
ms.topic: troubleshooting
ms.date: 
---
# The recipient does not receive emails that a Microsoft Dynamics CRM user sends by using the Microsoft Dynamics CRM web client

This article provides a resolution for the issue that the recipient can't receive email messages that are sent from the Microsoft Dynamics CRM web client.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 915827

## Symptoms

When a Microsoft Dynamics CRM user sends an email message by using the Microsoft Dynamics CRM 2011 web client, the email message is sent or queues up. However, if an issue occurs when the user sends the email message, the user receives one of the following error messages in the email activity.

Error message 1

> This message has not yet been submitted for delivery. 1 attempts have been made so far.

Error message 2

> The message delivery failed. It must be resubmitted for any further processing.

Additionally, you receive an error message that resembles the following in the MSCRMEmailLog event log:

> Event Type:Error  
Event Source:MSCRMEmailLog  
Event Category:None  
Event ID:0  
Date: *Date*  
Time: *Time*  
User:N/A  
Computer: *ComputerName*  
Description: #61042 - An error occurred while processing the outgoing e-mail message with subject "test 3 today CRM:0001011" for SMTP: `https://adsrv:81/MS1` for delivery through adsrv. System.Net.Mail.SmtpException: Failure sending mail. ---> System.Net.WebException: Unable to connect to the remote server --->  
System.Net.Sockets.SocketException: No connection could be made because the target machine actively refused it  
at System.Net.Sockets.Socket.DoConnect(EndPoint endPointSnapshot, SocketAddress socketAddress)  
at System.Net.Sockets.Socket.InternalConnect(EndPoint remoteEP)  
at System.Net.ServicePoint.ConnectSocketInternal(Boolean connectFailure, Socket s4, Socket s6, Socket& socket, IPAddress& address, ConnectSocketState state, IAsyncResult asyncResult, Int32 timeout, Exception& exception)  
--- End of inner exception stack trace ---  
at System.Net.ServicePoint.GetConnection(PooledStream PooledStream, Object owner, Boolean async, IPAddress& address, Socket& abortSocket, Socket& abortSocket6, Int32 timeout)  
at System.Net.PooledStream.Activate(Object owningObject, Boolean async, Int32 timeout, GeneralAsyncDelegate asyncCallback)  
at System.Net.PooledStream.Activate(Object owningObject, GeneralAsyncDelegate asyncCallback)  
at System.Net.ConnectionPool.GetConnection(Object owningObject, GeneralAsyncDelegate asyncCallback, Int32 creationTimeout)  
at System.Net.Mail.SmtpConnection.GetConnection(String host, Int32 port)  
at System.Net.Mail.SmtpTransport.GetConnection(String host, Int32 port)  
at System.Net.Mail.SmtpClient.GetConnection()  
at System.Net.Mail.SmtpClient.Send(MailMessage message)  
--- End of inner exception stack trace ---  
at System.Net.Mail.SmtpClient.Send(MailMessage message)  
at Microsoft.Crm.Tools.Email.Providers.SmtpPollingSendEmailProvider.SendMessage(MailMessage mailMessage)  
at Microsoft.Crm.Tools.Email.Providers.SmtpPollingSendEmailProvider.ProcessMessageInternal(email emailMessage)  
at Microsoft.Crm.Tools.Email.Providers.CrmPollingSendEmailProvider.ProcessMessage(email emailMessage)  
at Microsoft.Crm.Tools.Email.Providers.CrmPollingSendEmailProvider.Run()  
>
> For more information, see Help and Support Center at `https://go.microsoft.com/fwlink/events.asp`.

## Cause

Microsoft Dynamics CRM relies on the local SMTP server to forward email messages to the Exchange server. This problem occurs for one of the following reasons:

- The SMTP configuration on the Microsoft Dynamics CRM server is not configured to forward email messages to the Exchange server.
- The Exchange server is not configured to allow relay messages from the Microsoft Dynamics CRM server.

## Resolution

To resolve this problem, follow these steps:

### Step 1 - Configure SMTP on the Microsoft Dynamics CRM server to forward email messages to the Exchange server

1. On the Microsoft Dynamics CRM server, open Internet Information Services (IIS). To do this, select **Start**, select **Administrative Tools**, and then select **Internet Information Services (IIS) Manager**.
2. In Internet Information Services (IIS) Manager, expand **Default SMTP Virtual Server**, right-click **Domains**, point to **New**, and then select **Domain**.
3. In the New SMTP Wizard, select **Remote** under **Specify the domain Type**, and then select **Next**.
4. Type your domain name in the **Name** box, and then select **Finish**.
5. In the right pane, right-click the domain name that you added in steps 2 through 4, and then select **Properties**.
6. On the **General** tab, select the **Allow incoming mail to be relayed to this domain** check box, and then select **Forward all mail to smart host**. In the box under **Forward all mail to smart host**, type the Exchange server name, and then select **OK**.
7. Restart the SMTP service on the Microsoft Dynamics CRM server. To do this, select **Start**, select **Administrative Tools**, and then select **Services**. Right-click **Simple Mail Transfer Protocol (SMTP)**, and then select **Restart**.

### Step 2 - Configure the Exchange server to allow relay messages from the Microsoft Dynamics CRM server

#### Exchange Server 2003

If you are using Microsoft Exchange Server 2003, you must first configure the Relay Restrictions and then verify the Connections Control.

##### Configure the Relay Restrictions

1. Select **Start**, point to **Programs**, point to **Microsoft Exchange**, and then select **System Manager**.
2. Select **Servers**, select the name of the Exchange server, select **Protocols**, and then select **SMTP**.
3. Right-click **Default SMTP Virtual Server**, select **Properties**, and then select the **Access** tab.
4. In the **Relay Restrictions** area, select **Relay**.
5. Verify that the **Only the list below** option is selected, and then add the Microsoft Dynamics CRM server to the list.

   If you are using Microsoft Dynamics CRM 2011, make sure you add the server that has the Exchange router installed to the list.

6. Restart the SMTP service. To do this, follow these steps:
   1. Select **Start**, point to **Programs**, point to **Administrative Tools**, and then select **Services**.
   2. Right-click **Simple Mail Transfer Protocol (SMTP)**, and then select **Restart**.

##### Verify the Connections Control

1. Select **Start**, point to **Programs**, point to **Microsoft Exchange**, and then select **System Manager**.
2. Select **Servers**, select the name of the Exchange server, select **Protocols**, and then select **SMTP**.
3. Right-click **Default SMTP Virtual Server**, select **Properties**, and then select the **Access** tab.
4. In the **Connections Control** area, select **Connection**.
5. By default, the **All except the list below** option is selected. If the Microsoft Dynamics CRM server is added to this list, you must contact the Exchange administrator to determine the reason that the Microsoft Dynamics CRM server was added.

    > [!NOTE]
    > For Microsoft Dynamics CRM email messages to work correctly, the Microsoft Dynamics CRM server must be able to connect to the Exchange server.

6. If the **Only the list below** option is selected, you must add the Microsoft Dynamics CRM server to the list to allow it to connect to the Exchange server.
7. If you made any changes to the Connection Control settings, restart the SMTP service. To do this, follow these steps:
   1. Select **Start**, point to **Programs**, point to **Administrative Tools**, and then select **Services**.
   2. Right-click **Simple Mail Transfer Protocol (SMTP)**, and then select **Restart**.

#### Exchange Server 2007

If you are using Microsoft Exchange Server 2007, you must create a new Exchange receive connector, configure the connector for the anonymous user, configure protocol permissions for the receive connector, and then restart the Microsoft Exchange Transport Service on the Exchange server.

##### Create an Exchange receive connector

1. Open the Exchange Management Console.
2. Expand **Server Configuration**.
3. Select **Hub Transport**.
4. Right-click **Receive Connectors**, and then select **New Receive Connector**.
5. Type a name in the **Name** box.
6. In the **Select the intended use for this Receive connector** list, select **Internal**, and then select **Next**.
7. In the **Remote Network Settings** section, select **Add**, and then type the IP address of the Microsoft Dynamics CRM server.

    > [!NOTE]
    > If you see the value 0.0.0.0-255.255.255.255, select **Delete**.

8. Select **Next**, select **New**, and then select **Finish**.

##### Configure the connector for the anonymous user

1. Right-click the Exchange receive connector that you created, and then select **Properties**.
2. Select the **Permission Groups** tab.
3. Make sure that the **Specify who is allowed to connect to the Receive connector** option is set to **Anonymous users**, select **Apply**, and then select **OK**.

##### Configure protocol permissions for the receive connector

> [!NOTE]
> You must have Windows Support Tools installed to complete these steps. Only an experienced administrator should use the Adsiedit.msc tool.

1. Start the Adsiedit.msc tool.
2. Expand **Configuration**, expand **Services**, expand **Microsoft Exchange**, expand **CN= First Organization**, expand **Administrative Groups**, expand **Exchange Administrative Group**, expand **Servers**, expand **Protocols**, and then expand **SMTP Receive Connectors**.
3. Right-click the Exchange receive connector that you created, and then select **Properties**.
4. Select the **Security** tab.
5. Select **Anonymous Logon**.
6. Select the **Submit Messages to any Recipient** check box and the **Accept Authoritative Domain Sender** check box, select **Apply**, and then select **OK**.

##### Restart the Microsoft Exchange Transport Service on the Exchange server

1. Select **Start**, select **Run**, type *services.msc*, and then select **OK**.
2. Right-click **Microsoft Exchange Transport Service**, and then select **Restart**.
