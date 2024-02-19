---
title: Remote Assistance connection doesn't work
description: Provides workarounds for an issue where Remote Assistance connection to a Windows Server-based server that has FIPS encryption doesn't work.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:remote-assistance, csstroubleshoot
---
# Remote Assistance connection to Windows Server with FIPS encryption does not work

This article provides workarounds for an issue where Remote Assistance connection to a Windows Server-based server that has FIPS encryption doesn't work.

_Applies to:_ &nbsp; Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 811770

## Symptoms

Microsoft has added the **FIPS Compliant** setting to the options for Terminal Services encryption levels in Windows Server. A Windows Server-based server that has the encryption level set to **FIPS Compliant** cannot allow Remote Assistance connections from a computer that is running Windows 10.

When you try to connect from a Windows 10-based client to a Terminal Services server, the connection may not succeed, and you may receive the following error message:  
> Because of a security error, the client could not connect to the terminal server. After making sure that you are logged on to the network, try connecting to the server again.

## Cause

This issue occurs because a Windows 10-based computer cannot provide a Remote Assistance connection to a Windows Server-based computer that is configured to require FIPS-compatible encryption.

## Resolution

To resolve this problem, install Remote Desktop Connection 6.0. For more information about Remote Desktop Connection, click the following article number to view the article in the Microsoft Knowledge Base:

[925876](https://support.microsoft.com/help/925876) Remote Desktop Connection (Terminal Services Client 6.0)  

## Workaround

Remote Desktop Connection (Terminal Services Client 6.0) can be installed on client computers that are running Windows 10.

To work around this problem in Windows 10, disable the FIPS encryption level. To disable the FIPS encryption level, you can change the **Encryption level** setting in the **RDP-Tcp Properties** dialog box, or you can use the Group Policy Object to disable FIPS data encryption system-wide. To disable the FIPS encryption level, use one of the following methods.

> [!NOTE]
> There are two ways to enable the FIPS encryption level. If you have to disable the FIPS encryption level for Terminal Services, you must do this by using the same method that you originally used to enable the FIPS encryption level.

### Method 1

To disable the FIPS encryption level by changing the **Encryption level** setting in the **RDP-Tcp Properties** dialog box, follow these steps:

1. Click **Start**, click **Run**, type tscc.msc in the **Open** box, and then click **OK**.
2. Click **Connections**, and then double-click **RDP-Tcp** in the right pane.
3. In the **Encryption level** box, click to select a level of encryption other than **FIPS Compliant**.

    > [!NOTE]
    > If the **Encryption level** setting is disabled when you try to change it, the system-wide setting for **System cryptography: Use FIPS compliant algorithms for encryption, hashing, and signing** has been enabled, and you must disable this system-wide setting by using method 2.

### Method 2

To use the Group Policy Object to disable FIPS data encryption system-wide, follow these steps:

1. Click **Start**, click **Run**, type gpedit.msc in the **Open** box, and then click **OK**.
2. Expand **Computer Configuration**, expand **Windows Settings**, expand **Security Settings**, expand **Local Policies**, and then click **Security Options**.
3. In the right pane, double-click **System cryptography: Use FIPS compliant algorithms for encryption, hashing, and signing**, click **Disable**, and then click **OK**.

    > [!NOTE]
    > Encryption level settings in Terminal Server are unavailable when FIPS is enabled.  

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.  

## More information

The **FIPS Compliant** setting requires that all data between the client and the server is encrypted by using encryption methods that are validated by Federal Information Processing Standard 140-1. When a Windows 10-based client tries to connect to a Windows Server-based computer that requires FIPS-compliant encryption, the following errors occur:

- On the client, you receive the following error message from Remote Assistance:

    > A Remote Assistance connection could not be established. You may want to check for network issues or determine if the invitation expired or was cancelled by the person who sent it.

- The following error is logged in the System log on the server:

    > Event ID: 50  
    Source: TermDD  
    Type: Error  
    Description: The RDP protocol component "DATA ENCRYPTION" detected an error in the protocol stream and has disconnected the client.
