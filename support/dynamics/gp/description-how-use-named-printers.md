---
title: Description of how to use named printers
description: Describes how to use named printers to enable printer destination selection and to enable various printer tasks in Microsoft Dynamics GP.
ms.reviewer: kyouells
ms.topic: how-to
ms.date: 03/13/2024
---
# Description of how to use named printers to enable printer destination selection and to enable various printer tasks in Microsoft Dynamics GP

This article describes how to use named printers to enable printer destination selection and to enable various printer tasks in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 936945

## Introduction

To use named printers to enable printer destination selection and to enable various printer tasks in Microsoft Dynamics GP, as follows:

- In the Assign Named Printers window, you can configure a printer to be used as the default printer for Microsoft Dynamics GP. It lets you configure a default printer for Microsoft Dynamics GP that differs from the default printer that is used by the operating system.
- In the Assign Named Printers window, you can also specify a printer for many printer tasks in Microsoft Dynamics GP. These printer tasks are divided into the various functions that can be performed.

## More information

The default printer in Microsoft Dynamics GP is set when you sign in. Microsoft Dynamics GP uses the default printer for the System task series when no other printer settings can be found. Microsoft Dynamics GP uses the default printer for the Company task series when the printer depends on the user, the company, or on the user and company combination that is active in Microsoft Dynamics GP.

For all other printer tasks, the destination printer selection is specified when a report is printed. It doesn't change the default printer in Microsoft Dynamics GP.

In the Assign Named Printers window, you can only control reports for which the following conditions are true:

- The reports are printed in Microsoft Dynamics GP.
- Named printer support has been added for the reports.

Reports that haven['t been added to named printers will print to the default printer in Microsoft Dynamics GP as specified by the default printer for the Company task series or as specified by the default printer for the System task series.

Reports that are printed by external applications are beyond the control of named printers even if the applications are started within Microsoft Dynamics GP. These reports will print to the default printer of the operating system. It includes reports from SQL Server Reporting Services (SSRS), Crystal Reports, and Microsoft FRx.

For more information about named printers selection, see [How the named printers feature selects a printer in Microsoft Dynamics GP](https://support.microsoft.com/help/935790).
