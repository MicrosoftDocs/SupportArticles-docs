---
title: Fail to install security or post-2871997 update
description: This article provides a resolution for the problem when you install security update or any post-2871997 update in Microsoft BizTalk Server 2013, Microsoft BizTalk Server 2010, or Microsoft BizTalk Server 2009.
ms.date: 09/27/2020
ms.custom: sap:Accelerators
ms.reviewer: mquian, mandia
---
# Error when you try to install the BizTalk Server Accelerator for HL7

This article helps you resolve the problem when you install security update or any post-2871997 update in Microsoft BizTalk Server 2013, Microsoft BizTalk Server 2010, or Microsoft BizTalk Server 2009.

_Original product version:_ &nbsp; BizTalk Server  
_Original KB number:_ &nbsp; 2988484

## Symptoms

After you install security update [Microsoft Security Advisory: Update to improve credentials protection and management: May 13, 2014](https://support.microsoft.com/help/2871997) or any post-2871997 update in Microsoft BizTalk Server 2013, Microsoft BizTalk Server 2010, or Microsoft BizTalk Server 2009, you cannot install the BizTalk Server Accelerator for HL7. The HL7 installation wizard fails and returns the following error message:

> CS_CONTEXT_ERROR = The specified account "domain\username" is invalid. Error code: The handle is invalid.

## Cause

This problem occurs because the HL7 installation *.msi* file uses an unmanaged function that is no longer applicable.

## Resolution

> [!IMPORTANT]
> In most situations, we do not recommend that you uninstall security updates. In this situation, we are providing this information because your only option to resolve or work around this problem is to uninstall the security updates. After you successfully install the Accelerator for HL7, we strongly recommend that you reinstall all security updates to protect your computer from vulnerabilities and malicious software.

## BizTalk Server 2013

An MSI fix is available to help you install the Accelerator for HL7 on a computer on which security update 2871997 and post-2871997 updates are already installed.

> [!NOTE]
> During the installation, you may have to point the installer to the accelerator setup files within the BizTalk folder.

## Workaround

To work around this problem in BizTalk Server 2013, follow these steps:

1. Uninstall security update 2871997 and all post-2871997 security updates.
1. Restart the server.
1. Install and configure the Accelerator for HL7.
1. Reinstall the security updates that you uninstalled.

## BizTalk Server 2010 and BizTalk Server 2009  

For BizTalk Server 2010 and BizTalk Server 2009, there is no updated HL7 installation *.msi* file. Because the list of security updates continues to grow, we recommended that you follow these steps:

1. Start with a clean operating system. To do this, uninstall all security updates, and make sure that the computer meets the BizTalk Server software requirements.
1. Install and configure BizTalk Server.
1. Install and configure the Accelerator for HL7.
1. Reinstall all "important" security updates and any "optional" updates that you want for the operating system, BizTalk Server, and the HL7 accelerator. After you install the BizTalk Server Accelerator for HL7, any new security updates that you install will not affect the HL7 run-time.

If you are trying to install the Accelerator for HL7 on a computer that has security updates already installed, we recommend that you follow these steps:

1. Uninstall the security updates. You can create a wusa.exe/uninstall script to uninstall the updates.

   > [!NOTE]
   > You must update the script to include your specific installed updates.

1. Restart the server.
1. Install and configure the Accelerator for HL7.
1. Reinstall all "important" security updates and any "optional" updates that you want for the operating system, BizTalk Server, and the HL7 accelerator.

## More information

The problem that is discussed in this article does not affect the HL7 runtime. This problem occurs only when you install the Accelerator for HL7.

Mainstream support has ended for Biz Talk Server 2009.

## Applies to

- BizTalk Server 2013 Branch
- BizTalk Server 2013 Developer
- BizTalk Server 2013 Enterprise
- BizTalk Server 2013 Standard
- BizTalk Server Branch 2010
- BizTalk Server Developer 2010
- BizTalk Server Enterprise 2010
- BizTalk Server Standard 2010
- BizTalk Server 2009 Branch
- BizTalk Server 2009 Developer
- BizTalk Server 2009 Enterprise
- BizTalk Server 2009 Standard
