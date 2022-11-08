---
title: Dex Procedure to create HR Attendance Transactions
description: Gives information on how you can use Dexterity to call scripts to run externally. This is for an alternative solution to running HR Reconcile after an Integration Manager Payroll Transaction was run.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# Dex Procedure to create HR Attendance Transactions in Microsoft Dynamics GP

Integration Manager is being used to create payroll transactions. After the transactions are created, HR reconcile is run to create the corresponding HR attendance transactions. It works fine, but has slow performance. The alternative is to create the HR attendance transactions without running the HR reconcile.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2453011

## Resolution

Microsoft Dynamics GP runs a series of scripts to save the attendance data. These scripts are running inside of the window context, but they can be called externally as long as you have the necessary transaction information. You can call the `hrCommitAttendance()` of form uprComputerTrx function, which is in the core GP dictionary. The parameters can be located in the SDK. To call this, you have to populate the `hrAttendanceData` composite field that has the correct data. Here's the data that Microsoft Dynamic GP populates it with, be aware, this is in the context of the window to give an idea of what would have to be populated.

```console
hrAttendanceData:'Attendance TRX Status' of window uprTransactions = ATTENDANCE_STATUS_POSTED;

hrAttendanceData:'Batch Number' of window uprTransactions = 'Batch Number' of window UPR_TRX_Standard_Entry;

hrAttendanceData:'Computer TRX Number' of window uprTransactions = 'Computer TRX Number' of window uprTransactions;

hrAttendanceData:'Employee ID' of window uprTransactions = 'Employee ID' of window uprTransactions;

hrAttendanceData:'Pay Record' of window uprTransactions = 'UPR TRX Code' of window uprTransactions;

hrAttendanceData:'Start Date' of window uprTransactions = 'TRX Beginning Date' of window uprTransactions;

hrAttendanceData:'End Date' of window uprTransactions = 'TRX Ending Date' of window uprTransactions;

hrAttendanceData:'Hours' of window uprTransactions = long('(L) Amount' of window uprTransactions * 100);

hrAttendanceData:'Days Worked' of window uprTransactions = long('(L) DaysWorked' of window uprTransactions * 100);

hrAttendanceData:'Weeks Worked' of window uprTransactions = long('(L) WeeksWorked' of window uprTransactions * 100);

hrAttendanceData:'Attendance Reason' of window uprTransactions = itemname('Attendance Reason DDL' of window uprTransactions, 
 'Attendance Reason DDL' of window uprTransactions);
hrAttendanceData:'Attendance Type' of window uprTransactions = itemname('Attendance Type DDL' of window uprTransactions, 
 'Attendance Type DDL' of window uprTransactions);
```

As soon as the composite is populated, then call `hrCommitAttendance()` and pass it in. The one remaining issue would be the `hrAttendanceData: 'Time Code'`. Microsoft Dynamic GP is populating this in a way that isn't easily accessible from a third-party application. This is a required field and the data must be provided by your application.
