---
title: Can't access AD data from Source Control Explorer
description: Provides a solution to solve an error that occurs when you access Active Directory information from Team Foundation Server Source Control Explorer.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:user-computer-group-and-object-management, csstroubleshoot
---
# "Object reference not set to an instance of an object" while accessing Active Directory information from TFS Source Control Explorer

This article provides help to solve an error that occurs when you access Active Directory information from Team Foundation Server Source Control Explorer.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 957969

## Rapid publishing

Rapid publishing articles provide information directly from within the Microsoft support organization. The information contained herein is created in response to emerging or unique topics, or is intended supplement other knowledge base information.  

## Action

Create a Windows group in Active Directory (AD), and assign AD users to the group, then...

1. Open Visual Studio as a TFS Administrator
2. Open **Source Control Explorer**
3. Right-click on a version control folder and select Properties
4. Click the Security tab on the Properties dialog
5. Select the **Windows User or Group** option and click the Add button
6. Browse for the AD group; and attempt to add the group

## Result

Error: Object reference not set to an instance of an object.

## Cause

This issue is caused by a bug in the version control permission dialog window in Visual Studio 2008\ Team Explorer 2008.

## Resolution

This problem is resolved in Visual Studio 2008 SP1. If you are using Visual Studio 2008 RTM, there are two workarounds:

1. Assign version control permissions with command-line tool: tf.exe

    You can enter `tf perm /?` or review the MSDN documentation for this command [TF Permission command](https://msdn.microsoft.com/library/0dsd05ft.aspx)  for more information about how to assign version control permissions from command line.

2. Explicitly make the AD group in question a valid TFS identity:

     1. Create a new user group on the server.
     2. Add the AD group in question to this group.
     3. You should now be able to assign version control permissions to the AD group.

## Disclaimer

Microsoft and/or its suppliers make no representations or warranties about the suitability, reliability, or accuracy of the information contained in the documents and related graphics published on this website (the "materials") for any purpose. The materials may include technical inaccuracies or typographical errors and may be revised at any time without notice.

To the maximum extent permitted by applicable law, Microsoft and/or its suppliers disclaim and exclude all representations, warranties, and conditions whether express, implied or statutory, including but not limited to representations, warranties, or conditions of title, non infringement, satisfactory condition or quality, merchantability and fitness for a particular purpose, with respect to the materials.
