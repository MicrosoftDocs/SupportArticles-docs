---
title: Error when configuring CRM for Outlook
description: Describes a solution to an error that occurs when you configure CRM for Outlook.
ms.reviewer: debrau, chanson
ms.topic: troubleshooting
ms.date: 
---
# We can't connect to your CRM server when configuring Microsoft Dynamics CRM for Microsoft Office Outlook

This article provides a solution to an error that occurs when you configure Microsoft Dynamics CRM for Microsoft Office Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2013  
_Original KB number:_ &nbsp; 2997754

## Symptoms

When attempting to configure Microsoft Dynamics CRM for Microsoft Office Outlook, you receive the following error:

> "We can't connect to your CRM server. Ensure that your date and time settings are correct on your computer."

## Cause

Your computer's date/time is out of sync with the server by more than 5 minutes.

## Resolution

To fix this issue, follow these steps:

1. Exit the CRM Configuration Wizard.
2. Change the operating system date and time. To do it, use one of the following methods.

### Method 1: Manually change the operating system time  

> [!NOTE]
> The following steps are for Windows 7 or Windows Server 2008 operating systems. To change the date and time in Windows XP manually, refer to the Windows XP Help manual.

1. Select **Start**, select **Control Panel**, select **Clock, Language, and Region**, and then select **Date and Time**.
2. In the **Date and Time** dialog box, select **Change date and time** to change the date and time settings. For example, select a date such as February 1, 2011 from the calendar, and change the time.
3. Select **OK**.
4. Select **Change time zone**, and then select your time zone.
5. Select **OK**.

### Method 2: Configure the operating system time to synchronize with an Internet time server

1. Select **Start**, select **Control Panel**, select **Clock, Language, and Region**, and then select **Date and Time**.
2. In the **Date and Time** dialog box, select the **Internet Time** tab, and then select **Change Settings**.
3. Select the **Synchronize with an Internet Time Server** check box, select a time server, select **Update Now**, and then select **OK**.

### Method 3: Use a command to sync time with the domain if the computer is a member of a domain

1. Select **Start**, select **All Programs**, select **Accessories**, right-click **Command Prompt**, and then select **Run as Administrator**.
2. At the command prompt, type the following text, and then press **Enter**:  

    `net time [{\\ ComputerName | /domain[: DomainName ] | /rtsdomain[: DomainName ]}] [/set]`

    If you don't know the **ComputerName** or the **Domain Name**, try the following command:

    `net time /set`

    Then, type **Y** to finish the change:

    :::image type="content" source="media/error-when-configuring-crm-outlook/command-know-computername.png" alt-text="Example of syncing time with the domain.":::

    For more information about the net time command, see [Net Time](/previous-versions/windows/it-pro/windows-xp/bb490716(v=technet.10)).

### Method 4: Force a synchronization of the Network Time Protocol (NTP) client if the computer uses an NTP client to sync with an NTP server  

On the Microsoft Dynamics CRM web server, open IIS Manager, and limit the CRM Website to one http binding or one https binding, or both. To do it, follow these steps:

1. Select **Start**, select **Run**, and type **inetmgr** in the **Open** box.
2. Expand **Sites**, and then select the Microsoft Dynamics CRM website.
3. In the **Actions Pane**, select **Bindings**.
4. In the **Site Bindings** window, make that you only have one http binding type or only one https binding type, or both. If you have multiple http bindings or multiple https bindings, or both, the multiple bindings must be removed.

> [!NOTE]
> The binding that should remain is the binding that is defined in the Deployment Manager. To check for the correct URLs, open the Deployment Manager, right-click **Microsoft Dynamics CRM**, select **Properties**, and then select the **Web Address** tab.

> [!NOTE]
> If Internet Facing Deployment (IFD) is used, the certificate that matches your IFD settings should be retained.

## More information

If you're still meeting issues connecting CRM for Outlook to your CRM Online organization, [a diagnostic tool](https://support.microsoft.com/office/e90bb691-c2a7-4697-a94f-88836856c72f) is available to help diagnose the issue.
