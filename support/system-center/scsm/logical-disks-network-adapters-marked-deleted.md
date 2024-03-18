---
title: Logical disks and network adapters incorrectly marked as deleted
description: Fixes an issue in which logical disk and network adapter objects are marked for deletion in Service Manager, even though those items still exist in Operations Manager.
ms.date: 03/14/2024
ms.reviewer: scottwal, veharshv, khusmeno
---
# Logical disks and network adapters marked deleted in Service Manager still exist in Operations Manager

This article helps you fix an issue in which logical disk and network adapter objects are marked for deletion in Service Manager, even though those items still exist in Operations Manager.

_Original product version:_ &nbsp; System Center 2016 Service Manager, System Center 2012 R2 Service Manager  
_Original KB number:_ &nbsp; 4033821

## Symptoms

In some environments, the Service Manager Operations Manager CI connector may incorrectly mark logical disk and network adapter objects as deleted. The items are still present in Operations Manager and can be found in the Service Manager console under the **Administration** > **Deleted Items** folder as **Pending delete**. But you don't receive error messages for the Operations Manager CI connector.

## Cause

This issue can occur when a single Operations Manager CI connector is configured with multiple operating system (OS) management pack versions that sync all objects of the same type.

## Resolution

To fix this issue, remove the items from the **Deleted Items** folder, reconfigure the existing Operations Manager connector to a single operating system version management pack, and then add a connector for each management pack OS version. One new connector will be added for each operating system version (Windows Server 2003, 2008, and 2012).

To do this in the Service Manager console, follow these steps.

1. Remove delete items:
  
   1. Go to **Administration**, and then select **Deleted Items**.
   2. In the **Filter** section, choose **Edit Criteria**, expand **Add Criteria**, choose **Class**, and then select **Add**.
   3. In the **type the value** field, select type **Network Adapter (concrete)**.
   4. Select all items in the list, and then click **Remove Items** on the task pane.
   5. Repeat steps b to d, but in step c, select type **Logical Disk (concrete)**.

2. Reconfigure the Connector:
  
   1. Go to **Administration**  and then select **Connectors**.
   2. Select the Operations Manager Configuration Items connector, and then choose **Properties** on the task pane.
   3. Select **Management Packs** from the **Edit** dialog box, and then click to clear the following management pack check boxes:

      - Microsoft.Windows.Server.Library
      - Microsoft.Windows.Server.2008.Discovery
      - Microsoft.Windows.Server.2003

   4. Click **Ok**.

3. Add new connectors to import these items again from Operations Manager so that the connectors will not be marked for deletion. To do this, follow these steps:
  
   1. Go to **Administration**, click **Connectors**, click **Create Connector**, and then select **Operations Manager CI connector**.
   2. Give the connector a descriptive name. For example, include the operating system in the name, such as **Windows Server 2012 Objects**.
   3. Complete the server and account details for connecting to Operations Manager, and then click **Next**.
   4. From the list of management packs, choose only the management pack that will sync objects for the specific operating system (see [Operations Manager management packs and their classes](#operations-manager-management-packs-and-their-classes)).

4. Choose a schedule and complete the wizard. We recommend that you choose a different schedule for each operating system type so that the connector schedules don't overlap.

## Operations Manager management packs and their classes

|Management pack display name|Management pack name|Class display name|Class name|
|---|---|---|---|
| Windows Server 2003 Operating System| Microsoft.Windows.Server.2003| Windows Server 2003 Logical Disk| Microsoft.Windows.Server.2003.LogicalDisk |
| Windows Server 2003 Operating System| Microsoft.Windows.Server.2003| Windows Server 2003 Network Adapter| Microsoft.Windows.Server.2003.NetworkAdapter |
| Windows Server 2008 Operating System (Discovery)| Microsoft.Windows.Server.2008.Discovery| Windows Server 2008 Logical Disk| Microsoft.Windows.Server.2008.LogicalDisk |
| Windows Server 2008 Operating System (Discovery)| Microsoft.Windows.Server.2008.Discovery| Windows Server 2008 Network Adapter| Microsoft.Windows.Server.2008.NetworkAdapter |
| Windows Server Operating System Library| Microsoft.Windows.Server.Library| Windows Server 2012 Logical Disk| Microsoft.Windows.Server.6.2.LogicalDisk |
| Windows Server Operating System Library| Microsoft.Windows.Server.Library| Windows Server 2012 Network Adapter| Microsoft.Windows.Server.6.2.NetworkAdapter |
  
When you are finished, you should have four Operations Manager CI connectors:

- The original
- One for Windows Server 2003
- One for Windows Server 2008
- One for Windows Server 2012

There are many possible variations. For example, you may not have any Windows Server 2003 objects to synchronize. So, you would not have a separate connector for that operating system.

Also, you may choose to add one of the operating system management packs back to the original connector. This is fine if you separate the other management packs into different connectors.

## More information

The Operations Manager Configuration Items connector maps classes from Operations Manager to classes in Service Manager such as for network adapters. In Operations Manager, there are three separate classes for network adapters:

- Microsoft.Windows.Server.2003.NetworkAdapter
- Microsoft.Windows.Server.2008.NetworkAdapter
- Microsoft.Windows.Server.6.2.NetworkAdapter

In Service Manager, only one class represents all three network adapters:

- Microsoft.Windows.Peripheral.NetworkAdapter

In some environments, the connector can lose the mappings, and you may have to create separate connectors for each class. This can be controlled by selecting the correct management pack in the connector configuration. Using only a single management pack per connector makes sure that the objects maintain the correct mapping during deletion detection and don't get incorrectly marked for deletion.

The Operations Manager CI connector does deletion detection every seven days, checking for items that no longer exist in Operations Manager, and then marks those items for deletion in Service Manager.
