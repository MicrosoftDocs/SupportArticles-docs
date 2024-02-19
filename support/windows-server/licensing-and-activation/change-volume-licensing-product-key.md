---
title: Change the Volume Licensing product key
description: Describes how to change the product key for a Volume Licensing installation of Windows XP.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:windows-volume-activation, csstroubleshoot
---
# How to change the Volume Licensing product key

This article describes how to change the Volume Licensing product key.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 328874

## Introduction

> [!WARNING]
> The steps in the article are effective only on Volume License media. If you try these steps on OEM media or on retail media, you will not change the product key.  

When you install Windows XP or Windows Server 2003, the media must match the product key. That is, the channel (MSDN, retail, OEM, Volume License, and so on), the SKU (Windows XP Professional, Windows XP Home Edition, and so on), and the language (English, French, and so on) must match between the product key and the media. It is necessary so that you can successfully enter the product key. If the installation media does not match the product key, you receive the following error message:  
>Product Key is invalid.  

If you use a "leaked" product key (a product key that is known to be available to the public) to deploy Windows XP across multiple computers (a Volume Licensing installation), you might be unable to install Windows XP Service Pack 1 (SP1) and later versions of Windows XP, or automatically obtain updates from the Windows Update Web site. For example, you might receive the following error message when you install Windows XP SP1 and later versions of Windows XP:  
>The Product Key used to install Windows is invalid. Please contact your system administrator or retailer immediately to obtain a valid Product Key. You may also contact Microsoft Corporation's Anti-Piracy Team by emailing `piracy@microsoft.com` if you think you have purchased pirated Microsoft software. Please be assured that any personal information you send to the Microsoft Anti-Piracy Team will be kept in strict confidence.  

This article is intended for an advanced computer user. You might find it easier to follow the steps if you print this article first.

## More information

### Prerequisites

You must have a valid product key before you can use the information in this article. To obtain a valid product key, click the following link to contact the Microsoft Volume Licensing Service Center:  
[https://www.microsoft.com/licensing/servicecenter/home.aspx](https://www.microsoft.com/licensing/servicecenter/home.aspx)  

### Steps to change the volume licensing product key

This article describes two methods for how to change the Windows XP product key after a Volume Licensing installation to resolve the issue. One method uses the Windows Activation Wizard graphical user interface (GUI) and the other method uses a Windows Management Instrumentation (WMI) script. The Activation Wizard method is easier. However, if you must change the product key for multiple computers, the script method is more suitable.

#### Method 1: Use the Activation Wizard

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
[322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  
If you only have a few volume licensing product keys to change, you can use the Activation Wizard.

> [!NOTE]
> We recommend that you run System Restore to create a new restore point before you follow these steps.

##### Deactivate Windows

1. Click **Start**, and then click **Run**.
2. In the **Open** box, type regedit, and then click **OK**.
3. In the navigation pane, locate and then click the following registry key: `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\WPAEvents` 

4. In the topic pane, right-click **OOBETimer**, and then click **Modify**.
5. Change at least one digit of this value to deactivate Windows.

##### Reactivate Windows and add new product key

1. Click **Start**, and then click **Run**.
2. In the **Open** box, type the following command, and then click **OK**.  
`%systemroot%\system32\oobe\msoobe.exe /a`  

3. Click **Yes, I want to telephone a customer service representative to activate Windows**, and then click **Next**.
4. Click **Change Product key**.
5. Type the new product key in the **New key** boxes, and then click **Update**.

    If you are returned to the previous window, click **Remind me later**, and then restart the computer.
6. Repeat steps 1 and 2 to verify that Windows is activated. You receive the following message: Windows is already activated. Click OK to exit.

7. Click **OK**.
8. Install Windows XP Service Pack 1a or a later version of Windows XP.  

If you cannot restart Windows after you install Windows XP SP1 or a later version of Windows XP, try the following steps:  

1. Restart your computer and start pressing F8 until you see the Windows Advanced Options menu.
2. Select **Last Known Good Configuration** from the menu and press ENTER. This option starts Windows by using a previous good configuration.
3. Repeat steps 1 through 8 under "Reactivate Windows and add new product key."  

If you can install SP1 or a later version of Windows XP and you can restart Windows, you have resolved the issue. If the issue has not been resolved, try method 2 or see the "Next Steps" section for more troubleshooting resources.

#### Method 2: Use a script

If you must change the product key for multiple computers, we recommend this method. You can create a WMI script that changes the volume licensing product key, and then deploy this script in a startup script.

The sample ChangeVLKey2600.vbs script and the sample ChangeVLKeySP1 script that are described in this section use the new volume licensing key that you want to enter as a single argument. It is in a five-part alphanumeric form.

We recommend that you use the ChangeVLKey2600.vbs script on Windows XP-based computers that are not running Windows XP SP1 and later versions of Windows XP and that you use the ChangeVLKeySP1.vbs script on Windows XP-based computers that are running Windows XP SP1 and later versions of Windows XP. These scripts perform the following functions:  

- They remove the hyphen characters (-) from the five-part alphanumeric product key.
- They create an instance of the win32_WindowsProductActivation class.
- They call the SetProductKey method with the new volume licensing product key. You can create a batch file or a cmd file that uses either of the following sample scripts, together with the new product key as an argument.  

You can deploy it as part of a startup script or run it from the command line to change the product key on a single computer.

##### Examples

For more information about how to script the product key, visit the following Microsoft Web site:  
[https://technet.microsoft.com/library/bb457096.aspx](https://technet.microsoft.com/library/bb457096.aspx)  

##### ChangeVLKeySP1.vbs

```vbscript
'  
' WMI Script - ChangeVLKey.vbs  
'  
' This script changes the product key on the computer  
'  
'***************************************************************************  
ON ERROR RESUME NEXT  

if Wscript.arguments.count<1 then  
   Wscript.echo "Script can't run without VolumeProductKey argument"  
   Wscript.echo "Correct usage: Cscript ChangeVLKey.vbs ABCDE-FGHIJ-KLMNO-PRSTU-WYQZX"  
   Wscript.quit  
end if  

Dim VOL_PROD_KEY  
VOL_PROD_KEY = Wscript.arguments.Item(0)  
VOL_PROD_KEY = Replace(VOL_PROD_KEY,"-","")'remove hyphens if any  

for each Obj in GetObject("winmgmts:{impersonationLevel=impersonate}").InstancesOf ("win32_WindowsProductActivation")  
   result = Obj.SetProductKey (VOL_PROD_KEY)  
   if err <> 0 then  
      WScript.Echo Err.Description, "0x" & Hex(Err.Number)  
      Err.Clear  
   end if  
Next
```

##### ChangeVLKey2600.vbs

```vbscript
'  
' WMI Script - ChangeVLKey.vbs  
'  
' This script changes the product key on the computer  
'  
'***************************************************************************  
ON ERROR RESUME NEXT  
if Wscript.arguments.count<1 then  
   Wscript.echo "Script can't run without VolumeProductKey argument"  
   Wscript.echo "Correct usage: Cscript ChangeVLKey.vbs ABCDE-FGHIJ-KLMNO-PRSTU-WYQZX"  
   Wscript.quit  
end if  

Dim VOL_PROD_KEY  
VOL_PROD_KEY = Wscript.arguments.Item(0)  
VOL_PROD_KEY = Replace(VOL_PROD_KEY,"-","")'remove hyphens if any  
Dim WshShell  
Set WshShell = WScript.CreateObject("WScript.Shell")  
WshShell.RegDelete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\WPAEvents\OOBETimer" 'delete OOBETimer registry value  
for each Obj in GetObject("winmgmts:{impersonationLevel=impersonate}").InstancesOf ("win32_WindowsProductActivation")  

   result = Obj.SetProductKey (VOL_PROD_KEY)  
   if err <> 0 then  
      WScript.Echo Err.Description, "0x" & Hex(Err.Number)  
      Err.Clear  
   end if  

Next
```

The following example shows how to use the ChangeVLKeySP1.vbs script from a command line:  

1. Click **Start**, and then click **Run**.
2. In the **Open** box, type the following command, where **AB123-123AB-AB123-123AB-AB123** is the new product key that you want to use, and then click **OK**:  
    c:\changevlkeysp1.vbs **ab123-123ab-ab123-123ab-ab123**  

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
