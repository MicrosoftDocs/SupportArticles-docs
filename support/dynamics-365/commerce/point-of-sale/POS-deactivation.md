---
title: How to investigate POS suddenly being deactivated
description: This articles helps you identify causes for why the POS could deactivate. 
author: bstorie
ms.author: brstor
ms.topic: troubleshooting-problem-resolution 
ms.date: 07/25/2023
---

# POS is suddenly deactivated

After launching Store Commerce APP (POS) it no longer shows as activated. Instead the POS prompts the user to complete the activation process. This article is intended to help you self-diagnose what can cause this situation and remedial steps you can take to help prevent it. 

## Prerequisites

Ensure you have access to **Commerce HQ > Modules > Retail and Commerce > Channel Setup > POS setup > Devices**

## Determine the cause

## Cause 1: Device Token has expired

When the POS is activated a device token is issued and stored in the POS installation folder. Each time the POS is launched this tokens issue date is compared against the maximum token lifetime parameter configured inside Commerce HQ.  If the token is older then this parameter its considered invalid and the POS prompts for re-activation.

### Solution 1: Check Commerce HQ Device token settings

1. Log into **Commerce HQ > modules > Retail and Commerce > HQ Setup > Parameters > Commerce Shared Parameters**
2. **Select** the **Security** Tab
3. Review the value set in the **Device token lifetime** field.
   > By default this value is 365 days. It can be set as high as 5120 days. This value is the maximum number of days after a POS is activated the token will be valid for.

   > If you increase this value, any POS's which are currently activate will remain activate until their token lifetime reaches the new value set. 

4. Go to **Commerce HQ > Modules > Retail and Commerce > Channel Setup > POS setup > Devices**
5. Select the Device record that is prompting for activation
6. **Review** the **Activated date and time** field value.

   > If this date is older then the number of days set for the Device token lifetime, the POS token has exceeded its lifetime.

   > The value in this field will automatically update each time the POS is activated, its important to check this field before triggering a new activation .

7. If the POS token has expired you can simply re-activate the POS as the root cause is the token exceeded its lifetime.

## Cause 2: Windows App user directory was modified

By default Store Commerce App stores the configuration settings in a file under the path C:\Windows\users\{User account}\Appdata\local\packages

Some windows updates can inadvertently modify/delete files in this path. In this situation the Store Commerce App configuration file is removed and the POS application no longer registers as being activated. 

### Solution 1: Check Windows Update history

Check Windows update history to see if any recent Windows OS updates were deploy to the PC.  

If this is a re-occurring issue consider re-running the Store Commerce App installer again and include the flag --usecommonapplicationdata

  > When the flag --usecommonapplicationdata is used the POS configuration file will be stored in C:\Program Data\  folder instead.

### Solution 2: Security software is flagging the configuration file

Check to see if security software is scanning the C:\Windows\users\{User account}\Appdata\local\packages\Microsoft directory and flagging any files.

If this is a re-occurring issue consider re-running the Store Commerce App installer again and include the flag --usecommonapplicationdata

  > When the flag --usecommonapplicationdata is used the POS configuration file will be stored in C:\Program Data\  folder instead.

## Cause 3: Browser History was cleared

As Store Commerce for the Web (Cloud POS) is a browser based access system, it stores the POS activation state in the web browser history.  If you clear the web browser history then the POS will no longer report as activated. 

If you activated POS using in-private browser then its activation state will be lost once you close the browser. 

### Solution : Check browser settings and extensions

Check your browsers settings and extensions to make sure they are not clearing the browser history upon exit/closure of the web browser or tab. 

## Reference
For more information about Store Commerce App Installation parameters please review [this page](https://learn.microsoft.com/dynamics365/commerce/dev-itpro/store-commerce)
