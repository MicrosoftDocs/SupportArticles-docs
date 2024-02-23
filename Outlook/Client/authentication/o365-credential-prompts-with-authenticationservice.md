---
title: Microsoft 365 credential prompts with AuthenticationService value
description: Documents a connection issue for Microsoft 365 when the AuthenticationService registry value is configured.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: tmoore, gregmans
appliesto: 
  - Outlook 2013
  - Outlook 2010
  - Outlook 2007
search.appverid: MET150
ms.date: 10/30/2023
---
# Microsoft 365 credential prompts with AuthenticationService registry value

_Original KB number:_ &nbsp; 2975918

## Symptoms

When attempting to create an Outlook profile or connect to a Microsoft 365 mailbox, you are continually prompted for credentials while the client displays **trying to connect...** If you cancel the credentials prompt, you receive this error:

> The connection to Microsoft Exchange is unavailable. Outlook must be online or connected to complete this action.

Under **More Settings** on the **Microsoft Exchange Security** tab, the dropdown for **Logon network security** displays a value other than Anonymous Authentication, and is disabled.

:::image type="content" source="media/o365-credential-prompts-with-authenticationservice/more-settings.png" alt-text="Screenshot of the Security tab in the Microsoft Exchange setting window." border="false":::

## Cause

This behavior can occur if the `AuthenticationService` registry value is configured. This registry value will be found in this location:

`HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\x.0\Outlook\Security`  
DWORD: `AuthenticationService`  
Available values: **9**, **16**, or **10**

Where x.0 = 15.0 for Outlook 2013, and x.0 = 14.0 for Outlook 2010, and 12.0 for Outlook 2007.

## Resolution

Remove the `AuthenticationService` registry value, or disable the Group Policy that is applying it.

> [!WARNING]
> Using Registry Editor incorrectly can cause serious problems that may require you to reinstall your operating system. Microsoft cannot guarantee that problems resulting from the incorrect use of Registry Editor can be solved. Use Registry Editor at your own risk.

1. Exit Outlook.
2. Start Registry Editor.

    In Windows 8 and Windows 8.1

    Swipe in from the right to open the charms, tap or select **Search**, and then type *regedit.exe* in the search box. Or, type *regedit.exe* at the **Start** screen, and then tap or select regedit in the search results.

    In Windows Vista and Windows 7

    Select **Start**, type *regedit* in the **Start** search box, and then press Enter. If you are prompted for an administrator password or for confirmation, type the password, or select **Allow**.

3. Navigate to the appropriate path from the Cause section above.

4. Right-click `AuthenticationService`, select **Modify**, and select **Delete** to remove it from the registry.

The following Group Policy applies the `AuthenticationService` registry value:

:::image type="content" source="media/o365-credential-prompts-with-authenticationservice/group-policy.png" alt-text="Screenshot of the Authentication with Exchange Server group policy." border="false":::

Policy: Account Settings\Exchange\Authentication with Exchange Server

Setting: Select the authentication with Exchange server.

Available choices:  
Kerberos/NTLM Password Authentication (Default)  
Kerberos Password Authentication  
NTLM Password Authentication

To disable the Group Policy, under Authentication with Exchange Server, select **Not Configured**.

## More information

`HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\x.0\Outlook\Security`  
DWORD: `AuthenticationService`  
Available values: **9**, **16**, or **10**

The available values correspond to the Group Policy Settings as follows:

9 - Kerberos/NTLM Password Authentication (Default)  
16 - Kerberos Password Authentication  
10 - NTLM Password Authentication
