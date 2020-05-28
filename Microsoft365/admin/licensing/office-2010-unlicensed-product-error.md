---
title: Unlicensed Product error when opening Office Professional Plus 2010
description: Describes that an Office Professional Plus 2010 user receives an "Unlicensed Product" message and many features are disabled in Office Professional Plus 2010 applications. Provides a resolution.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: office 365
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- Office Professional Plus 2010
---

# "Unlicensed Product" error when you open an Office Professional Plus 2010 application

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

For an Office 2013 version of this article, see [Unlicensed Product and activation errors in Office](https://support.office.com/article/Unlicensed-Product-and-activation-errors-in-Office-0d23d3c0-c19c-4b2f-9845-5344fedc4380). 

For an Office 2016 version of this article, see [Unlicensed Product and activation errors in Office](https://support.office.com/article/Unlicensed-Product-and-activation-errors-in-Office-0d23d3c0-c19c-4b2f-9845-5344fedc4380). 

## Problem 

When you open a Office Professional Plus 2010 application, many features are disabled. This problem occurs when your Office Professional Plus subscription expires and the application becomes unlicensed. 

Additionally, you may experience one of the following symptoms:

- When you click **File** in the Office Professional Plus 2010 application, and then you click **Help**, you receive the following message:

  **Product Activation required**   
- In the title bar of the Office Professional Plus 2010 application, you receive the following message:

  **Unlicensed Product**   
- After you sign in to activate Office Professional Plus 2010, you receive the following message:
  
  **No Subscription Found**   

## Cause 

This problem occurs if Office Professional Plus 2010 is no longer licensed.

## Solution 

To resolve this problem, use one or more of the following methods, as necessary.

### Method 1: Verify that the affected user is assigned an Office Professional Plus license on the Microsoft Online Portal

1. Sign in to the Office 365 Portal as an admin user.    
2. In the **Office 365 Admin Overview** section, click **Users**.    
3. Select the user who has the issue.    
4. Under **Assign Licenses**, verify that **Office Professional Plus** is selected.    
  
### Method 2: Reactivate Office by using your Office 365 Organization ID

 To have us fix this problem for you, go to the "Here's an easy fix" section. If you prefer to fix this problem manually, go to the "Let me fix it myself" section.

#### Here's an easy fix
 
To fix this problem automatically, open https://go.microsoft.com/?linkid=9843239. In the **File Download** dialog box, click **Run** or **Open**, and then follow the steps in the easy fix wizard. 
- This wizard may be in English only. However, the automatic fix also works for other language versions of Windows.    
- If you're not on the computer that has the problem, save the easy fix solution to a flash drive or a CD, and then run it on the computer that has the problem.    

#### Let me fix it myself   
 
1. Determine whether the computer has the 32-bit or 64-bit version of Office 2010 installed. To do this, open any Office 2010 program, click **File,** and then click **Help**. The Office version is displayed next to the **Version** number.   
2. Close all Office 2010 programs.    
3. Click **Start**, type cmd in the **Start Search** box, and then press Enter.    
4. At the command prompt, type one of the following commands, and then press Enter:  
   - If you're running 64-bit Windows with 32-bit Office:   
     ```powershell
     "%ProgramFiles(x86)%\Common Files\Microsoft Shared\OFFICE14\OSAUI.exe" /F
     ```
   - If you're running 32-bit Windows, or running 64-bit Office with 64-bit Windows:
     ```powershell
     "%ProgramFiles%\Common Files\Microsoft Shared\OFFICE14\OSAUI.exe" /F      
     ```
   
### Method 3: Verify the system clock settings

1. Make sure that the system date and time are set correctly. Use the [Official U.S. Time](https://nist.time.gov) resource to verify that the system clock is correct.    
2. Make sure that the time zone is set correctly.    
3. Make sure that the Daylight Saving Time setting is configured correctly.    
4. Click **Start**, type cmd in the **Start Search** box, and then press Enter.    
5. At the command prompt, type one of the following commands, and then press Enter:  
   - If you're running 64-bit Windows with 32-bit Office:  
   
     ```powershell
     "%ProgramFiles(x86)%\Common Files\Microsoft Shared\OFFICE14\OSAUI.exe" /K
     ```

   - If you're running 32-bit Windows, or running 64-bit Office with 64-bit Windows:
     ```powershell
     "%ProgramFiles%\Common Files\Microsoft Shared\OFFICE14\OSAUI.exe" /K      
     ```
  
### Method 4: Uninstall and reinstall Office 2010

1. Uninstall Office 2010 by using a Microsoft easy fix.    
1. After the easy fix is complete, sign in to the Microsoft Online Portal to reinstall Office 2010.    

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).