---
title: Unsupported VM Configuration status
description: Describes an unsupported scenario that virtual hard disks are attached to an IDE bus on a VMware host, and provides a resolution.
ms.date: 04/09/2024
ms.reviewer: wenca
---
# Unsupported VM Configuration status on VMware virtual machines in Virtual Machine Manager

This article helps you fix an issue in which a VMware virtual machine shows a status of **Unsupported VM Configuration** in Microsoft System Center Virtual Machine Manager.

_Original product version:_ &nbsp; Microsoft System Center 2012 R2 Virtual Machine Manager, System Center 2012 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2622238

## Symptoms  

A virtual machine in System Center Virtual Machine Manager shows a status of **Unsupported VM Configuration**. When you view the properties, the **General** tab displays the last refresh error:

> Error (10632): The virtualization software on the selected host does not support virtual hard disks on an IDE bus. Specify a host that is running Windows Hyper-V or Virtual Server or change the bus type, and then by the operation again.

## Cause

System Center 2012 Virtual Machine Manager doesn't support virtual hard disks that are attached to an integrated development environment (IDE) bus on a VMware host. Although VMware virtual machines must boot from a Small Computer System Interface (SCSI) controller, you can attach a secondary virtual disk to an IDE controller in later versions of VMware. (This is a supported configuration.)

## Resolution

To resolve this issue, convert the hard disk from IDE to SCSI by following these steps:

1. Using the VMware tools, locate the datastore path along which the virtual machine stays.

    For example, the path should resemble the following one:

    */vmfs/volumes/<datastore_name>/<vm_name>/*

2. From the ESX Service Console, open the primary disk (.vmdk) in a text editor, and then locate the following line:

   `ddb.adapterType = "ide"`

3. Change the adapter type to the appropriate controller type:

    For LSI Logic, change the line to the following one:

    `ddb.adapterType = "lsilogic"`

    For Bus Logic, change the line to the following one:

    `db.adapterType = "buslogic"`

4. Save the file.
5. From the VMware Infrastructure/vSphere client, select **Edit Settings** for the virtual machine.
6. Select the **IDE virtual disk**.
7. Select the **Remove the Disk** option to remove the disk from the virtual machine, and then select **OK**.

    > [!WARNING]
    > Make sure that you don't select **Delete from disk**.

8. On the **Edit Settings** menu for this virtual machine, select **Add** > **Hard Disk** > **Use Existing Virtual Disk**.
9. Navigate to the location of the disk, and then add it to the virtual machine.
10. Select as the adapter type the same controller as in step 2. The SCSI ID should be **SCSI 0:0**.
11. If there's a CD-ROM device in the virtual machine, you may have to change the IDE channel from **IDE 0:1** to **IDE 0:0**. If this option is unavailable (appears dimmed), remove the CD-ROM from the virtual machine, and then reinsert it. It sets the channel to **IDE 0:0**.

[!INCLUDE [Third-party information disclaimer](../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../includes/third-party-contact-disclaimer.md)]

## More information

When the virtual machine is in this state, it can be managed only by using VMware tools such as the vSphere client.
