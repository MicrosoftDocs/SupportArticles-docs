---
title: Move Terminal Services CALs from one license server to another
description: Describes how to move Terminal Services CALs from one license server to another in Windows. You must have the original license documents to perform this operation.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:remote-desktop-services-terminal-services-licensing, csstroubleshoot
---
# How to move Terminal Services CALs from one license server to another in Windows

This article describes how to move Terminal Services Client Access Licenses (CALs) from one Terminal Services license server to another in Windows.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 953918

## Introduction

To move Terminal Services CALs from one Terminal Services license server to another, follow the procedures in the following sections.

### The documents that you must have available

Before you start to perform the procedures that are described in the following sections, you must have the paper agreement that you received when you purchased the CALs. The agreement number or the enrollment number from the agreement will be required to receive the new CAL Pack ID that is described in the "How to move the CALs" section.

### How to move the CALs

To move the CALs, follow these steps.

> [!NOTE]
> After you move the CALs, you must deactivate the old license server. (See step 10.)

1. Install Terminal Services Licensing on the target server.
2. Activate the license server.
3. On the new Terminal Services license server, click **Start**, click **Administrative Tools**, and then click **Terminal Server Licensing**.
4. In the Terminal Server Licensing snap-in, right-click the Terminal Services license server, and then click **Properties**. In the **Installation method** list, click **Telephone**, and then click **OK**.
5. Right-click the Terminal Services license server, and then click **Install Licenses**. The **Welcome to the Terminal Server CAL Installation Wizard** dialog box appears.
6. Click **Next**. In the **Obtain Client License Key Pack** dialog box, you'll find the license server ID.
7. Use this license server ID to obtain a CAL Key Pack ID. To install CALs on the new license server, you must have a CAL Key Pack ID. You can receive a CAL Key Pack ID from the Microsoft Clearinghouse or by visiting the following Microsoft Web site: [Remote Desktop Services](https://activate.microsoft.com).

    To contact the Microsoft Clearinghouse, use the following telephone number: 1-888-571-2048.

    The representative at the Microsoft Clearinghouse will give you a new CAL Key Pack ID. You can also contact Microsoft Customer Support Services at the following telephone number: 1-800-936-3100.

    For more information, click the following article number to view the article in the Microsoft Knowledge Base:

    [319726](https://support.microsoft.com/help/319726) Phone numbers for Microsoft Technical Support  

8. In the **Obtain Client License Key Pack** dialog box, type the CAL Key Pack ID (from step 7) in the **Type the client license key pack ID in the boxes below** field.
9. Click **Next**. You'll receive a message that states that the CALs have been installed successfully.
10. After you verify that the new license server is functioning correctly, deactivate the old license server. To do this, uninstall the Terminal Services Licensing component on the old server.

### Backup and license information

You should regularly back up the Terminal Services license server by using Windows Backup or a similar tool. Regular backups help protect your licensing data from accidental loss if the system experiences hardware or storage failure. When you back up a Terminal Services license server, back up both the system state data and the folder in which the Terminal Services license server is installed. By doing this, you make sure that data in both the registry and the Terminal Services license server database is backed up.

If you restore the system state data and the database to the original Terminal Services license server, any unissued licenses are restored correctly, assuming you haven't replaced the operating system on the computer. If you've replaced the operating system, any unissued licenses aren't restored, and an event that provides the unissued license count is logged in the System log. You can still restore the unissued licenses by using the telephone activation option in the Terminal Services License Manager tool. To switch to the telephone activation option, right-click the server in Terminal Services License Manager, and then click **Properties**.

## References

For more information about Terminal Services, visit the following Microsoft Web site: [Terminal Services](/previous-versions/windows/it-pro/windows-2000-server/bb742597(v=technet.10))
