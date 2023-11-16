---
title: Physical GPU settings are unavailable post domain join
description: Describes how to solve the issue that Physical GPU settings are unavailable post domain join
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:performance-audio-and-video-and-remotefx, csstroubleshoot
ms.technology: windows-server-rds
---
# Physical GPU settings is unavailable post domain join

This article provides a resolution for the issue that Physical GPU settings are unavailable post domain join.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2878821

## Symptoms

When a Windows Server 2012 Remote Desktop Virtualization Host is added to a domain and the default domain policy is applied, the option to select a physical GPU used for Remote FX (within Hyper-V settings) is unavailable.  

Even if the option to select a physical GPU in the Hyper-V settings is available, you are unable to add the RemoteFX 3D Adapter to the Virtual Machines provisioned on the host server.

## Cause

The issue can occur if the Default Domain policy (or any other policy) has removed the "Users" group from the "Allow log on locally" policy.  

The RemoteFX feature availability in a Remote Desktop Virtualization host is provided by a system account named 'RDV Graphics Service'. This account is part of the local 'Users' group on the Remote Desktop Virtualization Host. If the 'Users' group is denied the permission to logon on to the system, the account in turn is also denied permission to log on to the server.

## Resolution

To resolve this problem, follow these steps:

1. Add the "Users" group back to "Allow log on locally" policy.  

    - Click **Start**, type *gpedit.msc*, and then press ENTER.
    - In the console tree, expand **Computer Configuration**, **Policies**, **Windows Settings**, **Security Settings**, and **Local Policies**, and then click **User Rights Assignment**.
    - In the details pane, double-click **Allow Logon Locally**.
    - Verify the users added here and click **Add User or Group**.
    - Type the name of the account "USERS" that you want to allow to log on locally. As an alternative, click **Browse** to locate the account with the **Select Users, Computers, or Groups** dialog box, and then click **OK**.
    - After you have the account name entered, click **OK** in the **Add User or Group** dialog box, and then click **OK** in the **Allow log on locally Properties** dialog box.  

2. Check the "Deny Logon Locally" policy for any explicit inclusion of the "Users" group  

    - Click **Start**, type *gpedit.msc*, and then press ENTER.
    - In the console tree, expand **Computer Configuration**, **Policies**, **Windows Settings**, **Security Settings**, and **Local Policies**, and then click **User Rights Assignment**.
    - In the details pane, double-click **Deny Logon Locally**.
    - Verify the users added here and make sure USERS group is not added.

> [!Note]
> The same steps apply to a Domain Group policy (or any other Group policy) that needs to be added or modified using Group Policy Management Console.

## More information

This issue is fixed in Windows Server 2012 R2.
