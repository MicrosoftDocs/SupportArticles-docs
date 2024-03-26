---
title: Connection to a network document is lost
description: Fixes a problem in Office 2010 in which you lose connection to a network document after the computer resumes from standby.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: antoa, alexze
appliesto: 
  - Office 2010
ms.date: 03/31/2022
---

# Connection to a network document is lost in the 2007 Office system or in Office 2010 after the computer resumes from standby

## Symptoms

Consider the following scenario. You access a Microsoft Office 2010 document that is located on a network share. Your computer enters standby. Then, you resume the computer from standby. In this scenario, you receive an error message. Error messages resemble those below. 

```adoc
Word error: Word cannot establish a network connection with this document after the system resumed from suspend mode. Save the document into a different file to keep any changes.

Excel error: The file '<file name>' may have been changed by another user since you last saved it. In that case, what do you want to do? Save a copy or Overwrite changes.

PowerPoint error: The file you were working with was modified during suspend mode, and the original version is no longer available. <file path and name.ppt> must be re-saved.
```

Additionally, you cannot update the document and then save it back to the network share when the network location is available.

## Resolution

### Registry key information

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

### Steps to resolve this issue in Office 2010

Install hotfix package 2413659, and then configure the NetworkAvailableTimeInSeconds registry entry to enable the hotfix package. To do this, follow these steps:

1. Install the hotfix package that is described in the following Knowledge Base article:

   [2413659 ](https://support.microsoft.com/help/2413659) Description of the Word 2010 hotfix package (Mso-x-none.msp, Word-x-none.msp): October 26, 2010   
2. Configure the NetworkAvailableTimeInSeconds registry entry. 

   To do this, follow these steps:
   1. Click **Start**, click **Run**, type regeditin the **Open** box, and then click **OK**.    
   2. Locate and then select the following registry subkey: **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Word\Options**   
   3. On the **Edit** menu, point to **New**, and then click **Dword Value**.
   4. Type NetworkAvailableTimeInSeconds, and then press Enter.   
   5. Right-click **NetworkAvailableTimeInSeconds**, and then click **Modify**.   
   6. In the **Value data** box, click **Decimal**, type a number value, and then click **OK**.

      **Note** This registry subkey sets the time, in seconds, that Word waits for the network to resume. For example, if you type 15 for the number value, Word waits 15 seconds for the network to resume. You might have to do some tests in your own environment to determine an appropriate value. You may have to try multiple numbers.

   7. Locate and then select the following registry subkey.
   
      **HKEY_CURRENT_USER\Software\Microsoft\office\14.0\common\Internet**
   8. Repeat step 2C through step 2F again. Reuse the same value that you used previously.   
   9. Exit Registry Editor.

If these steps do not resolve the issue, see the **Additional troubleshooting**section. 

## Additional troubleshooting 

If you continue to experience the issue after you apply the appropriate hotfix and configure the NetworkAvailableTimeInSeconds registry subkey, you may have to collect additional information to correctly enable the hotfix on your system.

To collect the additional information, follow these steps:

1. Click **Start**, click **Run**, type regeditin the **Open** box, and then click **OK**.    
2. Locate and then select the following registry subkey: 

   **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\TrustCenter**   
3. On the **Edit** menu, point to **New**, and then click **Dword Value**.   
4. Type EnableLogging, and then press Enter.   
5. Right-click **EnableLogging**, and then click **Modify**.   
6. In the **Value data** box, type **1**, and then click **OK**.
    
    **Note** This registry subkey creates a log file that can be found in the following folder:

    C:\Documents and Settings\username\Local Settings\Application Data\Microsoft\OFFICE\TCDiag

7. Exit Registry Editor.

8. Reproduce the problem.   
9. Locate and open the log file that is created.   
10. Analyze the file. To do this, follow these steps:
    1. Open the WDTCD.LOG file that is generated in step 6.   
    2. Search for the entry **HrBindShellPistm:**, and then note the error code such as, for example, 80070035.   
    3. Revert every pair of two digits from this error code by writing them down from right to left. For example, revert **80 07 00 35** to **35 00 07 80**.    
   
11. Click **Start**, click **Run**, type regeditin the **Open** box, and then click **OK**.    
12. Locate and then select the following registry subkey: 

    **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Internet**   
13. On the **Edit** menu, point to **New**, and then click **Binary Value**.   
14. Type ResumeErrorCodes, and then press Enter.   
15. Right-click **ResumeErrorCodes**, and then click **Modify**.   
16. In the **Value data** box, type the value that you retrieved from the log file in step 10C, and then click **OK**.   
17. In some cases, multiple, different error codes may be observed from step 9. In this case, convert all error codes as described in step 10C, and append them all serially to the ResumeErrorCodes registry entry.   
18. Exit Registry Editor.

    **NOTE**: To resolve the Word error, you may have to remove the NetworkAvailableTimeInSecondsentry added to: 
    
    **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Word\Options**   

### Did this fix the problem?

Check whether the problem is fixed. If the problem is fixed, you are finished with this section. If the problem is not fixed, you can [contact support](https://support.microsoft.com/contactus).   

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.
