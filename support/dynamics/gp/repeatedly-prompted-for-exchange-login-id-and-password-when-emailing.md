---
title: Repeatedly prompted for Exchange credentials when emailing
description: Users are repeatedly prompted for the Exchange login and password when attempting to email in Microsoft Dynamics GP 2013. Provides a resolution.
ms.reviewer: cwaswick
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# Users are repeatedly prompted for the Exchange Login ID and password when trying to email in Microsoft Dynamics GP 2013

This article provides a resolution for the issue that you're repeatedly prompted for the Exchange Login ID and password when trying to email a form or report in Microsoft Dynamics GP 2013.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2961375

## Symptoms

When attempting to email a form or report in Microsoft Dynamics GP 2013, users are repeatedly prompted for their email user name and password, and also receive a message that the login failed, even though the user name and password being entered is correct.

> [!NOTE]
> This happens in Microsoft Dynamics GP 2013 when the **Email Preferences / Server Type** option in the System Preferences window is set to Exchange. (To open the System Preferences window, select **Tools** under Microsoft Dynamics GP, point to **Setup**, point to System and select **System Preferences**.)

## Cause

The cause is that users aren't entering the Login ID information in the correct format that is required for emailing through Exchange.

## Resolution

To resolve this issue, follow these steps:

1. When the user is prompted with the Exchange Log On window, select the **Advanced Option** button, and enter in the login information as shown below for each field in the window:

    Email Address: UserID@Domain.com (The user should enter their email address.)

    Password: (The user should enter their Network Password.)

    Login ID: Ad-domain\User or USERID@Domain.com (The user should enter their domain credentials or local credentials.)

2. Once all three fields of login information have been entered, select **OK** and then they should be able to login and email successfully.

## More information

If using Office x64, the server type in System Preferences window must be set to Exchange.

If using Office 32 bit, the server type in System Preferences window can be set to either MAPI or Exchange.

The Exchange server type only supports XPS and DOCX. PDF is not supported with the Exchange server type.
