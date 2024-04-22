---
title: Default workstation number a user can join to the domain
description: Describes the default number of workstations a user can join to the domain and how to the change the AD to allow more or fewer machine accounts in the domain.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Active Directory\On-premises Active Directory domain join, csstroubleshoot
---
# Default limit to number of workstations a user can join to the domain

This article describes how to the change the AD to allow more or fewer machine accounts in the domain.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 243327

## Summary

By default, Windows 2000 allows authenticated users to join 10 machine accounts to the domain.

This default was implemented to prevent misuse. But an administrator can make a change to an object in Active Directory to override it.

The following users aren't restricted by this limitation:

- Users in the Administrators or Domain Administrators groups.
- Users who have delegated permissions on containers in Active Directory to create and delete computer accounts.

## More information

To calculate the number of workstations currently owned by a user, check the ms-DS-CreatorSID attribute of machine accounts.

To modify Active Directory to allow more (or fewer) machine accounts on the domain, use the Adsiedit tool.

> [!WARNING]
> Using Adsiedit incorrectly can cause serious problems that may require you to reinstall your operating system. Microsoft cannot guarantee that problems resulting from the incorrect use of Adsiedit can be solved. Use Adsiedit at your own risk.

1. Install the Windows Support tools if they haven't already been installed. It's necessary only for Windows 2000 and Windows Server 2003. For Windows Server 2008 and Windows Server 2008 R2, Adsiedit is installed automatically when you install the Active Directory Domain Services role.
2. Run Adsiedit.msc as an administrator of the domain. Expand the **Domain NC** node. This node contains an object that begins with "DC=" and reflects the correct domain name. Right-click this object, and then select **Properties**.
3. In the **Select which properties to view** box, select **Both**. In the **Select a property to view** box, select **ms-DS-MachineAccountQuota**.
4. In the **Edit Attribute** box, type the number of workstations that you want users to be able to maintain concurrently.
5. Select **Set** > **OK**.
