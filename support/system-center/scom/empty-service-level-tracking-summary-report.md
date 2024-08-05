---
title: The Service Level Tracking Summary report is empty
description: Fixes an issue in which a Service Level Tracking Summary report in Operations Manager is empty if you don't select Today for the TO date.
ms.date: 04/15/2024
ms.reviewer: mihsar
---
# The Service Level Tracking Summary report may be empty if Today isn't selected for the TO date

This article helps you fix an issue in which a Service Level Tracking Summary report in Operations Manager is empty if you don't select **Today** as the **TO** date.

_Original product version:_ &nbsp; System Center Operations Manager  
_Original KB number:_ &nbsp; 2567404

## Symptoms

If you run a Service Level Tracking Summary report in System Center Operations Manager and select a different **TO** date than **Today**, it may come up empty depending on the chosen Service Level Objective (SLO) and/or selected date.

## Cause

The SLOs defined in the Operations Manager console are stored into a specified management pack. Whenever you modify that management pack, it will create a new edition of the management pack and insert a new record into the data warehouse database to mark the timestamp when this management pack is installed. When you run the Service Level Tracking Report, it will check to see if there is a corresponding management pack record within the specified time period. This validation is used to ensure that all SLOs were defined in the respective management group during the reporting period. That means that even if the management pack was created a long time ago, if you make any modification on the objects contained in this management pack, it will change the management pack installation date time. If the management pack installation date time is outside of the specified time period in the Service Level Summary Report, the report will be empty.

## Resolution

This has to do with how the management packs are preserved in the data warehouse. By default sealed management packs are stored for 400 days after their deletion and unsealed management packs up to 400 days but you also only keeping the last three versions of each unsealed management pack. If your unsealed management pack contains many objects (in this case SLOs) and you change them rather frequently, it's likely you can get into these situations. You can consider doing one or all of the following things:

- Seal management packs where you store SLOs.
- Store SLOs separately (in separate management packs).
- Increase the number of versions of the sealed management pack data warehouse will preserve. To do this, run the following SQL query on the data warehouse database (default is `OperationsManagerDW`):

  ```sql
  UPDATE [MaintenanceSetting] SET [NonSealedManagementPackMaxVersionCount] = 8
  ```

    > [!NOTE]
    > 8 is just an example number. Don't set the number too high. We advise against setting this to a larger number than 10. You should try a smaller number until it fits for your environment.
