---
title: Rename, Restart, Restore and Reset Cloud PCs with Windows 365
description: Manage your Windows 365 Cloud PC with direct actions like viewing details, renaming, restarting, restoring, and resetting from one place.
ms.date: 05/27/2026
manager: dcscontentpm
ms.reviewer: kaushika
ms.topic: troubleshooting
ms.custom:
- pcy:WinComm User Experience
- sap:Configuration and Management\Application Issues
---

# Rename, Restart, Restore and Reset Cloud PCs with Windows 365

You can perform a variety of actions on your Windows 365 Cloud PC, just like you would on a physical PC. This article describes the direct actions available to help you manage your Cloud PCs, including inspecting connections, viewing details, renaming, restarting, restoring, and resetting.

## Inspect the connection

When you inspect the connection, the process checks if your Cloud PC is ready to connect, if Windows 365 is working properly, and it tries to resolve any detected problems. Your Cloud PC is unavailable while it's checking the connection.

1. Under **Your Cloud PCs**, select **Inspect connection** at the upper right of the Cloud PC you want to inspect. A pop-up appears.
1. Check the box next to **Yes, I want to inspect the connection for this Cloud PC**, and then select **Inspect connection**.
1. After your Cloud PC inspects your connection, you see one of the following results:
    - **Fixed connection issues for [Name's] Cloud PC** highlighted in green - your Cloud PC displays **Ready to connect** at the upper left.
    - **No connection issues found for [Name's] Cloud PC** highlighted in green - your Cloud PC displays **Ready to connect** at the upper left.
    - **Couldn't fix connection issues found for [Name's] Cloud PC** highlighted in red. **Please use our help resources to further troubleshoot your issue**.

## View Cloud PC details

You can view your Cloud PC details, such as OS, OS version, device name, Cloud PC name, license, and last sign-in.

1. Under **Your Cloud PCs**, select the three dots (More) at the upper right of the Cloud PC whose details you want to view.
1. Select **View details**. A pop-up appears with your Cloud PC details.

## Rename your Cloud PC

Renaming your Cloud PC works just like renaming a physical PC. It changes your Cloud PC name to whatever name you choose.

To rename your Cloud PC:  

1. Under **Your Cloud PCs**, select **Edit** next to [Name’s] Cloud PC. 
1. Enter the new name you want for this Cloud PC.
1. After you rename your Cloud PC, you see one of the following results:  
    - If successful: Renamed [Name’s] Cloud PC highlighted in green.
    - If unsuccessful, one or more of the following error messages appear in red:
      - **[Name’s] Cloud PC wasn't renamed. Names can't include the characters /:**\***?”<>|**.
      - **[Name’s] Cloud PC wasn't renamed. Names can't start with:** .
      - **[Name’s] Cloud PC wasn't renamed. Names must be at least 1 character long**.
      - **[Name’s] Cloud PC wasn't renamed. Names must be less than 16 characters long**.
      
## Restart your Cloud PC

Restarting your Cloud PC works just like restarting a physical PC. Any unsaved changes might be lost. Your Cloud PC is unavailable until it finishes restarting.

1. Under **Your Cloud PCs**, select **Restart** at the top right of the Cloud PC you want to restart.
1. Select **Restart** again to confirm you want to restart the selected Cloud PC.
1. After your Cloud PC restarts, you see one of the following results:
   - **Restarted [Name’s] Cloud PC** highlighted in green - your restart attempt was successful.
   - **[Name’s] Cloud PC wasn't restarted**. **Try restarting again** highlighted in red - your restart attempt was unsuccessful. Try restarting again by using the preceding steps.
      
## Restore your Cloud PC

Restoring your Cloud PC works like restoring a physical PC. It returns your Cloud PC to a previous point in time. Restoring a Cloud PC permanently deletes data saved to the Cloud PC and any apps installed between the restore point and now. Your Cloud PC is unavailable until it finishes restoring.

>[!WARNING]
>You can't undo this action.

1. Under **Your Cloud PCs**, select the three dots ... at the top right of the Cloud PC you want to restore, and then select **Restore**.
1. Check the box next to **Yes, I want to restore this Cloud PC**, choose a restart point from the drop-down menu, and then select **Restore**.
1. When your Cloud PC finishes restoring, you see one of the following results:
    - **Restored [Name’s] Cloud PC** highlighted in green - your restore attempt was successful.
    - **[Name’s] Cloud PC wasn’t restored. Try restoring again** highlighted in red - your restore attempt was unsuccessful. Try restoring again by using the preceding steps.

## Reset your Cloud PC

Resetting your Cloud PC works like resetting a physical PC. It deletes all data and resets any changes you made on your Cloud PC. Resetting a Cloud PC reinstalls Windows 11, removes personal files and apps, resets any changes to settings, and removes any saved restore points. To avoid losing everything on this Cloud PC, use restore to return it to a previous point in time. Your Cloud PC is unavailable until it finishes resetting.

>[!WARNING]
>You can't undo this action.

1. Under **Your Cloud PCs**, select the three dots ... at the top right of the Cloud PC you’d like to restore, and then select **Reset**.
1. Check the box next to **Yes, I want to restore this Cloud PC**.
1. Check that you're sure you want to fully reset this Cloud PC, and then select **Reset**.
1. When your Cloud PC finishes resetting, you see one of the following results:
    - **Reset [Name’s] Cloud PC** highlighted in green - your restore attempt was successful.
    - **[Name’s] Cloud PC wasn’t reset. Try resetting again** highlighted in red - your reset attempt was unsuccessful. Try resetting again by using the preceding steps.
