---
title: Cumulative Update 20 shown instead of CU22
description: After you install Exchange Server 2013 Cumulative Update 22, Cumulative Update 20 shows in Programs and Features. Provides a workaround.
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Plan and Deploy\Exchange Install Issues, Cumulative or Security updates
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: batre, v-six
appliesto: 
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2013 Enterprise
search.appverid: MET150
---
# Cumulative Update 20 shows in Programs and Features if installing Exchange Server 2013 Cumulative Update 22

_Original KB number:_ &nbsp; 4492759

## Symptoms

After you successfully install Cumulative Update 22 for Exchange Server 2013, the **Programs and Features** item in Control Panel lists the installation as Exchange Server 2013 Cumulative Update 20.

## Cause

This issue occurs because Exchange Server Setup does not update the version string in the registry correctly.

## Workaround

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756/) in case problems occur.

To fix this issue, change the registry key for the update display name. To do this, follow these steps:

1. On the **Start** menu, select **Run**, type *regedit* in the **Open** box, and then select **OK**.
2. Locate the following subkey:  
   `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Exchange v15`
3. In the details pane, locate and double-click the **DisplayName** item.
4. In the **Value data** box, change the string to the following value:  
   **Microsoft Exchange Server 2013 Cumulative Update 22**  
5. Select **OK** to save the change.

   :::image type="content" source="media/cumulative-update-20-is-shown-not-22/change-registry-key.png" alt-text="Screenshot shows steps to change the registry key for the update display name.":::
