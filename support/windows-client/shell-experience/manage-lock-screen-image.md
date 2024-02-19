---
title: Manage lock screen image
description: Describes how an administrator can manage the lock screen image.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, warrenw, justintu
ms.custom: sap:lock-screen-or-screensaver, csstroubleshoot
---
# How to Manage the Lock Screen Image on Windows 8 and Windows Server 2012

This article describes how an administrator can manage the lock screen image.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2787100

## Symptoms

Scenario:

You have deployed Windows 8 and or Windows Server 2012 servers.

You want to use a customized lock screen image on these systems.

You want a centrally managed method of deploying the customized lock screen image.

## Resolution

The update ["Windows 8 and Windows Server 2012 cumulative update: November 2012"](https://support.microsoft.com/help/2770917) adds functionality to the Control Panel group policies that allow an administrator to designate a lock screen image on their Windows 8 and Windows 2012 computers. This setting lets you specify the default lock screen image shown when no user is signed in, and also sets the specified images as the default for all users (it replaces the inbox default image) Some restriction apply. See the Restrictions section below.

The new group policy is named "Force a specific default lock screen image" and can be found in this path in the group policy editor: "Computer Configuration\Policies\Administrative Templates\Control Panel\Personalization"

Requirements:

To deploy the new "Force a specific default lock screen image" GP the following requirements must be met:

1. The update "Windows 8 and Windows Server 2012 cumulative update: November 2012" must be applied to all Windows 8 and Windows Server 2012 computers that you want to deploy customer lock screen images to. This is required as the Control Panel group policy client-side extension must be updated to enforce the group policy.

2. The group policy used to deploy the custom lock screen image must be edited on a machine that has been patched with "Windows 8 and Windows Server 2012 cumulative update: November 2012".  

Restrictions  

- Windows 8 Enterprise or Windows Server 2012 can use the new GP "Force a specific default lock screen image" via Domain GP or via local GP.
- Windows 8 Pro can also be a target of the GP if the machine is joined to a domain.

Implementation Steps for Domain Based Group Policy  

1. Patch all system with update "Windows 8 and Windows Server 2012 cumulative update: November 2012" KB 2770917.

2. Create a GPO and link it to the OU where the computer accounts are located that you want to deploy the custom lock screen image to. Alternatively you can use an existing GPO.

    1. Open the Group Policy Management Console (GPMC).

    2. Create and link a GPO to an OU or Locate an existing GPO that you want to use.

3. Create and link a GPO to an OU or Locate an existing GPO that you want to use.

    1. In GPMC right-click the GPO from step 2b and select edit.

    2. Go this path "Computer Configuration\Policies\Administrative Templates\Control Panel\Personalization".

    3. Enable the GP "Force a specific default lock screen image".

    4. Specify the path to the image file. It's recommended to use a DFS network path to provide redundancy.

4. After Sysvol replication has occurred and clients have refreshed their group policy settings the new lock screen will be used.  

Implementation Steps for Local Group Policy  

1. Patch the system with update "Windows 8 and Windows Server 2012 cumulative update: November 2012" KB 2770917.

2. Edit Local Policy.

    1. Run GPEDIT.MSC.  

    2. Go this path "Computer Configuration\Policies\Administrative Templates\Control Panel\Personalization".

    3. Enable the GP "Force a specific default lock screen image".

    4. Specify the path to the image file.  

    5. Click OK.  

3. Policy will be enforced as the next GP background refresh.
