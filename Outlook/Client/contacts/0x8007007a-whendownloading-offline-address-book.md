---
title: 0x8007007A when downloading Offline Address Book
description: Fixes an issue in which you receive an error message when you try to download an Offline Address Book in Outlook 2013 or Outlook 2010.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: tasitae, Gregmans
appliesto: 
  - Outlook 2013
  - Microsoft Outlook 2010
search.appverid: MET150
ms.date: 10/30/2023
---
# 0x8007007A error when you try to download an Offline Address Book in Outlook 2013 or Outlook 2010

_Original KB number:_ &nbsp; 3031401

## Symptoms

When you try to download an Offline Address Book (OAB) for a profile in Outlook 2013 or Outlook 2010, you receive the following error message:

> Task '\<profile name>' reported error (0x8007007A): 'Unknown Error 0x8007007A'.

## Resolution Method 1 - Create a new Outlook profile

1. Exit Outlook.
2. In **Control Panel**, select **Mail**, and then select **Show Profiles**.
3. On the **General** tab in the **Mail** dialog box, select **Add**.
4. In the **New Profile** dialog box, type a new profile name, and then select **OK**.
5. In the **Add New Account** dialog box, type your email account information, and then select **Next**.
6. After your account is successfully configured, select **Finish**.
7. Select **Always use this profile**, select the new profile, and then select **OK**.

## Resolution Method 2 - Delete the 001e660e registry value

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

To manually delete the `001e660e` registry value, follow these steps:

1. Exit Outlook.
2. Start Registry Editor:
   - In Windows 7, Select **Start**, type *regedit* in the **Search programs and files** text box, and then select **regedit.exe** in the search results.
   - In Windows 8, move your mouse to the upper-right corner, select Search type *regedit* in the search text box, and then select **regedit.exe** in the search results.

3. Locate and then select the following registry subkey for your version of Outlook:

   - Outlook 2013

     `HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Outlook\Profiles\<profile name>`
   - Outlook 2010

     `HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Windows Messaging Subsystem\Profiles\<profile name>`

4. On the **Edit** menu, select **Find**.
5. Enter 001e660E and then select **Find Next**.

   :::image type="content" source="media/0x8007007a-whendownloading-offline-address-book/find-registry-value.png" alt-text="Screenshot of the Find dialog box of Registry Editor." border="false":::

6. When a result is found, make sure that it is listed under the correct `<profile name>` subkey.

    > [!NOTE]
    > View the data of the `001e660E` registry value to determine whether it is blank. If it is blank, this confirms the cause of the OAB download issue.
7. Right-click the 001e660E registry value, and then select **Delete**.

   :::image type="content" source="media/0x8007007a-whendownloading-offline-address-book/delete-registry-value.png" alt-text="Screenshot of the right-click menu of the 001e660E registry value." border="false":::
  
## More information

Value data for the `001e660e` registry entry is used to control where the OAB files are stored by Outlook. If the value data for the `001e660e` registry entry is missing, Outlook cannot store the OAB files successfully. The registry entry is located in the following registry subkey.

- Outlook 2013
  
  `HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Outlook\Profiles\<profile name>\<subkey varies for each Outlook profile*>\`

- Outlook 2010
  
  `HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Windows Messaging Subsystem\Profiles\<profile name>\<subkey varies for each Outlook profile>\`

> [!NOTE]
>
> - To determine the subkey that varies for each Outlook profile, search the `<profile name>` subkey for the `001e660e` registry entry. To do this, see method 2 in the resolution section.
> - The registry value does not exist by default in most Outlook profiles. It typically exists only if you have configured an Outlook profile by using a .prf file that has the setting that specifies the path for the OAB files.
> - If you configure an incomplete .prf or .msp file in Outlook 2010 or Outlook 2013, this may cause a blank value for the registry key. For more information, see [(KB2923056) 0x8007007A error when you try to download an Offline Address Book because of an incomplete .prf or .msp file](https://support.microsoft.com/help/2923056).
