---
title: How to enable add-in for Business Contact Manager
description: Provides steps to configure the Business Contact Manager Add-in to load in Microsoft Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: TasitaE, GregMans
appliesto: 
  - Outlook 2010 with Business Contact Manager
search.appverid: MET150
ms.date: 10/30/2023
---
# How to enable the add-in for Business Contact Manager in Outlook

_Original KB number:_ &nbsp; 2977962

## Symptoms

In Microsoft Outlook 2010 or 2013 with Business Contact Manager, you may experience the following symptoms:

- The **Business Contact Manager** button is missing from the Navigation Pane in Outlook.
- The **Business Contact Manager** option is missing from the Outlook Backstage under the **File** tab.
- In the Navigation Pane, **Business Contact Manager** folder icons will appear as normal Outlook icons.
- In Outlook Contacts on the **Home** ribbon, when you select a Business Contact Manager element in the Folder List, you do not see the Business Contact Manager commands on the Ribbon such as **Mail Merge**, **Marketing**, **Assign To**, **Create Linked Business Contact** as shown.

  :::image type="content" source="media/how-to-enable-add-in-for-business-contact-manager/business-contact-manager-commands.png" alt-text="Screenshot of the Home ribbon in Outlook." border="false":::

## Cause

The Business Contact Manager Add-in is not loaded in Outlook.

## Resolution

Configure the Business Contact Manager Add-in to load in Outlook by using the following steps.

Outlook 2010 and 2013

1. In Outlook, select **File**, **Options**, and then clselectick **Add-Ins**.
2. Find the **Business Connectivity Services Add-In** in the list of Add-ins.

3. If the **Business Connectivity Services Add-In** is under the **Disabled Application Add-ins** section, do the following:

   1. Select **Disabled Items**, and then select **Go**.
   2. Select Addin: BCSAddin.dll, select **Enable**, and then select **Close**.

4. Select **COM Add-ins**, and then select **Go**.
5. Enable the following Add-Ins:

    Business Contact Manager for Outlook  
    Business Contact Manager Loader for Outlook

    :::image type="content" source="media/how-to-enable-add-in-for-business-contact-manager/com-add-ins-options-for-business-contact-manager.png" alt-text="Screenshot of the COM Add-Ins dialog box." border="false":::

6. Select **OK**.

## More information

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

You can also set the load behavior of the Add-ins in the Registry. To do this, follow these steps:

1. Select **Start**, and then select **Run.** Type *regedit* in the **Open** box, and then select **OK**.
2. Locate and then select the following registry subkeys:

    `HKEY_CURRENT_USER\Software\Microsoft\Office\Outlook\Addins\Microsoft.BusinessSolutions.eCRM.OutlookAddIn.Connect.4`  
    `HKEY_LOCAL_MACHINE\Software\Microsoft\Office\Outlook\Addins\Microsoft.BusinessSolutions.eCRM.OutlookAddIn.NativeConnect.4`  
    `HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Office\Outlook\Addins\Microsoft.BusinessSolutions.eCRM.OutlookAddIn.NativeConnect.4`

    > [!NOTE]
    > The `HKEY_LOCAL_MACHINE\Software\Wow6432Node` hive will be available only when Windows is 64-bit and Office is 32-bit. For more information, see [Addins for Office programs may be registered under the \Wow6432Node](https://support.microsoft.com/help/2778964/addins-for-office-programs-may-be-registered-under-the-wow6432node).

3. Right-click **LoadBehavior**, and then select **Modify**.
4. In the **Value** data box, type *3*, and then select **OK**.
5. Exit Registry Editor.
