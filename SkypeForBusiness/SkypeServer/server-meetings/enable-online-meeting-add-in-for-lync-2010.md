---
title: How to enable the Online Meeting Add-in for Microsoft Lync 2010 in Outlook
description: Describes how to enable the Online Meeting Add-in for Microsoft Lync 2010 in Outlook 2010.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skypeforbusiness-powershell
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
-  Lync 2010
---

# How to enable the Online Meeting Add-in for Microsoft Lync 2010 in Outlook

## Summary

After you install the Online Meeting Add-in for Microsoft Lync 2010 in Microsoft Office Outlook 2010, the Conferencing menu may not appear in Outlook. If this happens, you can manually enable the Online Meeting Add-in for Microsoft Lync 2010 in Outlook, and then view the registry to make sure that the Online Meeting Add-in for Microsoft Lync 2010 is enabled in Outlook.

### How to enable the Online Meeting Add-in for Microsoft Lync 2010

#### Fix it for me

To [enable the Online Meeting Add-in for Lync 2010](https://download.microsoft.com/download/C/7/7/C7728197-260C-4D35-8AC6-B655BBAFE33F/MicrosoftEasyFix50760.msi) automatically, click the **Fix it **button or link. Then click **Run** in the **File Download** dialog box, and follow the steps in the **Fix it** wizard.

> [!NOTE]
> - This wizard may be in English only, but the automatic fix also works for other language versions of Windows.    
> - If you are not on the computer that has the problem, save the Fix it solution to a flash drive or a CD and then run it on the computer that has the problem.   

Then, go to the "Did this fix the problem?" section.

#### Let me fix it myself

To manually enable the Online Meeting Add-in for Lync 2010 in Outlook 2010, follow these steps: 

1. Start Outlook 2010.   
2. On the File menu, click Options. The screen shot for this step is listed below.

    ![The screen shot for this step ](https://support.microsoft.com/Library/Images/2702391.png)   
3. In the navigation pane, click **Add-Ins**. The screen shot for this step is listed below.

    ![The screen shot for this step ](https://support.microsoft.com/Library/Images/2714404.png)   
4. In the Manage menu, click COM Add-ins, and then click Go. The screen shot for this step is listed below.

    ![The screen shot for this step ](https://support.microsoft.com/Library/Images/2714405.png)   
5. In the COM Add-Ins dialog box, select the Online Meeting Add-in for Microsoft Lync 2010check box, and then click OK. The screen shot for this step is listed below.

    ![The screen shot for this step ](https://support.microsoft.com/Library/Images/2714406.png)   

    > [!NOTE]
    > If you receive the message "The add-in is installed for all users of the computer, and can only be connected or disconnected by an administrator" during step 5, make sure that you are signed in to the local computer by using an administrator account.

### Examine the registry to determine whether the Online Meeting Add-in for Lync 2010 is enabled

To do this, follow these steps:

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:
> 
> [322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows

32-bit Windows client with Microsoft Office 2010 32-bit or 64-bit Windows client with Microsoft Office 2010 64-bit

1. Press the Windows function key and search for regedit, and then click **OK**.   
2. In Registry Editor, locate the following registry subkey:

    **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\Outlook\Addins\UcAddin.UCAddin.1**

3. In the details pane, double-click LoadBehavior. If the value is 3 in the Value data box, the Online Meeting Add-in for Microsoft Lync 2010 is enabled.   

64-bit Windows client with Microsoft Office 2010 32-bit

1. Press the Windows function key and search for regedit, and then click **OK**.   
2. In Registry Editor, locate the following registry subkey:

    **HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\Outlook\Addins\UCAddin.UCAddin.1**

3. In the details pane, double-click LoadBehavior. If the value is 3 in the Value data box, the Online Meeting Add-in for Microsoft Lync 2010 is enabled.   

#### Did this fix the problem?

Check whether the problem is fixed. If the problem is fixed, you are finished with this section. If the problem is not fixed, you can [contact support](https://support.microsoft.com/contactus/).

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
