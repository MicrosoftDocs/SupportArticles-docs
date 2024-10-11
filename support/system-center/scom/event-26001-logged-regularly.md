---
title: Event 26001 is logged regularly
description: Fixes an issue in which event 26001 is logged every 30 minutes on Windows Server 2012 R2 host computers.
ms.date: 04/15/2024
ms.reviewer: dewitth
---
# Event 26001 is logged regularly on Windows Server 2012 R2 host computers

This article provides a workaround for the issue that event 26001 is logged every 30 minutes on Windows Server 2012 R2 host computers.

_Original product version:_ &nbsp; System Center 2012 R2 Operations Manager, System Center 2012 R2 Virtual Machine Manager, Windows Server 2012 R2 Datacenter, Windows Server 2012 R2 Essentials, Windows Server 2012 R2 Foundation, Windows Server 2012 R2 Preview, Windows Server 2012 R2 Standard  
_Original KB number:_ &nbsp; 2924512

## Symptoms

Every 30 minutes, an entry that resembles the following is logged in the Application log on a computer that's running Windows Server 2012 R2:

> Event ID: 26001  
> Task Category: None  
> Level: Error  
> Keywords: Classic  
> User: N/A  
> Description:  
> Got null results from Select Connection from Msvm_SyntheticEthernetPortSettingData where InstanceId='Microsoft:4DB9D08C-D75B-483A-BC3E-5AA19B5FC50B\\\335614F9-B1BA-45EE-A2DD-2168B7F86CDC'

## Cause

This problem occurs because of a known issue that affects the System Center 2012 R2 Virtual Machine Manager Management Pack. This issue involves the rules that collect the virtual port sent and received data that appears in the virtual network dashboard. These rules use WMI v1 classes. However, these classes are not available in Windows Server 2012 R2. Therefore, the rules fail on Windows Server 2012 R2 host computers.

## Workaround

To work around this issue, disable the rules that are responsible for the query. To do this, follow these steps:

1. Open the System Center Operations Manager console.
2. Select **Authoring**, select **Management Pack Objects**, and then select **Rules**.
3. Select **Find**, and then locate the following rules.

    > [!NOTE]
    > If the console is scoped, select **Scope** at the top of the screen to remove the scoping on the view and display all rules.
    >
    > - Virtual port sent Bytes per second
    > - Virtual port received Bytes per second

4. Right-click each rule, select **Overrides**, select **Disable the Rule**, and then select **For all objects of class: Virtual Port**.
5. At the bottom of the dialog box, select a management pack in which to store the override.

    > [!NOTE]
    > We recommend that you don't save the override to the default management pack. Instead, you can save the override to **Microsoft System Center Virtual Machine Manager Overrides**, or create a new management pack.

6. Click **OK**.

## References

For more information about the `Msvm_SyntheticEthernetPortSettingData` class that represents the configured state of a synthetic Ethernet adapter, see [Msvm_SyntheticEthernetPortSettingData class](/windows/win32/hyperv_v2/msvm-syntheticethernetportsettingdata).
