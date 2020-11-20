---
title: Debug programs user right occurs for groups
description: The Exchange Servers and Exchange Trusted Subsystem groups unexpectedly receive Debug programs user right under the default domain controller policy.
ms.date: 06/22/2020
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Server
- CSSTroubleshoot
ms.reviewer: btalb, ninob
appliesto:
- Exchange Server 2016 Standard Edition
- Exchange Server 2016 Enterprise Edition
search.appverid: MET150
---
# Exchange Servers and Exchange Trusted Subsystem groups unexpectedly have the debug programs user right

_Original KB number:_ &nbsp; 4055597

## Symptoms

After you install Exchange Server 2016, you notice that the Exchange Servers and Exchange Trusted Subsystem groups have the Debug programs user right on domain controllers. This status appears in the Default Domain Controller Policy object in Group Policy Management Editor in the following path:

> Default Domain Controller Policy\Computer Config\Policies\Windows settings\Security Settings\local policies\User Rights Assignments\Debug program

:::image type="content" source="media/unexpected-debug-programs-user-right/debug-programs-user-right.png" alt-text="Debug programs user right for Exchange groups" border="false":::

## Cause

During the installation of Exchange Server 2016, the default domain controller policy grants the Debug programs user right to the Exchange Servers and Exchange Trusted Subsystem groups. However, these groups don't require this user right on the domain controller.

## Workaround

To work around this issue, manually remove the Debug programs user right from the Exchange Servers and Exchange Trusted Subsystem groups.

## Status

Microsoft is aware of this issue and is working on a fix to be released in a future update.
