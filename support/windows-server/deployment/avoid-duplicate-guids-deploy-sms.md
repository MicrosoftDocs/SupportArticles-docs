---
title: Avoid duplicate GUIDs when you image SMS clients
description: Describes how to avoid duplicate globally unique identifiers (GUIDs) when you use disk imaging or cloning to deploy the Microsoft Systems Management Server (SMS) 2003 clients.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, clintk
ms.custom: sap:setup, csstroubleshoot
ms.subservice: deployment
---
# How to avoid duplicate GUIDs when you image System Management Server 2003 client computers

This article describes how to avoid duplicate globally unique identifiers (GUIDs) when you use disk imaging or cloning to deploy the Microsoft Systems Management Server (SMS) 2003 clients.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 828367

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure to back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, click the following article number to view the article in the Microsoft Knowledge Base: [256986](https://support.microsoft.com/help/256986) Description of the Microsoft Windows registry  

## More information

In SMS 2003, all clients are uniquely identified by a GUID. A GUID is a combination of the client's media access control (MAC) address and the time when the GUID is assigned. This combination produces a number that is virtually always unique. The GUID assignment occurs during the SMS 2003 client discovery and installation processes.

The GUID is stored in the client's Registry and in a binary file on the client's hard disk. Many problems in an SMS 2003 environment may occur if more than one SMS 2003 client has the same GUID. The whole site may even be disabled. If you use disk duplication software, you must make sure that SMS 2003 client GUIDs are not duplicated during copying or imaging.

To duplicate a disk, you create a master image from a host computer, and then you deploy (or copy) the master image to other computers. Disk duplication makes sure that each computer's operating system and program settings are the same. The SMS 2003 Legacy Client and the SMS 2003 Advanced Client use different methods to avoid the duplication of GUIDs when you duplicate hard disks for the SMS 2003 client deployment.

### Preparing the SMS 2003 Legacy Client computer for imaging

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall your operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.  

To prepare the master-image computer for duplication and to avoid duplicate GUIDs for the SMS 2003 Legacy Client:

1. Use the SMS Push Installation Wizard to install the client software on the master-image client computer:

   1. Click **Start**, point to **Programs**, click **Systems Management Server**, and then click **SMS Administrator Console**.
   2. Expand **Site Database**, expand **Collections**, and then expand **All Systems**.
   3. In the right pane, right-click a discovered SMS 2003 client, click **All Tasks**, and then click **Install Client**.
   4. On the **Welcome to the Client Push Installation Wizard** screen, click **Next**.
   5. On the **Installation Options** screen, click **Install the SMS client**, and then click **Legacy Client**.
   6. On the **Client Options** screen, you can select one or more of the following options:

      - **Include Domain Controllers**  
      - **Include only clients assigned to this site**  
      - **Include subcollections**  
      - **Always install (repair or upgrade existing client)**  
   7. Click **Next**, and then click **Finish**.
2. Restart the client computer, and then log on as Administrator.
3. On the master-image client computer, use Registry Editor to remove the SMS Unique Identifier Registry value:

   1. Click **Start**, click **Run**, type **Regedit** in the **Open** box, and then click **OK**.
   2. Locate the following Registry key: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SMS\Client\Configuration\Client Properties`  

   3. Right-click the **SMS Unique Identifier** Registry value, and then click **Delete**.
4. Delete all copies of the **Smsuid.dat** file from the master-image computer's hard disk.
5. Delete the **%SystemRoot%\Smscfg.ini** file.

6. Use Registry Editor to remove all the keys under the AbExprtDB Registry value:

   1. Click **Start**, click **Run**, type **Regedit** in the **Open** box, and then click **OK**.
   2. Locate the following Registry key: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NAL\Client\AbExprtDB`  

   3. Remove all Registry keys under the **AbExprtDB** Registry value.

### Preparing the SMS 2003 Advanced Client computer for imaging

You can prepare SMS 2003 Advanced Client computers for imaging when you install the core SMS 2003 Advanced Client components on the master-image computer without specifying an SMS 2003 site code for assignment. All computers that are imaged later from that master image will contain the Advanced Client core components without a site code. However, the imaged computers will not be functional SMS 2003 clients until the SMS 2003 clients are assigned to an SMS 2003 site.

To prepare the SMS 2003 Advanced Client computer for imaging:

1. Designate a master computer. The master computer is the computer that will be duplicated to destination client computers.
2. On the master computer, use the **CCMSetup.exe** utility to install the Advanced Client from the **\\\\**SiteServer**\SMSClient\i386** folder.
3. After the Advanced Client is installed, make sure that the SMS Agent Host service (Ccmexec.exe) is not running on the master computer. To do this, type the following command at a command prompt:  

    ```console
    net stop ccmexec  
    ```

4. On the master computer, run the **CCMDelCert.exe** utility to delete any certificates from the Advanced Client.

   > [!Note]
   > The CCMDelCert.exe utility is part of Systems Management Server 2003 Toolkit 2. To obtain this toolkit, visit the following Microsoft Web site: [Microsoft documentation and learning for developers and technology professionals](https://technet.microsoft.com/bb676787.aspx)  

5. Create the image of the master computer by using your imaging software.
6. Restore the image on the destination computers.

## References

For more information on troubleshooting Advanced Client Push Installations, see the following article in the Microsoft Knowledge Base:

[928282 How to troubleshoot Advanced Client Push Installation Issues in Systems Management Server 2003 and System Center Configuration Manager 2007](https://support.microsoft.com/help/925282)

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
