---
title: WSUS 3.0 installation package
description: Describes how to obtain the WSUS 3.0 installation package.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, kimmar
ms.custom: sap:failure-to-install-windows-updates, csstroubleshoot
---
# The Windows Server Update Services 3.0 installation package is available

This article provides some information about Windows Server Update Services 3.0 installation package.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 935524

## Introduction

This article describes the Release-to-Web (RTW) version of Windows Server Update Services (WSUS) 3.0. WSUS 3.0 upgrades the earlier version of this product. You can install the RTW version of WSUS 3.0 on the following operating systems:  

- Microsoft Windows Server 2003 with Service Pack 1 or a later service pack
- Microsoft Windows XP with Service Pack 2
- Windows Vista

## More information

WSUS 3.0 delivers new features that let administrators more easily deploy updates and manage updates across an organization. This update can upgrade computers that are running the following versions of WSUS to WSUS 3.0 RTW:  

- WSUS 2.0
- WSUS 2.0 Service Pack 1 (SP1)
- WSUS 3.0 RC  

Before you install WSUS 3.0, make sure that the computer meets the minimum system requirements.  

### System requirements

#### WSUS 3.0 Server software prerequisites

- Windows Server 2003 with Service Pack 1 or a later service pack
- WSUS 2.0, WSUS 2.0 Service Pack 1, or WSUS 3.0 RC
- Internet Information Services (IIS) 6.0 or a later version
- Microsoft .NET Framework 2.0
- Microsoft Management Console 3.0
- Microsoft Report Viewer
- *Optional:* Microsoft SQL Server 2005 with Service Pack 1

    >[!NOTE]
    >If a compatible version of SQL Server is not installed, WSUS 3.0 installs Windows Internal Database.

#### WSUS 3.0 Administration Console software prerequisites

- Windows Vista, Windows XP with Service Pack 2, or Windows Server 2003 with Service Pack 1 or a later service pack
- WSUS 3.0 RC
- Microsoft .NET Framework 2.0
- Microsoft Management Console 3.0
- Microsoft Report Viewer

### Update information

For more information about how to download Microsoft support files, click the following article number to view the article in the Microsoft Knowledge Base:  
[119591](https://support.microsoft.com/help/119591) How to obtain Microsoft support files from online services  
 Microsoft scanned this file for viruses. Microsoft used the most current virus-detection software that was available on the date that the file was posted. The file is stored on security-enhanced servers that help prevent any unauthorized changes to the file.  

You can find the shortcut to start the WSUS 3.0 Administration Console in the Administrative Tools folder. In Windows XP with SP2 and in Windows Vista, the Administrative Tools folder is in Control Panel.

#### Important configuration issue

If you use a proxy server that requires authentication, you must overwrite the proxy server password in the WSUS Server Configuration Wizard. If you do not do it, the WSUS server may not synchronize updates. Because the configuration wizard starts automatically at the end of the Setup process, this problem can cause synchronization errors after you upgrade to WSUS 3.0. You can avoid this problem by canceling the Configuration Wizard after the upgrade or by reentering the correct proxy password when the wizard runs. To recover from this problem after it has occurred, follow these steps:  

1. In the WSUS 3.0 console tree, click **Options**.
2. In the details pane, click **Update Source and Proxy Server**.
3. In the **Update Source and Proxy Server** dialog box, click the **Proxy Server** tab.
4. Reenter the proxy password. Then, save the setting.  

For more information about Windows Server Update Services, visit the following Microsoft Web site:  
WSUS TechNet Center  
[https://technet.microsoft.com/wsus/default.aspx](https://technet.microsoft.com/wsus/default.aspx)

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
