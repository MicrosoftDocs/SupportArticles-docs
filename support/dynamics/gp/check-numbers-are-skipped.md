---
title: Check numbers are skipped
description: Provides a solution to an issue where check numbers are skipped in Payables Management in Microsoft Dynamics GP.
ms.reviewer: theley, deeptivu, cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Financial - Payables Management
---
# Check numbers are skipped in Payables Management in Microsoft Dynamics GP

This article provides a solution to an issue where check numbers are skipped in Payables Management in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2514845

## Symptoms

Check numbers are skipped in Payables Management. For example, the last check run used check numbers through check number 1280. When you do a new check run, it begins with check number 1282. Check number 1281 was skipped. The Next Check Number to be used in the Checkbook Maintenance window displays 1282.

## Cause

It's by design. The system places a lock on any check number in use and increments the Next Check number accordingly as multiple users continue to work. If one user is in a window that locks a check number, and later decides to back out of the window, there's a possibility for that check number to be skipped.

Listed below are several scenarios when a check number could be skipped:

1. If a user enters any of the following windows, the system will place a lock on that next check number in use and will increment the Next Check Number in the Checkbook Maintenance window. If a different person prints checks simultaneously and for some reason the first person doesn't create the check, then a check might be skipped.

    - Payables Manual Payment Entry
    - Miscellaneous Check
    - Bank Transaction Entry
    - Print Payables Transaction Check
    - Print Payables Checks
    - Payroll Manual Check
    - Print Payroll Checks

    For example, if the last check number used was 1280 and a user opens one of the above windows, the check number that populates the window will increment to 1281. At the same time, if another user enters one of the windows above to write a check, then the system sees that 1281 is in use and increments the next check number to 1282 for the second user. If the first user decides not to post the check 1281 and closes the window, then the check 1281 remains unused in the system and is skipped.

2. When an alignment form is printed, the check number is incremented.

3. If a check is printed to screen or file, the next check number is incremented.

4. If a check is being printed for the same checkbook through any other module, then the next check number will be incremented.

5. If users manually edit the Next Check Number field in the Checkbook maintenance window, then there is a chance to skip check numbers, depending on what the user has entered.

6. If multiple modules are using the same checkbook, then the next check number increments when a check is printed.

## Resolution

The system is designed to pull the check number from the Next Check Number field in the Checkbook Maintenance window when a check is written. The Next Check number field can be verified in the Checkbook Maintenance window before processing a check runs. After verifying if there are any check numbers missing in the system or not, the Next Check Number field can be changed if needed.

Be sure to alert users in a multi-user environment not to remain idle in one of the windows listed above if they don't intend to continue processing in that window. It may result in skipped check numbers if they back out of these windows.
