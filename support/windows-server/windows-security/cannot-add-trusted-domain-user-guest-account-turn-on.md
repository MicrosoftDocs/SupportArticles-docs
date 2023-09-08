---
title: error when adding a trusted domain user to a trusting domain
description: Explains that when you try to add a trusted domain user to a trusting domain, you may receive an error message if the guest account on the trusted domain is turned on.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:domain-and-forest-trusts, csstroubleshoot
ms.technology: windows-server-security
---
# Error when you try to add a trusted domain user to a trusting domain in Windows Server 2003 or in Windows 2000: The server is not operational

This article explains that when you try to add a trusted domain user to a trusting domain, you may receive an error message if the guest account on the trusted domain is turned on.

_Applies to:_ &nbsp; Windows 10, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 837328

## Symptoms

When you click **Advanced** in the **Select Users, Computers, or Groups** dialog box in Active Directory Users and Computers and then you try to add a trusted domain user to a trusting domain, you may receive the following error message:
> The server is not operational.

## Cause

This behavior may occur if the guest account on the trusted domain is turned on. The guest account doesn't have the rights to enumerate users.

## Workaround

To work around this behavior, you may use either of the following methods.

### Method 1: Turn off the guest account in the trusted domain

To turn off the guest account, follow these steps:

1. Click **Start**, point to **Programs**, point to **Administrative Tools**, and then click **Active Directory Users and Computers.**  
2. In the console tree, expand the domain where you want to make changes, and then click the **Users** folder.
3. Right-click **Guest** in the details pane, and then click **Disable Account.**

### Method 2: Create the same trusting domain user account in the trusted domain

To create the same trusting domain user account, follow these steps:

1. Click **Start**, point to **Programs**, point to **Administrative Tools**, and then click **Active Directory Users and Computers**.
2. In the console tree, right-click the
 **Users** folder, point to **New**, and then click
 **User**.
3. Type the information about the user who exists in the trusting domain, and then click **Next**.
4. Type the existing user account password, and then click
 **Next**.
    > [!NOTE]
    > You may also type a different password for this user account. If you create a different password for this user account, the trusted domain may prompt you for the user credentials when you connect to the trusted domain by using this account.
5. Click **Finish**.

## Status

This behavior is by design.

## References

For more information about how to manage trusts in Microsoft Windows Server 2003, see the "How to Manage Trusts" and "Understanding Trusts" topics in the Active Directory section of the Windows Server 2003 product documentation. To view the documentation, visit the following Microsoft Web site:

[Using WUA From a Remote Computer](/windows/win32/wua_sdk/using-wua-from-a-remote-computer)
