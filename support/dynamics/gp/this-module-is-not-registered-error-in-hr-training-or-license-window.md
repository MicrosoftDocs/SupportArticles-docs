---
title: This module is not registered error in HR Training or License
description: This module isn't registered error occurs when you Training, Certifications, License, Health & Wellness, and Injury & Illness Details, or Dependents.
ms.reviewer: cwaswick
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# "This module isn't registered" error in the HR Training or License window in Microsoft Dynamics GP

This article provides methods to solve the error **This module isn't registered** that may occur in the HR Training or License window in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 3145327

## Symptoms

When attempting to access Training, Certifications, License, Health & Wellness, and Injury & Illness Details, or Dependents, you receive the error message:

> This module isn't registered. To register this module, contact your Microsoft Dynamics GP representative.

## Cause

There's only one training window and so if security is set for Advanced HR, the window gets taken over. This happens to both the Training window and the Dependents window in HR. HR has a third party dictionary and there aren't *alternate windows*. There is only one window. So if you install the HRM Suite, the windows get taken over. For other windows, the security may be set to the HRM window. The error will occur if the module is installed or has security set to it, but it isn't listed in the Registration Keys and you try to access the new window.

## Resolution

Use one of the below methods to resolve this issue:

### Method 1

You can run the below script in SQL Server Management Studio against the Dynamics database. The results will list out what security tasks have security to the Employee Training window and the product name associated. Review to see if any tasks have security set under the Advanced HR or Certification Manager  product name.  Review to see if the employee has any role assigned that includes that Security Task, or modify the Security task to remove it.

```sql
SELECT ISNULL(O.SECURITYTASKID,'') AS SECURITYTASKID, R.PRODNAME, R.TYPESTR, R.DSPLNAME, R.DICTID FROM DYNAMICS.dbo.SY09400 R FULL JOIN DYNAMICS.dbo.SY10700 O ON R.DICTID = O.DICTID AND O.SECRESTYPE = R.SECRESTYPE AND O.SECURITYID = R.SECURITYID FULL JOIN DYNAMICS.dbo.SY09000 T ON T.SECURITYTASKID = O.SECURITYTASKID FULL JOIN DYNAMICS.dbo.SY10600 A ON A.SECURITYTASKID = T.SECURITYTASKID FULL JOIN DYNAMICS.dbo.SY09100 M ON M.SECURITYROLEID = A.SECURITYROLEID WHERE R.SECRESTYPE=2 and R.DSPLNAME = 'Employee Training' order by R.PRODNAME
```

> [!NOTE]
> You can edit the Display name (DSPLNAM) accordingly in the script above if you need to check a different window such as **License Entry** or **Employee Dependents**.

### Method 2

Another option is to remove it from the Dynamics.set file. If you would like to use Payroll Extensions*, but aren't using CLTM or EHW, you can remove these modules from your Dynamics.set file as follows:

1. Go to the GP code folder and make a backup of the Dynamics.set file.
2. Then right-click on the Dynamics.set file and open it with Notepad.
3. Reduce the number in the first line by 2
4. Delete the lines for these modules:

    4933
    Certification Manager
    4955
    Employee Health and Wellness

5. Remove these paths:

    :C:Program Files (x86)/Microsoft Dynamics/GP2013/CLTM.DIC  
    :C:Program Files (x86)/Microsoft Dynamics/GP2013/Data/F4933.DIC  
    :C:Program Files (x86)/Microsoft Dynamics/GP2013/Data/R4933.DIC  
    :C:Program Files (x86)/Microsoft Dynamics/GP2013/EHW.DIC  
    :C:Program Files (x86)/Microsoft Dynamics/GP2013/Data/F4955.DIC  
    :C:Program Files (x86)/Microsoft Dynamics/GP2013/Data/Dynamics/R4955.DIC

6. Save and close the file. Relaunch GP to have the changes take effect.

### Method 3

If you would like to become registered for this Advanced HR product, contact Sales Operations Support using the appropriate method below:

**Partners**: Go to [All Partner Center help in one place](https://partner.microsoft.com/support/?stage=1) link to create a ticket in Partner Center.

## More information

*Payroll Extensions includes three components: Deductions in Arrears, Overtime Rate Manager, and Payroll Integration to Payables (PIP).
