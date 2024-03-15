---
title: Remote Desktop cannot verify the identity of the remote computer
description: Helps troubleshoot the Remote Desktop cannot verify the identity of the remote computer error when connecting to a domain-joined remote machine.
ms.date: 03/15/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-lianna
ms.custom: sap:connecting-to-a-session-or-desktop, csstroubleshoot
---
# "Remote Desktop cannot verify the identity of the remote computer" when connecting to a remote machine

This article helps troubleshoot the "Remote Desktop cannot verify the identity of the remote computer" error when connecting to a domain-joined remote machine.

When you use a direct Remote Desktop Protocol (RDP) connection to connect to a Windows machine, the connection fails after entering the credentials, and the following error occurs:

> Remote Desktop cannot verify the identity of the remote computer because there is a time or date difference between your computer and the remote computer. Make sure your computer's clock is set to the correct time, and then try connecting again. If the problem occurs again, contact your network administrator or the owner of the remote computer.

> [!NOTE]
> For troubleshooting, it's important to understand if the error is persistent or intermittent. To confirm this, restart the affected Windows machine and check if the issue is still reproduced.

## RDP error is persistent

If the error is persistent, it usually occurs when there's a time difference between the client or remote computer and the target domain controller.

> [!NOTE]
> In case you have a time inaccuracy, you can connect via RDP using a local account.

To narrow the possible causes, follow these steps:

1. Determine if the time inaccuracy is in the client machine, server machine, or the domain controller (DC).

    1. Open a command prompt and run the following command:

        ```console
        net time \\<FQDN of the machine>
        ```

    2. If necessary, force time synchronization by using the following commands in the affected machine:

        ```console
        net stop w32time #To stop the Windows Time service
        net start w32time #To start the Windows Time service
        w32tm /resync #To force the time synchronization
        ```

2. If the preceding steps can't fix the issue, check for Domain Name System (DNS) server problems. For more information, see [Troubleshooting DNS servers](/windows-server/networking/dns/troubleshoot/troubleshoot-dns-server).

## RDP error is intermittent

If the error is intermittent and usually occurs after the Windows machine runs for several days, and a restart temporarily fixes the issue, the cause may be that the Transmission Control Protocol (TCP) port is exhausted.

Other RDP errors may be related to TCP port exhaustion, such as:

- > We can't sign you in with this credential because your domain isn't available. Make sure your device is connected to your organization's network and try again. If you previously signed in on this device with another credential, you can sign in with that credential.
- > There are currently no logon servers available to service the logon request.

> [!NOTE]
> Usually, only domain accounts are affected, so you may be able to connect via RDP using a local account.

To check if port exhaustion exists on the affected machine, open system logs in the Event Viewer and check if any of the following events are logged.

|Event ID  |Source  |Description  |
|---------|---------|---------|
|1129     |Group Policy         |The processing of Group Policy failed because of lack of network connectivity to a domain controller. This may be a transient condition. A success message would be generated once the machine gets connected to the domain controller and Group Policy has successfully processed. If you do not see a success message for several hours, then contact your administrator.         |
|4227     |Tcpip         |TCP/IP failed to establish an outgoing connection because the selected local endpoint was recently used to connect to the same remote endpoint. This error typically occurs when outgoing connections are opened and closed at a high rate, causing all available local ports to be used and forcing TCP/IP to reuse a local port for an outgoing connection. To minimize the risk of data corruption, the TCP/IP standard requires a minimum time period to elapse between successive connections from a given local endpoint to a given remote endpoint.         |
|4231     |Tcpip         |A request to allocate an ephemeral port number from the global TCP port space has failed due to all such ports being in use.         |
|5719     |NETLOGON         |This computer was not able to set up a secure session with a domain controller in domain CONTOSO due to the following:<br>We can't sign you in with this credential because your domain isn't available. Make sure your device is connected to your organization's network and try again. If you previously signed in on this device with another credential, you can sign in with that credential.<br>This may lead to authentication problems. Make sure that this computer is connected to the network. If the problem persists, please contact your domain administrator.<br><br>ADDITIONAL INFO<br>If this computer is a domain controller for the specified domain, it sets up the secure session to the primary domain controller emulator in the specified domain. Otherwise, this computer sets up the secure session to any domain controller in the specified domain.         |

If any of the events are reported in the system logs, there may be a process or service causing the TCP port to exhaust.

To troubleshoot a TCP port exhaustion issue, see [Troubleshoot port exhaustion issues](/troubleshoot/windows-client/networking/tcp-ip-port-exhaustion-troubleshooting) to understand how to identify the misbehaving process.

Finally, when the issue occurs, stop the misbehaving process, and then sign in via RDP using domain credentials and see if it succeeds.

## Contact Microsoft Support

If the misbehaving process is from Microsoft, or the preceding steps can't resolve the issue, contact Microsoft Support for further assistance.
