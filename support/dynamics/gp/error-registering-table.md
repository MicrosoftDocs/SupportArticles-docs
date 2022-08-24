---
title: Error Registering table
description: Fixes an issue in which table registering fails when you start Microsoft Dynamics GP.
ms.reviewer:
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# "Error Registering table 'ASI_MSTR_Explorer_Favorites'" Error message when you start Microsoft Dynamics GP

This article provides a solution to an error that occurs when you start Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 961195

## Symptoms

When you start Microsoft Dynamics GP 10.0, you receive the following error message:
> Error Registering table 'ASI_MSTR_Explorer_Favorites'.

## Cause

This problem occurs if the SmartList forms dictionary is corrupt.

## Resolution

Always make a backup first.

1. On the server or workstation where this issue occurs, open the **DYNAMICS.SET** file in **Notepad**. By default, this file exists in the following locations:

    `C:\Program Files\Microsoft Dynamics\GP\`
2. Search for **EXP1493F.DIC**. Confirm that the EXP1493F.DIC dictionary file exists in this location. The line will look similar to the following example:

    `C:Program Files/Microsoft Dynamics/GP/Data/EXP1493F.DIC`

3. Start Microsoft Dynamics GP and sign in as the sa user.
4. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Customize**, and then select **Customization Maintenance.**
5. Select the modified SmartList forms in this list.
6. Select **Export**.
7. Choose a file name, and then select **Save**.
8. Close Microsoft Dynamics GP.
9. Browse to the **EXP1493F.DIC** file. By default, this file exists is in the following location:

    `C:\Program Files\Microsoft Dynamics\GP\Data\`
10. **Rename** this file **EXP1493F_old.DIC**.
11. Start Microsoft Dynamics GP, and then sign in.
12. Open the **Customization Maintenance** window again, and then select **Import**.
13. Select **Browse** and locate your package file that was created earlier. Select it, select **Open**, and then select **OK**. You'll now see your SmartList form(s) have been readded to this window.
14. Close the Customization Maintenance window.
15. **Exit** Microsoft Dynamics GP.
16. **Start** Microsoft Dynamics GP.
