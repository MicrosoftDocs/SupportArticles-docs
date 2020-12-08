---
title: Start menu shortcuts aren't immediately accessible in Windows Server
description: Describes an issue that makes a folder that contains shortcuts on the Start menu inaccessible. Occurs on a Windows Server 2016 or Windows Server 2019-based computer. A workaround is provided.
ms.date: 12/03/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: 
---
# Start menu shortcuts aren't immediately accessible in Windows Server 2016 and Windows Server 2019

_Original product version:_ &nbsp; Windows Server 2019, all editions, Windows Server 2016 Standard, Windows Server 2016 Datacenter  
_Original KB number:_ &nbsp; 3198613

## Symptoms

On a computer that's running Windows Server 2016 or Windows Server 2019 with the Desktop Experience, you install an application that creates one or more shortcuts on the **Start** menu. The shortcuts are contained in a folder on the **Start** menu. However, you discover that the folder is not clickable or expandable, and therefore these shortcuts are unavailable.

## Workaround

To work around this issue, log off the computer and then log back on. The new folder on the **Start** menu should now be expandable, and the shortcuts in the folder are now clickable.
