---
title: Start menu shortcuts aren't immediately accessible in Windows Server
description: Describes an issue that makes a folder that contains shortcuts on the Start menu inaccessible. Occurs on a Windows Server 2016 or Windows Server 2019-based computer. A workaround is provided.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-jesits, v-six, robsim, cpuckett
ms.custom: sap:start-menu, csstroubleshoot
---
# Start menu shortcuts aren't immediately accessible in Windows Server 2016 and Windows Server 2019

This article provides a workaround for the issue that makes a folder that contains shortcuts on the **Start** menu inaccessible.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016  
_Original KB number:_ &nbsp; 3198613

## Symptoms

On a computer that's running Windows Server 2016 or Windows Server 2019 with the Desktop Experience, you install an application that creates one or more shortcuts on the **Start** menu. The shortcuts are contained in a folder on the **Start** menu. However, you discover that the folder is not clickable or expandable, and therefore these shortcuts are unavailable.

## Workaround

To work around this issue, log off the computer and then log back on. The new folder on the **Start** menu should now be expandable, and the shortcuts in the folder are now clickable.
