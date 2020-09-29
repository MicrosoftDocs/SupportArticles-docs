---
title: Fail to run applications on Windows Server Core
description: Provides a solution to an issue where you fail to run or install applications on a Windows Server computer running as a Server Core
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Setup
ms.technology: Deployment
---
# Message "Subsystem needed to support the image type is not present" error when installing or running applications on Windows Server 2008 R2 Core

This article helps fix an error (Subsystem needed to support the image type is not present) that occurs when you run or install applications on a Windows Server computer running as a Server Core.

_Original product version:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 974727

## RAPID PUBLISHING

RAPID PUBLISHING ARTICLES PROVIDE INFORMATION DIRECTLY FROM WITHIN THE MICROSOFT SUPPORT ORGANIZATION. THE INFORMATION CONTAINED HEREIN IS CREATED IN RESPONSE TO EMERGING OR UNIQUE TOPICS, OR IS INTENDED SUPPLEMENT OTHER KNOWLEDGE BASE INFORMATION.

## Symptom

When you run or install applications on a Windows Server 2008 R2 computer running as a Server Core, you receive the following message:

"The subsystem needed to support the image type is not present"

## Cause

The 32-bit subsystem support has been removed from the server, either manually or through an automated build process. This can be confirmed by running the following command:

`dism /online /get-features /format:table`

Examine the output and confirm the following:

ServerCore-WOW64 | Disabled

## Resolution

To enable the 32-bit subsystem:

1. Logon to the Server Core computer as an administrator.

2. Run the following command exactly as shown:

`DISM.EXE /online /enable-feature /featurename:ServerCore-WOW64`

Note: The feature name 'ServerCore-WOW64' is case-sensitive.

3. Restart the computer when prompted.

## More information

To reproduce this scenario: 

To enable the 32-bit subsystem:

1. Logon to the Server Core computer as an administrator.

2. Run the following command exactly as shown:

`DISM.EXE /online /enable-feature /featurename:ServerCore-WOW64`

Note: The feature name 'ServerCore-WOW64' is case-sensitive.

3. Restart the computer when prompted.

More Information 

Any applications that are compiled with 32-bit code will not run on Server Core when the 32-bit subsystem has been removed. This also includes the installers of 64-bit applications, where the installer itself contains 32-bit code.

References 

For more information, review:

What's New in the Server Core Installation Option: [https://technet.microsoft.com/library/dd883268(WS.10).aspx](https://technet.microsoft.com/library/dd883268%28ws.10%29.aspx) 

## DISCLAIMER

MICROSOFT AND/OR ITS SUPPLIERS MAKE NO REPRESENTATIONS OR WARRANTIES ABOUT THE SUITABILITY, RELIABILITY OR ACCURACY OF THE INFORMATION CONTAINED IN THE DOCUMENTS AND RELATED GRAPHICS PUBLISHED ON THIS WEBSITE (THE "MATERIALS") FOR ANY PURPOSE. THE MATERIALS MAY INCLUDE TECHNICAL INACCURACIES OR TYPOGRAPHICAL ERRORS AND MAY BE REVISED AT ANY TIME WITHOUT NOTICE.

TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW, MICROSOFT AND/OR ITS SUPPLIERS DISCLAIM AND EXCLUDE ALL REPRESENTATIONS, WARRANTIES, AND CONDITIONS WHETHER EXPRESS, IMPLIED OR STATUTORY, INCLUDING BUT NOT LIMITED TO REPRESENTATIONS, WARRANTIES, OR CONDITIONS OF TITLE, NON INFRINGEMENT, SATISFACTORY CONDITION OR QUALITY, MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, WITH RESPECT TO THE MATERIALS.
