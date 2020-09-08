---
title: Can't access AD data from Source Control Explorer
description: Provides a solution to solve an error that occurs when you access Active Directory information from Team Foundation Server Source Control Explorer.
ms.date: 09/08/2020
author: delhan
ms.author: Delead-Han
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: User, computer, group, and object management
ms.technology: ActiveDirectory
---
# "Object reference not set to an instance of an object" while accessing Active Directory information from TFS Source Control Explorer

This article provides help to solve an error that occurs when you access Active Directory information from Team Foundation Server Source Control Explorer.

_Original product version:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 957969

## RAPID PUBLISHING

RAPID PUBLISHING ARTICLES PROVIDE INFORMATION DIRECTLY FROM WITHIN THE MICROSOFT SUPPORT ORGANIZATION. THE INFORMATION CONTAINED HEREIN IS CREATED IN RESPONSE TO EMERGING OR UNIQUE TOPICS, OR IS INTENDED SUPPLEMENT OTHER KNOWLEDGE BASE INFORMATION.

## Action

Create a Windows group in Active Directory (AD), and assign AD users to the group, then...

1. Open Visual Studio as a TFS Administrator
2. Open "Source Control Explorer"
3. Right+click on a version control folder and select Properties
4. Click the Security tab on the Properties dialog
5. Select the "Windows User or Group" option and click the Add button
6. Browse for the AD group; and attempt to add the group

## Result

Error: Object reference not set to an instance of an object.

## Cause

This issue is caused by a bug in the version control permission dialog window in Visual Studio 2008 \ Team Explorer 2008.

## Resolution

This problem is resolved in Visual Studio 2008 SP1. If you are using Visual Studio 2008 RTM, there are two workarounds:

1. Assign version control permissions with commandline tool: tf.exe

You can enter "tf perm /?" or review the MSDN documentation for this command [TF Permission command](https://msdn.microsoft.com/library/0dsd05ft.aspx)  for more information about how to assign version control permissions from command line.

2. Explicitly make the AD group in question a valid TFS identity:

a. Create a new user group on the server.
 b. Add the AD group in question to this group.
 c. You should now be able to assign version control permissions to the AD group.

## DISCLAIMER

MICROSOFT AND/OR ITS SUPPLIERS MAKE NO REPRESENTATIONS OR WARRANTIES ABOUT THE SUITABILITY, RELIABILITY OR ACCURACY OF THE INFORMATION CONTAINED IN THE DOCUMENTS AND RELATED GRAPHICS PUBLISHED ON THIS WEBSITE (THE "MATERIALS") FOR ANY PURPOSE. THE MATERIALS MAY INCLUDE TECHNICAL INACCURACIES OR TYPOGRAPHICAL ERRORS AND MAY BE REVISED AT ANY TIME WITHOUT NOTICE.

TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW, MICROSOFT AND/OR ITS SUPPLIERS DISCLAIM AND EXCLUDE ALL REPRESENTATIONS, WARRANTIES, AND CONDITIONS WHETHER EXPRESS, IMPLIED OR STATUTORY, INCLUDING BUT NOT LIMITED TO REPRESENTATIONS, WARRANTIES, OR CONDITIONS OF TITLE, NON INFRINGEMENT, SATISFACTORY CONDITION OR QUALITY, MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, WITH RESPECT TO THE MATERIALS.
