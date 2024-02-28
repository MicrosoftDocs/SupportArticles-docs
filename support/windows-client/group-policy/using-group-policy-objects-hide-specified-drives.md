---
title: Using Group Policy Objects to hide specified drives
description: Provides some information about using Group Policy Objects to hide specified drives.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, davidg
ms.custom: sap:managing-removable-devices-through-group-policy, csstroubleshoot
---
# Using Group Policy Objects to hide specified drives

This article provides some information about using Group Policy Objects to hide specified drives.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 231289

## Summary

With Group Policy Objects in Windows, there is a "Hide these specified drives in My Computer" option that lets you hide specific drives. However, it may be necessary to hide only certain drive, but retain access to others.

There are seven default options for restricting access to drives. You can add other restrictions by modifying the System.adm file for the default domain policy or any custom Group Policy Object (GPO). The seven default selections are:

- Restrict A, B, C and D drives only
- Restrict A, B and C drives only
- Restrict A and B drives only
- Restrict all drives
- Restrict C drive only
- Restrict D drive only
- Do not restrict drives

Microsoft does not recommend to change the System.adm file, but instead to create a new .adm file and import this .adm into the GPO. The reason is that if you apply changes to the system.adm file, these changes might get overwritten if Microsoft releases a new version of the system.adm file in a Service Pack.

## More Information

The default location of the System.adm file for a default domain policy is:

%SystemRoot%\\Sysvol\\Sysvol\\\<YourDomainName>\\Policies\\\{31B2F340-016D-11D2-945F-00C04FB984F9}\\Adm\\System.adm  

The contents of these folders are replicated throughout a domain by the File Replication service (FRS).

> [!Note]
> The Adm folder and its contents are not populated until the default domain policy is loaded for the first time.

To make changes to this policy for one of the seven default values:

1. Start the Microsoft Management Console. On the Console menu, click **Add/Remove Snap-in**.
2. Add the Group Policy snap-in for the default domain policy. To do this, click **Browse** when you are prompted to select a Group Policy Object (GPO). The default GPO is Local Computer. You can also add GPOs for other domain partitions (specifically, Organizational Units).
3. Open the following sections: **User Configuration**, **Administrative Templates**, **Windows Components**, and **Windows Explorer**.
4. Click **Hide these specified drives in My Computer**.
5. Click to select the **Hide these specified drives in My Computer** check box.
6. Click the appropriate option in the drop-down box.

These settings remove the icons representing the selected hard disks from My Computer, Windows Explorer, and My Network Places. Also, these drives do not appear in the Open dialog box of any programs.

This policy is designed to protect certain drives, including the floppy disk drive, from misuse. It can also be used to direct users to save their work to certain drives.

To use this policy, select a drive or combination of drives in the drop-down box. To display all drives (hide none), disable this policy or click the **Do not restrict drives** option.

This policy does not prevent users from using other programs to gain access to local and network drives or prevent them from viewing and changing drive characteristics by using the Disk Management snap-in.

The default values are not the only values that you can use. By editing the System.adm file, you can add your own custom values. This is the portion of the System.adm to be modified:

```output
POLICY !!NoDrives  
     EXPLAIN !!NoDrives_Help  
        PART !!NoDrivesDropdown DROPDOWNLIST NOSORT REQUIRED  
           VALUENAME "NoDrives"  
            ITEMLIST  
                  NAME !!ABOnly VALUE NUMERIC 3  
                  NAME !!COnly VALUE NUMERIC 4  
                  NAME !!DOnly VALUE NUMERIC 8  
                  NAME !!ABConly VALUE NUMERIC 7  
                  NAME !!ABCDOnly VALUE NUMERIC 15  
                  NAME !!ALLDrives VALUE NUMERIC 67108863  
                  ;low 26 bits on (1 bit per drive)  
                  NAME !!RestNoDrives VALUE NUMERIC 0 (Default)  
            END ITEMLIST  
        END PART  
      END POLICY

[strings]  
ABCDOnly="Restrict A, B, C and D drives only"  
ABConly="Restrict A, B and C drives only"  
ABOnly="Restrict A and B drives only"  
ALLDrives="Restrict all drives"  
COnly="Restrict C drive only"  
DOnly="Restrict D drive only"  
RestNoDrives="Do not restrict drives"  
```

The [strings] section represents substitutions of the actual values in the drop-down box.

This policy displays only specified drives on the client computer. The registry key that this policy affects uses a decimal number that corresponds to a 26-bit binary string, with each bit representing a drive letter:

11111111111111111111111111
ZYXWVUTSRQPONMLKJIHGFEDCBA

This configuration corresponds to 67108863 in decimal and hides all drives. If you want to hide drive C, make the third-lowest bit a 1, and then convert the binary string to decimal.

It is not necessary to create an option to show all drives, because clearing the check box deletes the "NoDrives" entry entirely, and all drives are automatically shown.

If you want to configure this policy to show a different combination of drives, create the appropriate binary string, convert to decimal, and add a new entry to the ITEMLIST section with a corresponding [strings] entry. For example, to hide drives L, M, N, and O, create the following string

00000000000111100000000000
ZYXWVUTSRQPONMLKJIHGFEDCBA

and convert to decimal. This binary string converts to 30720 in decimal. Add this line to the [strings] section in the System.adm file:

LMNO_Only="Restrict L, M, N and O drives only"

Add this entry in the ITEMLIST section above and save the System.adm file.

NAME !!LMNO_Only VALUE NUMERIC 30720

This creates an eighth entry in the drop-down box to hide drives L, M, N, and O only. Use this method to include more values in the drop-down box. The modified section of the System.adm file appears as follows:

```output
POLICY !!NoDrives  
     EXPLAIN !!NoDrives_Help  
        PART !!NoDrivesDropdown DROPDOWNLIST NOSORT REQUIRED  
           VALUENAME "NoDrives"  
            ITEMLIST  
                  NAME !!ABOnly VALUE NUMERIC 3  
                  NAME !!COnly VALUE NUMERIC 4  
                  NAME !!DOnly VALUE NUMERIC 8  
                  NAME !!ABConly VALUE NUMERIC 7  
                  NAME !!ABCDOnly VALUE NUMERIC 15  
                  NAME !!ALLDrives VALUE NUMERIC 67108863  
                  ;low 26 bits on (1 bit per drive)  
                  NAME !!RestNoDrives VALUE NUMERIC 0 (Default)  
                              NAME !!LMNO_Only VALUE NUMERIC 30720  
            END ITEMLIST
       END PART  
     END POLICY

[strings]  
ABCDOnly="Restrict A, B, C and D drives only"  
ABConly="Restrict A, B and C drives only"  
ABOnly="Restrict A and B drives only"  
ALLDrives="Restrict all drives"  
COnly="Restrict C drive only"  
DOnly="Restrict D drive only"  
RestNoDrives="Do not restrict drives"  
LMNO_Only="Restrict L, M, N and O drives only"  
```

This [strings] section represents substitutions of the actual values in the drop-down box.
