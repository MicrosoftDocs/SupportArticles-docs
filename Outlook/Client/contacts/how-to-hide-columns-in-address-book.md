---
title: How to hide columns in Address Book
description: Describes how to hide columns in Address Book in Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: pasharma, gregmans, randyto, adean, gbratton, jamesmi
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Office 2010 Service Pack 2
search.appverid: MET150
ms.date: 10/30/2023
---
# How to hide columns in the Address Book in Outlook

You can hide one or more columns in the Address Book in Microsoft Outlook by using the `ABHiddenColumns` registry key. To do this, add the `ABHiddenColumns` registry key, and then set the appropriate value for it.

_Original KB number:_ &nbsp; 970144

> [!IMPORTANT]
This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

1. Select **Start**, and then select **Run**.
2. In the **Open** dialog box, enter *regedit*, and then select **OK**.
3. In **Registry Editor**, locate and then select the following registry subkey:

    For Outlook 2019 and Outlook 2016: `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\16.0\Outlook\Preferences`  
    For Outlook 2013: `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\15.0\Outlook\Preferences`  
    For Outlook 2010: `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\14.0\Outlook\Preferences`

4. On the **Edit** menu, point to **New**, and then select **Binary Value.**
5. Enter *ABHiddenColumns*, and then press Enter.
6. In the right pane, right-click **ABHiddenColumns**, and then select **Modify**.
7. In the **Value data** box, type a value according to the rules and guidelines in the next section (ABHiddenColumns values), and then select **OK**.
8. Exit **Registry Editor**.

## ABHiddenColumns values

To hide one or more columns, select one or more values from the following table, and then combine these values with the following number:

**0# 00 00 00**

For example, to hide the **Business Phone**, **Location**, and **Alias** columns, use the following value for the `ABHiddenColumns` registry key:

**03 00 00 00 1f 00 08 3a 1f 00 19 3a 1f 00 00 3a**

> [!NOTE]
>
> - The number sign (#) placeholder is an integer between 1 and 6 that equals the number of columns that you want to hide.
> - The **Name** column in the **Address Book** cannot be hidden.

|Column|ABHiddenColumns value|
|---|---|
| **Title**|1f 00 17 3a|
| **Business Phone**|1f 00 08 3a|
| **Location**|1f 00 19 3a|
| **Email Address**|1f 00 fe 39|
| **Company**|1f 00 16 3a|
| **Alias**|1f 00 00 3a|
| **Department**|1f 00 18 3a|

## More information

The `ABHiddenColumns` registry key lets you hide these columns in the **Address Book** only. After you hide these columns in the **Address Book**, they are is still available in the **Properties** dialog box. The **Properties** dialog box is displayed when you double-click a user entry in the **Address Book**.

To hide these columns in the **Properties** dialog box, modify the details template in the **Exchange System Manager**. For more information about the details template, see [How to Add, Edit, Change and Revert Address and Details Templates](/archive/blogs/dgoldman/how-to-add-edit-change-and-revert-address-and-details-templates).

The following table lists some special field mappings between the **Address Book** and the **Properties** dialog box in which the field names differ.

|Address Book|Properties|
|---|---|
| **Business Phone**|Phone|
| **Location**|Office|

The `ABHiddenColumns` values for columns that can be hidden are determined by using the **Property ID** value and the **Data Type** value for the following properties.

|Properties|Property ID and Data type|
|---|---|
| **Title**|2.1115 PidTagTitle<br/>Canonical name: PidTagTitle<br/> **Property ID** : 0x3A17<br/> **Data type** : PtypString, 0x001F|
| **Business phone**|2.672 PidTagBusinessTelephoneNumber<br/>Canonical name: PidTagBusinessTelephoneNumber<br/> **Property ID** : 0x3A08<br/> **Data type** : PtypString, 0x001F|
| **Location**|2.874 PidTagOfficeLocation<br/>Canonical name: PidTagOfficeLocation<br/> **Property ID** : 0x3A19<br/> **Data type** : PtypString, 0x001F|
| **Email Address**|2.934 PidTagPrimarySmtpAddress<br/>Canonical name: PidTagPrimarySmtpAddress<br/> **Property ID** : 0x39FE<br/> **Data type** : PtypString, 0x001F|
| **Company**|2.689 PidTagCompanyName<br/>Canonical name: PidTagCompanyName<br/> **Property ID** : 0x3A16<br/> **Data type** : PtypString, 0x001F|
| **Alias**|2.570 PidTagAccount<br/>Canonical name: PidTagAccount<br/> **Property ID** : 0x3A00<br/> **Data type** : PtypString, 0x001F|
| **Department**|2.663 PidTagDepartmentName<br/>Canonical name: PidTagDepartmentName<br/> **Property ID** : 0x3A18<br/> **Data type** : PtypString, 0x001F|

These properties are described in the [MS-OXPROPS]: Exchange Server Protocols Master Property List document that is available for download from the Microsoft Download Center:

[Download the [MS-OXPROPS] package now.](https://download.microsoft.com/download/5/d/d/5dd33fdf-91f5-496d-9884-0a0b0ee698bb/%5bms-oxprops%5d.pdf)

Microsoft scanned this file for viruses. Microsoft used the most current virus-detection software that was available on the date that the file was posted. The file is stored on security-enhanced servers that help prevent any unauthorized changes to the file.

For more information about how to download Microsoft support files, see [How to obtain Microsoft support files from online services](https://support.microsoft.com/help/119591).
