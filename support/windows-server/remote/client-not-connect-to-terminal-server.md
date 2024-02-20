---
title: Clients can't connect to Terminal Server
description: Provides a solution to an issue where Terminal Services clients are repeatedly denied access to the terminal server after upgrade Windows.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, mikeres
ms.custom: sap:authentication, csstroubleshoot
---
# Because of a security error, the client could not connect to the Terminal server

This article provides a solution to an issue where Terminal Services clients are repeatedly denied access to the terminal server after upgrade Windows.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 329896

## Symptoms

After you upgrade a Microsoft Windows NT domain to Windows 2000 or Windows Server 2003, Windows 2000 Terminal Services clients may be repeatedly denied access to the terminal server. If you are using a Terminal Services client to log on to the terminal server, you may receive one of the following error messages:

> Because of a security error, the client could not connect to the Terminal server. After making sure that you are logged on to the network, try connecting to the server again.

or

> Remote desktop disconnected. Because of a security error, the client could not connect to the remote computer. Verify that you are logged onto the network and then try connecting again.

Additionally, the following event ID messages may be logged in Event Viewer on the terminal server:

> Event ID: 50  
Event Source: TermDD  
Event Description: The RDP protocol component X.224 detected an error in the protocol stream and has disconnected the client.

and

> Event ID: 1008  
Event Source: TermService  
Event Description: The terminal services licensing grace period has expired and the service has not registered with a license server. A terminal services license server is required for continuous operation. A terminal server can operate without a license server for 90 days after initial start up.

and

> Event ID: 1004  
Event Source: TermService  
Event Description: The terminal server cannot issue a client license.

and

> Event ID: 1010  
Event Source: TermService  
Event Description: The terminal services could not locate a license server. Confirm that all license servers on the network are registered in WINS\DNS, accepting network requests, and the Terminal Services Licensing Service is running.

and

> Event ID: 28  
Event Source: TermServLicensing  
Event Description: Terminal Services Licensing can only be run on Domain Controllers or Server in a Workgroup. For more information, see Terminal Server Licensing help topic.

## Cause

This issue may occur if a certificate on the terminal server is corrupted.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base: [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

To resolve this issue, back up and then remove the X509 Certificate registry keys, restart the computer, and then reactivate the Terminal Services Licensing server. To do this, follow these steps.

> [!NOTE]
> Perform the following procedure on each of the terminal servers.

1. Make sure that the terminal server registry has been successfully backed up.
2. Start Registry Editor.
3. Locate and then click the following registry subkey:  
 `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\TermService\Parameters`
4. On the **Registry** menu, click **Export Registry File**.
5. Type exported-parameters in the
 **File name** box, and then click **Save**.

    > [!NOTE]
    > If you have to restore this registry subkey in the future, double-click the Exported-parameters.reg file that you saved in this step.
6. Under the **Parameters** registry subkey, right-click each of the following values, click **Delete**, and then click **Yes** to confirm the deletion:

    - Certificate
    - X509 Certificate
    - X509 Certificate ID

7. Quit Registry Editor, and then restart the server.
8. Reactivate the Terminal Services Licensing server by using the Telephone connection method in the Licensing Wizard.

    > [!NOTE]
    > If you activate the Terminal Services Licensing server using the **Telephone** option, the licensing server uses a different form of certificate.
