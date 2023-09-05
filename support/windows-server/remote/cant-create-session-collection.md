---
title: Can't create a session collection
description: Describes an issue in which you can't create a session collection correctly in Windows Server 2012.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, ryhayash
ms.custom: sap:administration, csstroubleshoot
ms.technology: windows-server-rds
---
# You cannot create a session collection and an error occurs in Windows Server 2012

This article provides a solution to an issue where you can't create a session collection correctly.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3014614

## Symptoms  

Consider the following scenario:

- You enable the one of the following Group Policy settings on a Windows Server 2012-based server:

  - Require user authentication for remote connections by using Network Level Authentication
  - Set client connection encryption level
  - Use the specified Remote Desktop license servers
- You create a session-based desktop deployment.

In this scenario, the session collection deployment fails with an "Unable to create the session collection" error message. In addition, the RemoteApp programs that are being created are canceled.

Additionally, if you create a session collection individually, you receive the following error message:

> Unable to configure the RD Session Host Server **\<server name>**. Invalid operation

> [!NOTE]
> The Group Policy settings are under the following Group Policy paths:
>
> - `Computer Configuration\Administrative Templates\Windows Components\Remote Desktop Services\Security`
> - `Computer Configuration\Administrative Templates\Windows Components\Remote Desktop Services\Remote Desktop Session Host\Licensing`

## Workaround

To work around this issue, apply the Group Policy settings that are mentioned in the [Symptoms](#symptoms) section after you create the Session Collection.

## Status

Microsoft has confirmed that it's a problem in the Microsoft products that are listed in the Applies to section.

## More information

For more information, see [Description of the standard terminology that is used to describe Microsoft software updates](../../windows-client/deployment/standard-terminology-software-updates.md).
