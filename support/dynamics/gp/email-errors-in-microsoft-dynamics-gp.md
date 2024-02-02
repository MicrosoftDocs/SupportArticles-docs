---
title: Either there is no default mail client or the current mail client cannot fulfill the message request error 
description: Provides a resolution for the e-mail errors that may occur in Microsoft Dynamics GP.
ms.reviewer: dalbau
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# "Either there is no default mail client or the current mail client cannot fulfill the message request" e-mail error in Microsoft Dynamics GP

This article provides a resolution for the e-mail errors that may occur in Microsoft Dynamics GP.

You can see [E-mail error in Microsoft Dynamics GP 2013: "Either there is no default mail client or the current mail client cannot fulfill the message request. Please run Microsoft Outlook and set it as the default mail client."](https://community.dynamics.com/blogs/post/?postid=91c1c786-9d4f-4603-af71-cc8ba032de3e) with screen prints.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4052892

## Symptoms

When you try to use the e-mail functionality within Microsoft Dynamics GP, you may receive the following error messages:

> Either there is no default mail client or the current mail client cannot fulfill the message request. Please run Microsoft Outlook and set it as the default mail client

> Connection to the MAPI server not available. Unable to send e-mail or select addresses

## Resolution

The resolution to these errors as we've frequently seen is done in two parts:

A. On the machine(s) that Microsoft Dynamics GP and Outlook installed, under **Control Panel** > **User Accounts** select **Mail**, there should be a mail profile needs to be set up and selected to be used as the default.

B. As mentioned in the System Requirements for Microsoft Dynamics GP 2013 page:

1. If you're using a **64-bit** version of Office/Outlook, in the System Preferences window (**Microsoft Dynamics GP** > **Setup** > **System Preferences**), the Server Type needs to be set to **Exchange**.

2. If you're using a **32-bit** version of Office/Outlook, in the System Preferences window, the Server Type can be set to either MAPI or Exchange.

If the Server Type is set to **Exchange**, users may see an Exchange login window appear when they select the Send To and then Mail Recipient(Text) buttons when emailing a report or document from within the Dynamics GP 2013 application. Once they enter their credentials, a Compose email window will appear:

- If the Server Type is set to **MAPI**, an Outlook email window will appear as if a new email window was opened within Outlook itself.
- Microsoft Dynamics GP 2013 is supported on both Office 2010 and Office 2013, 32 bit and 64 bit.
- The Exchange server type only supports XPS and DOCX, PDF is not supported.

> [!NOTE]
> See Microsoft Dynamics GP Directory for other Microsoft Dynamics GP versions.

If after making the above changes, the email functionality still doesn't work in Microsoft Dynamics GP or you're still getting the same errors, you can also try the following that we've seen resolve email issues in the application:

1. First, sign in to the workstation where you're seeing these email functionality issues in Microsoft Dynamics GP, as an Administrator account.
2. Go to **Start** > **Run**, *type REGEDIT* and select **OK** to open the Registry Editor.
3. You will want to back up the HKEY_LOCAL_MACHINE keys by right-clicking on that node, selecting Export, and saving the keys to a location you can restore from later if necessary.
4. Once that is done, you'll want to expand `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\IniFileMapping\win.ini`.
5. If you look in the right-hand pane when win.ini is highlighted, you'll likely not see a MAIL string key. Right-click on win.ini and select **New** > **String Value**. Name this new value: **MAIL**.
6. Double-click on the MAIL key and set its value to **SYS:MICROSOFT\WINDOWS NT\CURRENTVERSION\MAIL**.

7. You then need to create the key(s) that the MAIL key refers to. If this is a 32-bit machine, you'd need to use option A below. If this is 64-bit use option B:

    Option A:

    1. Expand `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion`.
    2. Right-click on CurrentVersion and select **New** > **Key**.
    3. Name this new key: **MAIL**.
    4. Right-click on the new MAIL key and select **New** > **String Value**.
    5. Name this new string value: **MAPIX**.
    6. Double-click on MAPIX and set the value to **1**.

    Option B:

    1. Expand `HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows NT\CurrentVersion`.
    2. Right-click on CurrentVersion and select **New** > **Key**.
    3. Name this new key: **MAIL**.
    4. Right-click on the new MAIL key and select **New** > **String Value**.
    5. Name this new string value: **MAPIX**.
    6. Double-click on MAPIX and set the value to **1**.

8. You must restart the machine after making any Windows Registry changes, for the changes to then take effect.

While there could be other issues causing email functionality not to work in Microsoft Dynamics GP, the above would be the first items we would begin looking at to rule those out.
