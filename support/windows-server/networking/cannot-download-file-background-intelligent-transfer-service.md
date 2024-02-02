---
title: Fail to download a file by using BITS
description: Describes a problem that occurs if you're behind a proxy server or behind a firewall that doesn't support HTTP 1.1 range requests.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:background-intelligent-transfer-service-bits, csstroubleshoot
ms.subservice: networking
---
# Error when you download a file by using the Background Intelligent Transfer Service: Content file download failed

This article describes a problem that occurs if you're behind a proxy server or behind a firewall that doesn't support HTTP 1.1 range requests.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 922330

## Symptoms

When you try to download a file by using the Background Intelligent Transfer Service (BITS), you're unsuccessful. Additionally, the following error message is logged in the Application log:

> Event Type:Error  
Event Source:Windows Server Update Services  
Event Category:(2)  
Event ID:364  
Date: **date**  
Time: **time**  
User:N/A  
Computer: **ServerName**  
Description: Content file download failed. Reason: The server does not support the necessary HTTP protocol. Background Intelligent Transfer Service (BITS) requires that the server support the Range protocol header.

Specifically, you experience this problem if you try to perform one or both of the following actions:

- You approve an update in Microsoft Windows Server Update Services (WSUS). In this situation, the download process is triggered. However, the download operation is unsuccessful. A red X appears over the update.
- You try to download the Mssecure.cab file for the Microsoft Baseline Security Analyzer (MBSA) Management Pack for Microsoft Operations Manager (MOM) 2005.

## Cause

You may experience this problem if a computer is behind a firewall or behind a proxy server. This problem occurs if one of the following conditions is true:

- The proxy server environment doesn't support the HTTP 1.1 range request feature.
- You're behind a SonicWALL firewall device, and the **Enable HTTP Byte-Range request with Gateway AV** setting isn't enabled for the device.

When you copy a file by using BITS in background mode, the file is copied in multiple small parts. To perform this kind of copy operation, BITS uses the HTTP 1.1 Content-Range header. If you're behind a proxy server or behind a firewall that removes this header, the file copy operation is unsuccessful.

> [!NOTE]
> When BITS copies files in foreground mode, BITS doesn't use this header.

## Resolution 1: The proxy server doesn't support HTTP 1.1 range requests

Modify the proxy server settings to support HTTP 1.1 range requests. If you can't modify the proxy server in this manner, configure BITS to work in foreground mode. To do this, follow these steps:

1. Click **Start**, click **Run**, type one of the following commands, and then click **OK**.

    If you're using WSUS 2.0 with an MSDE or WMSDE database that was created by a default WSUS installation, type the following command:
  
    ```console
    %programfiles%\Update Services\tools\osql\osql.exe -S %Computername%\WSUS -E -b -n -Q "USE SUSDB update tbConfigurationC set BitsDownloadPriorityForeground=1"
    ```
  
    If you configured WSUS 2.0 to use an existing installation of Microsoft SQL Server, type the following command:
  
    ```console
    %programfiles%\Update Services\tools\osql\osql.exe" -S %Computername% -E -b -n -Q "USE SUSDB update tbConfigurationC set BitsDownloadPriorityForeground=1"
    ```
  
    If you're using WSUS 3.0 with a Windows Internal Database that was created by a default WSUS installation, type the following command:
  
    ```console
    %programfiles%\Update Services\Setup\ExecuteSQL.exe -S %Computername%\MICROSOFT##SSEE -d "SUSDB" -Q "update tbConfigurationC set BitsDownloadPriorityForeground=1"
  
    If you configured WSUS 3.0 to use an existing installation of SQL Server, type the following command:
  
    ```console
    %programfiles%\Update Services\Setup\ExecuteSQL.exe -S %Computername% -d "SUSDB" -Q "update tbConfigurationC set BitsDownloadPriorityForeground=1"
    ```

2. Restart the Update Services service. To do this, follow these steps:
    1. Click **Start**, click **Run**, type *services.msc*, and then click **OK**.
    2. In the **Services** dialog box, right-click **Update Services**, and then click **Restart**.
  
## Resolution 2: The Enable HTTP Byte-Range request with Gateway AV setting isn't enabled

Click to select the **Enable HTTP Byte-Range request with Gateway AV** check box on the **Internal Settings** page of the SonicWALL configuration tool. For more information about how to modify the SonicWALL firewall features, contact SonicWALL support. To do this, visit the following SonicWALL Web site:

[SonicWALL support](https://www.sonicwall.com/support)

Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft does not guarantee the accuracy of this third-party contact information.
