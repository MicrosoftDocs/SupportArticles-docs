---
title: How to block users from running Hyper-V and VMware virtual machines on workstation-class computers
description: Describes how to block users from installing Hyper-V or other virtualization software on specified computers.
ms.date: 08/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:virtualization and hyper-v\installation and configuration of hyper-v
- pcy:WinComm Storage High Avail
---

# How to block users from running Hyper-V and VMware virtual machines on workstation-class computers

This article provides guidance on how to use Windows PowerShell or Group Policy to block users from running virtualization software, such as Hyper-V and VMware, on workstation-class computers. These procedures apply to scenarios in which the you want to prevent such software from running, regardless of a user's administrative rights, on both domain-joined and non-domain-joined computers.

*Applies to:* Hyper-V Server 2019

## How to block virtualization services

> [!IMPORTANT]  
>
> - Before you make these changes in a production environment, test them in a lab environment. This step helps assure that the changes (especially Group Policy changes) produce the intended results and don't introduce operational issues.
> - Make sure that you have Administrator permissions on the workstation computers.

### How to block the Hyper-V feature on a single computer

1. On the computer, open an administrative Windows PowerShell window.
1. Run the following cmdlets in sequence:

   ```powershell
   Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V-All
   bcdedit /set hypervisorlaunchtype off
   ```

   The first cmdlet removes Hyper-V from the set of available optional features, and the second cmdlet prevents Hyper-V from running.

### How to use Group Policy to block Hyper-V services on multiple computers

To configure an appropriate policy, follow these steps:  

1. In the Group Policy Management Console (GPMC), navigate to or create a policy object that applies to the affected computers.
1. Right-click the policy, and then select **Edit**. In the Group Policy Editor, select **Computer Configuration** > **Windows Settings** > **Security Settings** > **System Services**.
1. Configure each service that's related to Hyper-V (for example, Hyper-V Virtual Machine Management). For each of these services, follow these steps:
   1. Right-click the service, and then select **Properties**.
   1. In the service **Properties** dialog box, select **Define this policy setting**, select **Disabled**, and then select **OK**.
1. To propagate the policy change, restart all of the target computers.

For more information about how to use Group Policy, see [Advanced Group Policy Management](/microsoft-desktop-optimization-pack/agpm/).

## How to use Group Policy to block VMware Workstation services

To configure an appropriate policy, follow these steps:  

1. In the Group Policy Management Console (GPMC), navigate to or create a policy object that applies to the affected computers.
1. Right-click the policy, and then select **Edit**. In the Group Policy Editor, select **Computer Configuration** > **Policies** > **Windows Settings** > **Security Settings** > **System Services**.
To block users from running VMware Workstation, follow these steps:

1. **Create a new path rule in Software Restriction Policies**:

   1. Open the Group Policy Management Console (GPMC), and go to **Computer Configuration** > **Policies** > **Policies** > **Windows Settings** > **Software Restriction Policies**.

   1. If there aren't any software restriction policies, right-click **Software Restriction Policies**, and then select **New Software Restriction Policies**.
   1. Right-click **Additional Rules**, and then select **New path rule**.
   1. In the **Path** box, pecify the path to the VMware executable files (for example, type *C:\\Program Files (x86)\\VMware\\*, or type the path to specific .exe files).
   1. Select **Security level**, and then select **Disallowed**.
   1. Select **OK**.
1. To propagate the policy change, restart all of the target computers.

For more information about how to use Group Policy, see [Advanced Group Policy Management](/microsoft-desktop-optimization-pack/agpm/).
