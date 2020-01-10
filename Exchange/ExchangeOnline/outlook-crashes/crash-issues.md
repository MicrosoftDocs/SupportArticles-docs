---
title: Outlook crash or stop responding when used with Office 365
description: Describes how to troubleshoot issues that trigger Outlook crashes when you use Outlook in an Office 365 environment.
author: simonxjx
audience: ITPro
ms.service: exchange-online
ms.topic: article
ms.author: v-six
manager: dcscontentpm
localization_priority: Normal
ms.custom: CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- Exchange Online
- Outlook 2019
- Outlook 2016
- Outlook 2013
- Microsoft Outlook 2010
---

# How to troubleshoot issues that cause Outlook to crash or stop responding when used with Office 365

## Introduction 

This article describes how to troubleshoot the following kinds of issues in Microsoft Outlook when it's used together with Office 365:

- Outlook stops responding (hangs).    
- Outlook crashes even though you aren't actively using it.    
- Outlook crashes when you start it.    
  
## Procedure 

To help troubleshoot Outlook issues in an Office 365 environment, follow these steps.

### Step 1: Investigate possible issues caused by add-ins

1. Exit Outlook.    
2. Open a **Run** dialog box. To do this, use one of the following procedures, as appropriate to your version of Windows:

   - If you're running Windows 10, Windows 8.1, or Windows 8, press the Windows logo key+R.    
   - If you're running Windows 7, click **Start**, type **Run** in the Search box, and then click **Run**.    
3. Type **Outlook /safe**, and then click **OK**.    
4. If the issue is fixed, click **Options** on the **File** menu, and then click **Add-Ins**.    
5. Select **COM Add-ins**, and then click **Go**.    
6. Click to clear all the check boxes in the list, and then click **OK**.    
7. Restart Outlook. If the issue doesn't occur, start adding the add-ins one at a time until the issue occurs.

### Step 2: Repair Office

1. Open Control Panel, and then click **Uninstall a program**.    
2. In the list of installed programs, right-click the entry for your Office installation, and then click **Change**, and then click **Online Repair**. 

### Step 3: Run Outlook Diagnostics

1. Run the [Outlook won't start](https://aka.ms/SaRA-OutlookWontStart) automated diagnostics to fix the issues. 

    > [!NOTE]
    > Click **Run** when you're prompted by your browser.    
2. If the tool doesn't resolve the issue, go to Windows or Look to start **Microsoft Support and Recovery Assistant for Office 365 **(SaRA).     
3. On the first screen, select **Outlook**, and then select **Next**.     
4. Select any of the following options, as appropriate, and then select **Next**:   
   - **Outlook keeps hanging or freezing**    
   - **Outlook keeps crashing with a message "Microsoft Outlook has stopped working.**"    
 
   SaRA runs some diagnostic checks, and returns possible solutions for you to use to try to fix Outlook connectivity issues.     
 
### Step 4: Create a new Outlook profile

> [!NOTE]
> If you ran SaRA in Step 3, and you created a new profile, you can skip all of Step 4. 
 
1. Open Control Panel, and then click **Mail**.    
2. Click **Show Profiles**.    
3. Select the profile that you want to remove, and then click **Remove**.    

    > [!IMPORTANT]
    > Removing the profile also removes associated data files. If you're not sure whether the data files are backed up or stored on a server, do not remove the profile. Instead, go to step 4.         
4. Click **Add**.    
5. In the **Profile Name** box, type a name for the new profile.    
6. Specify the user name, the primary SMTP address, and the password. Then, click **Next**.    
7. You may receive the following message:  Allow this website to configure **alias@domain** server settings?  In this message, click to select the **Don't ask me about this website again** check box, and then click **Allow**.    
8. When you're prompted, enter your logon credentials, and then click **OK**.    
9. When Setup is finished, click **Finish**.

### Step 5: Run SaRA Advanced Diagnostics before you contact Support

This step creates detailed information about your Outlook configuration and provides solutions for any known issues that are detected. It also gives you the option to upload your results to Microsoft so that a Support engineer can review them before you make a Support call. 
 
1. Click [Outlook Advanced Diagnostics](https://aka.ms/SaRA-OutlookAdvDiagnostics).     
2. Click **Run** when you are prompted by your browser.
 
## More information

For more info about command-line switches that are used together with Outlook, go to [Command-line switches for Microsoft Office products](https://office.microsoft.com/redir/ha102606406.aspx).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).