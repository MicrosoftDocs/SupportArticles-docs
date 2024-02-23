---
title: How to create organizational forms library
description: Describes how to create an organizational forms library in Exchange Online and in on-premises Exchange Server 2013 and later versions.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: apascual, zalattar, batre, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# How to create an organizational forms library in Exchange Online and Exchange Server

_Original KB number:_ &nbsp; 3109076

## Summary

This article discusses how to create organizational forms in Exchange Online and in Exchange Server 2013 and later versions. After you perform this procedure, users can use Microsoft Outlook to view and work in the organizational forms library.

## More information

1. Do one of the following, as appropriate for your situation:

   - Connect to Exchange Online by using remote PowerShell. For more information, see [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
   - In Exchange Server, open the Exchange Management Shell.

2. Create a new public folder mailbox that's named *PFHierarchy*. To do this, run the following command:

    ```powershell
    New-Mailbox -PublicFolder -Name PFHierarchy
    ```

3. Create a new public folder in the `NON_IPM_SUBTREE` directory that's named Organizational Forms Library. To do this, run the following command:

    ```powershell
    New-PublicFolder -Path "\NON_IPM_SUBTREE\EFORMS REGISTRY" -Name "Organizational Forms Library"
    ```

4. Set the locale ID on the folder that you created. To do this, run the following command:

    ```powershell
    Set-PublicFolder "\NON_IPM_SUBTREE\EFORMS REGISTRY\Organizational Forms Library" -EformsLocaleID EN-US
    ```

    To determine the correct locale ID to use, see [languagecode Field](/previous-versions/office/developer/exchange-server-2007/aa579489(v=exchg.80)).

5. Set read permissions for each regular user. To do this, run the following command:

    ```powershell
    Add-PublicFolderClientPermission -identity "\NON_IPM_SUBTREE\EFORMS REGISTRY\Organizational Forms Library" -user User@domain.com -AccessRights ReadItems
    ```

6. Set write permissions for each admin who will be saving the organizational forms to public folders. To do this, run the following command:

    ```powershell
    Add-PublicFolderClientPermission -identity "\NON_IPM_SUBTREE\EFORMS REGISTRY\Organizational Forms Library" -user Admin@domain.com -AccessRights CreateItems
    ```

7. Add a user as the owner of the Organizational Forms Library folder if they have to publish or create forms in the library. To do this, run the following command:

   ```powershell
   Add-PublicFolderClientPermission "\NON_IPM_SUBTREE\EFORMS REGISTRY\Organizational forms library" -User <User@domain.com> -AccessRights Owner
   ```

   > [!NOTE]
   > If you don't add the user as an owner, the Organizational Forms Library may not appear in Outlook.

8. Wait some time for replication to occur.

## References

For more information, see:

- [Save a form in a forms library](/office/vba/outlook/Concepts/Customizing-Forms/save-a-form-in-a-forms-library)
- [Create an organizational forms library](/previous-versions/office/exchange-server-2010/gg236889(v=exchg.141)) (Exchange Server 2010)
