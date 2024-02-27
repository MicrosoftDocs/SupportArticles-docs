---
title: Registry values for Process Control parameters
description: Describes the parameters for the Process Control service components.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:applications, csstroubleshoot
---
# Registry values for Process Control parameters

This article describes the parameters for the Process Control service components.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 296930

## Summary

You can manually manipulate the Process Control service registry values for administrative functions or for troubleshooting purposes, which are stored in the following registry key:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ProcCon\Parameters`

The following components are described in this article:

- Process Alias Rules
- Process Execution Rules
- Process Group Execution Rules

## Default Process Execution Rule string

DfltMgmt:REG_SZ:{F0x0,A0x0,P0x8,L0x0,H0x0,S0x0,T0x0,U0x0,C0x0,M0x0,N0x0}

Where:

- F0x0 is the default setting for indication of whether or not this process execution rule is managed by a group or not. If the rule is under group management, this value appears as F0X800 in all cases. When this value is set, the text value name of the group under which this process is managed is written to the following registry key:

  - `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ProcCon\Parameters\ProcessRules\your_process_execution_rule_alias_name\`
  - MemberOf:
  - REG_SZ:
  - your_process_group_execution_rule_name

- A0x0 is the default setting for processor affinity. The 0 value indicates that no affinities are applied, and the process can run on any available processor in the system. All values are in hexadecimal format. To manually configure these values, you must write code that uses API calls, and this process is beyond the scope of this article.
- P0x8 is the default value for process priority. The default is normal priority. The following priority/value map lists the available settings, and all values are in hexadecimal:
  - P0x18 Real Time
  - P0xd High
  - P0xa Above Normal
  - P0x8 Normal
  - P0x6 Below Normal
  - P0x4 Low
- L0x0 is the default setting for a process execution rule's minimum working set. Values are in decimal kilobytes that are converted to hexadecimal. For example, you might set the GUI interface to 10,000, which in decimal would be 10,240,000. The corresponding registry entry value would be L0x9c4000. Any entry in the GUI interface that is equal to or greater than 9999999999 (or 9.31+TB) causes a "The minimum working set must be greater than 0 but less than the maximum working set." error message to occur. Similarly, a hexadecimal registry entry that is equal to or greater than 0x2540BE3FF results in the same error message the next time the GUI interface is used.
- H0x0 is the default setting for a process execution rule's maximum working set. Values are in decimal kilobytes that are converted to hexadecimal. For example, you might set the GUI interface to 10,000 which in decimal would be 10,240,000. The corresponding registry entry value would be L0x9c4000.
- S0x0, T0x0, U0x0, C0x0, M0x0, N0x0 are currently unused in process execution rule descriptions.

## Default Process Group Execution Rule string

DfltMgmt:REG_SZ:{F0x0,A0x0,P0x8,L0x0,H0x0,S0x5,T0x0,U0x0,C0x0,M0x0,N0x0}

Where:

- F0x0 involves several different configurations of various process control parameters. To manually configure this value, you must write code that uses API calls, and this process is beyond the scope of this article.
- A0x0, P0x8, L0x0, H0x0. Values for these parameters are computed in the same manner as in the preceding "Default Process Execution Rule String" section of this article.
- S0x5 is the default scheduling class value. The available values are from 0 to 9. The valid values are S0x0, S0x1, S0x2, ....... S0x9.
- T0x0 is the default value for "Apply per process user time limit:". This value is specified in the GUI in the format hh:mm:ss. The registry values are in a hexadecimal format that is computed by the operating system. To obtain the hexadecimal conversions, you must create a code-based method. The following code is example code that, when compiled, will perform the conversion and output the required hexadecimal value when it is given input in the format 0:00:00.

    Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.

    For more information about the support options that are available and about how to contact Microsoft, visit the following Microsoft Web site:

    [Global Customer Service phone numbers](https://support.microsoft.com/help/4051701)  

    Output:

    ```console
    C:\Projects\timecv\Release>timecv
    Enter time in the following format (hh:mm:ss:) ->2:30:00
    
    Registry value should be 0x14f46b0400
    ```

    Source:

    ```c
    #include "stdio.h"
    
    int main(int argc, char* argv[])
    {
        __int64i64=0;
        intiHour=0,iMinute=0,iSecond=0;
        
        printf ("Enter time in the following format (hh:mm:ss:) ->");
        scanf ("%i:%i:%i", &iHour,&iMinute,&iSecond);
        
        iHour *= 3600;
        iMinute *= 60;
        
        i64=(iHour+iMinute+iSecond);
        i64*=10000000;
        
        printf ("\nRegistry value should be 0x%I64x\n", i64);
        return 0;
    }
    ```

- U0x0 is the default value for "Apply process group user time limit:". This value is specified and computed in the same fashion as those in the preceding T0x0 description.
- C0x0 is the default value for "Apply process count limit". These values are created by simple conversion of the decimal input values converted to hexadecimal. The maximum number in decimal is over one billion processes.
- M0x0 is the default value for process committed memory limits. This value is a hexadecimal conversion of the desired value in kilobytes. For example, if the value 10,000 were to be used, in the GUI the registry value would be (10,000*1,024) or 10,240,000 converted to a hexadecimal value of 0x9c4000.
- N0x0 is the default value for process group committed memory limits and is computed in the same way as the preceding process committed memory limits.

> [!NOTE]
> Process group execution rules offer four advanced settings options:
>
> - End process group when no process in the group.
> - Die on unhandled exceptions.
> - Silent breakaway.
> - Breakaway OK.

These items cannot be manually edited in the registry. These values must be manipulated through API programming calls that are not described in this article.
