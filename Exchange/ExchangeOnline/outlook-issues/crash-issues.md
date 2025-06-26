---
title: Outlook crash or stop responding when used with Microsoft 365
description: Describes how to troubleshoot issues that trigger Outlook crashes when you use Outlook in a Microsoft 365 environment.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
ms.custom: 
  - sap:Client Connectivity
  - Exchange Online
  - CSSTroubleshoot
  - SaRA-OutlookWontStart
  - OutlookAdvDiagnostics
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
ms.date: 01/24/2024
ms.reviewer: v-six
---
# How to troubleshoot issues that cause Outlook to crash or stop responding when used with Microsoft 365

## Introduction

This article describes how to troubleshoot the following kinds of issues in Microsoft Outlook when it's used together with Microsoft 365:

- Outlook stops responding (hangs).
- Outlook crashes even though you aren't actively using it.
- Outlook crashes when you start it.
  
## Procedure

To help troubleshoot Outlook issues in a Microsoft 365 environment, follow these steps.

### Step 1: Investigate possible issues caused by add-ins

1. Exit Outlook.
2. Open a **Run** dialog box. To do this, use one of the following procedures, as appropriate to your version of Windows:

   - If you're running Windows 10, Windows 8.1, or Windows 8, press the Windows logo key+R.
   - If you're running Windows 7, click **Start**, type **Run** in the Search box, and then click **Run**.
3. Type **Outlook /safe**, and then click **OK**.
4. If the issue is fixed, click **Options** on the **File** menu, and then click **Add-Ins**.
5. Select **COM Add-ins**, and then click **Go**.
6. Click to clear all the check boxes in the list, and then click **OK**.
7. Restart Outlook. If the issue doesn't occur, start adding the add-ins one at a time until the issue occurs.

### Step 2: Repair Office

1. Open Control Panel, and then click **Uninstall a program**.
2. In the list of installed programs, right-click the entry for your Office installation, and then click **Change**, and then click **Online Repair**.

### Step 3: Run Outlook Diagnostics

1. Run the [Classic Outlook Connectivity troubleshooter](https://aka.ms/SaRA-OutlookDisconnect-sarahome) to fix the issues.

    > [!NOTE]
    >
    > - The troubleshooter doesn't work in new Outlook for Windows.
    > - To run the troubleshooter, make sure that you're using the same Windows device that classic Outlook is installed on. Additionally, make sure that your device is running Windows 10 or a later version.
2. If the tool doesn't resolve the issue, use the [Microsoft Support and Recovery Assistant](https://support.microsoft.com/office/about-the-microsoft-support-and-recovery-assistant-e90bb691-c2a7-4697-a94f-88836856c72f#ID0ED6=Outlook).
3. On the first screen, select **Outlook**, and then select **Next**.
4. Select any of the following options, as appropriate, and then select **Next**:
   - **Outlook keeps hanging or freezing**
   - **Outlook keeps crashing with a message "Microsoft Outlook has stopped working".**

   SaRA runs some diagnostic checks, and returns possible solutions for you to use to try to fix Outlook connectivity issues.

### Step 4: Create a new Outlook profile

> [!NOTE]
> If you ran SaRA in Step 3, and you created a new profile, you can skip all of Step 4.

1. Open Control Panel, and then click **Mail**.
2. Click **Show Profiles**.
3. Select the profile that you want to remove, and then click **Remove**.

    > [!IMPORTANT]
    > Removing the profile also removes associated data files. If you're not sure whether the data files are backed up or stored on a server, do not remove the profile. Instead, go to step 4.
4. Click **Add**.
5. In the **Profile Name** box, type a name for the new profile.
6. Specify the user name, the primary SMTP address, and the password. Then, click **Next**.
7. You may receive the following message:
    > Allow this website to configure **alias@domain** server settings?  In this message, click to select the **Don't ask me about this website again** check box, and then click **Allow**.
8. When you're prompted, enter your logon credentials, and then click **OK**.
9. When Setup is finished, click **Finish**.

### Step 5: Run the Classic Outlook Advanced Diagnostics troubleshooter

The Classic Outlook Advanced Diagnostis troubleshooter generates a detailed classic Outlook configuration report.

> [!NOTE]
>
> - The troubleshooter doesn't work in new Outlook for Windows.
> - To run the troubleshooter, make sure that you're using the same Windows device that classic Outlook is installed on. Additionally, make sure that your device is running Windows 10 or a later version.

To run the troubleshooter, follow these steps:

1. Select the following button to start the troubleshooter.

   > [!div class="nextstepaction"]
   > [Classic Outlook Advanced Diagnostics troubleshooter](https://aka.ms/SaRA-OutlookAdvDiagExpExp-sarahome)
   If you receive a pop-up window that displays "This site is trying to open Get Help.", select **Open**.
1. Follow the instructions in the Get Help app to run the troubleshooter.

After the troubleshooter finishes, it displays the results and provides additional information about how to resolve the issue.

## More information

For more info about command-line switches that are used together with Outlook, go to [Command-line switches for Microsoft Office products](https://office.microsoft.com/redir/ha102606406.aspx).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).
