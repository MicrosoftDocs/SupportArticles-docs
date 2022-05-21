---
title: Receive CD-ROM notification
description: This article explains how to handle the WM_DEVICECHANGE message to detect CD-ROM or DVD media changes.
ms.date: 03/16/2020
ms.custom: sap:System services development
ms.topic: how-to
ms.technology: windows-dev-apps-system-services-dev
---
# How to receive notification of CD-ROM insertion or removal

Some applications need to know when the user inserts or removes a compact disc or DVD from a CD-ROM drive without polling for media changes. Windows provide a way to notify these applications through the `WM_DEVICECHANGE` message. This article explains how to handle the `WM_DEVICECHANGE` message to detect CD-ROM or DVD media changes.

_Original product version:_ &nbsp; Windows  
_Original KB number:_ &nbsp; 163503

## Windows notification

Windows sends all top-level windows a `WM_DEVICECHANGE` message when new devices or media are added and become available, and when existing devices or media are removed. Each `WM_DEVICECHANGE` message has an event associated with it to describe the change, and a structure that provides detailed information about the change.

The structure consists of an event-independent header followed by an event-dependent structure. The event-dependent part of the structure describes which device the event applies to. To use this structure, applications must first determine the event type and the device type. Then, they can use the correct structure to take appropriate action.

When the user inserts a new compact disc or DVD into a drive, applications get a `WM_DEVICECHANCE` message with a `DBT_DEVICEARRIVAL` event. The application must check the event to make sure that the type of device arriving is a volume (`DBT_DEVTYP_VOLUME`) and that the event's media flag (`DBTF_MEDIA`) is set.

When the user removes a compact disc from a CD-ROM drive or DVD, applications will get a `WM_DEVICECHANCE` message with a `DBT_DEVICEREMOVECOMPLETE` event. As with `DBT_DEVICEARRIVAL` above, the application must check the event to make sure that the device being removed is a volume and that the event's media flag is set.

## Sample code

The following code demonstrates how to use the `WM_DEVICECHANGE` message to check for compact disc or DVD insertion or removal.

``` cpp
#include <windows.h>
#include <dbt.h>

char FirstDriveFromMask (ULONG unitmask);  //prototype
/*----------------------------------------------------------------------
   Main_OnDeviceChange (hwnd, wParam, lParam)
   Description
   Handles WM_DEVICECHANGE messages sent to the application's top-level window.
   ----------------------------------------------------------------------*/
void Main_OnDeviceChange (HWND hwnd, WPARAM wParam, LPARAM lParam)
{
   PDEV_BROADCAST_HDR lpdb = (PDEV_BROADCAST_HDR)lParam;
   char szMsg[80];

   switch(wParam)
   {
      case DBT_DEVICEARRIVAL:
      // See if a CD-ROM or DVD was inserted into a drive.
      if (lpdb -> dbch_devicetype == DBT_DEVTYP_VOLUME)
      {
         PDEV_BROADCAST_VOLUME lpdbv = (PDEV_BROADCAST_VOLUME)lpdb;

         if (lpdbv -> dbcv_flags & DBTF_MEDIA)
         {
            wsprintf (szMsg, "Drive %c: arrived\n",
                     FirstDriveFromMask(lpdbv ->dbcv_unitmask));
            MessageBox (hwnd, szMsg, "WM_DEVICECHANGE", MB_OK);
         }
      }
      break;

      case DBT_DEVICEREMOVECOMPLETE:
      // See if a CD-ROM was removed from a drive.
      if (lpdb -> dbch_devicetype == DBT_DEVTYP_VOLUME)
      {
         PDEV_BROADCAST_VOLUME lpdbv = (PDEV_BROADCAST_VOLUME)lpdb;

         if (lpdbv -> dbcv_flags & DBTF_MEDIA)
         {
            wsprintf (szMsg, "Drive %c: was removed\n",
                     FirstDriveFromMask(lpdbv ->dbcv_unitmask));
            MessageBox (hwnd, szMsg, "WM_DEVICECHANGE", MB_OK);
         }
      }
      break;

      default:
     /*
       Other WM_DEVICECHANGE notifications get sent for other devices or 
       reasons; we don't care about them here.  If they were important, we 
       would check for them and act accordingly.
    */
     ;
   }
}
/*----------------------------------------------------------------------
   FirstDriveFromMask (unitmask)
   Finds the first valid drive letter from a mask of drive letters. 
   The mask must be in the format bit 0 = A, bit 1 = B, bit 3 = C, etc.
   A valid drive letter is defined when the corresponding bit is set to 1.
   Returns the drive letter that was first found.
   ----------------------------------------------------------------------*/
char FirstDriveFromMask (ULONG unitmask)
{
   char i;

   for (i = 0; i < 26; ++i)
   {
      if (unitmask & 0x1)
            break;
      unitmask = unitmask >> 1;
   }
   return (i + 'A');
}
```

Although this sample code only checks for volume arrivals due to the insertion of new media, it can be extended to get notification of other hardware events for other types too. To do so, you have to add cases for other device events and handle different device types for each event.
