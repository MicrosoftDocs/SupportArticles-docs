---
title: Apply different passwords or permissions to separate ranges in workbooks
description: Describes how to apply different passwords or permissions to separate ranges in workbooks in Excel.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Excel 2007
  - Excel 2003
  - Excel 2002
ms.date: 03/31/2022
---

# Apply different passwords or permissions to separate ranges in workbooks in Excel

## Summary

In Microsoft Excel 2002 and in later versions of Excel, you can now use passwords to protect specific ranges in your worksheets. This is a change from earlier versions of Excel, in which one password applies to the entire worksheet, which might have several protected ranges. In addition, if you use Windows 2000, you can apply group-level passwords and user-level passwords to different ranges.

The features in Microsoft Excel that are related to hiding data and protecting worksheets and workbooks with passwords are not intended to be mechanisms for securing data or protecting confidential information in Excel. You can use these features to present information more clearly by hiding data or formulas that might confuse some users. These features also help prevent other users from making accidental changes to data. 

Excel does not encrypt data that is hidden or locked in a workbook. With enough time, users can obtain and modify all the data in a workbook, as long as they have access to it. To help prevent modification of data and to help protect confidential information, limit access to any Excel files that contain such information by storing them in locations available only to authorized users.

> [!NOTE]
> This article describes how to enable specific collaboration scenarios to function correctly in collaboration environments that do not include users who have malicious intent. You cannot enable strong encryption for a file by using password protection. To protect your document or file from a user who has malicious intent, you can restrict permission by using Information Rights Management (IRM).

## More Information

### How to apply different passwords

To apply different passwords to two ranges in a worksheet, follow these steps:

1. Start Excel, and then open a blank workbook.
1. On the **Tools** menu, point to Protection, and then click **Allow Users to Edit Ranges**.

    > [!NOTE]
    > In Microsoft Office Excel 2007, click **Allow Users to Edit Ranges** in the **Changes** group on the **Review** tab.
1. In the **Allow Users to Edit Ranges** dialog box, click **New**.
1. In the **New Range** dialog box, click the **Collapse Dialog** button. Select the range B2:B6, and then click the **Collapse Dialog** button again.
1. In the **Range password** box, type rangeone, click **OK**, then type it again in the **Confirm Password** dialog box, and then click **OK**.
1. Repeat steps 3 through 5, selecting the range D2:D6 and typing rangetwoas the password for that range.
1. In the **Allow Users to Edit Ranges** dialog box, click **Protect sheet**. In the **Password to unprotect sheet** box, type ranger, and then click **OK**. When prompted, retype the password, and then click **OK**.
1. Select cell B3, and then start to type Dataone. 

    > [!NOTE]
    > When you type D, the **Unlock Range** dialog box appears.
1. Type rangeone in the **Enter the password to change this cell** box, and then click **OK**.

     You can now enter data in cell B3 and in any other cell in the range B2:B6, but you cannot enter data in any of the cells D2:D6 without first providing the correct password for that range.

The range that you protect with a password does not have to be made of adjacent cells. If you want the ranges B2:B6 and D2:D6 to share a password, you can select B2:B6 as described in step 4 earlier in this article, type a comma in the **New Range** dialog box, and then select the range D2:D6 before you assign the password.

When you apply different passwords to separate ranges in this way, a range that has been unlocked remains unlocked until the workbook is closed. When you unlock another range, you do not relock the first range. Likewise, when you save a workbook, you do not relock a range.

You can use existing range names to identify cells that are to be protected with passwords, but if you do, Excel converts any relative references in the existing name definitions to absolute references. Because this may not give you the results you intended, it is better to use the **Collapse Dialog** button to select the cells, as described earlier in this article.

### How to apply group-level passwords and user-level passwords

If you use Windows 2000 (but not other versions of Windows), you can assign different permissions to various individual users or groups of users. When you do this, permitted users can edit the protected ranges without needing to type passwords, and other users can still edit the ranges as long as they can supply the correct password.

To apply group-level protection to a worksheet, follow these steps:

1. Start Excel, and then open a blank worksheet.
1. On the **Tools** menu, point to **Protection**, and then **click Allow Users to Edit Ranges**.

    > [!NOTE]
    > If you are running Excel 2007, click **Allow Users to Edit Ranges** in the **Changes** group on the **Review** menu.
1. In the **Allow Users to Edit Ranges** dialog box, click **New**.
1. In the **New Range** dialog box, click **Collapse Dialog**, select the range B2:B6, and then click **Collapse Dialog** again.
1. In the **Range password** box, type rangeone, and then click **OK** twice. When prompted, retype the password.
1. Repeat steps 3 through 5, selecting the range D2:D6 and typing rangetwo as the password for that range.
1. In the **Allow Users to Edit Ranges** dialog box, click **Permissions**, and then click **Add** in the **Permissions for Range2** dialog box.
1. In the **Select Users or Groups** dialog box, type **Everyone**, and then click **OK**.
1. Click **OK** in the **Permissions for Range2** dialog box.
1. In the**Allow Users to Edit Ranges** dialog box, click **Protect** sheet, type ranger in the **Password to unprotect sheet** box, and then click **OK** twice. When prompted, retype the password.
1. Select cell B3, and then start to type Dataone. A password is still required. Click **Cancel** in the **Unlock Range** dialog box.
1. Select cell D3, and then type Datatwo.

    No password is required.

> [!NOTE]
> You must use Windows 2000 in order to assign permissions to groups or individuals as described earlier in this article, but after you have done so, those permissions are recognized when the worksheets are edited on computers that use Microsoft Windows NT. Windows NT does not enable you to assign or modify the permissions.

If you apply group permissions or user permissions, and then open the workbook in Excel 2002 on a Microsoft Windows Millennium Edition-based computer or Microsoft Windows 98-based computer, the group permissions or user permissions are ignored, but different passwords for different ranges are recognized.

### How to change passwords

To change the password for a range, follow these steps:

1. Start Excel, and then open the workbook.
1. On the Tools menu, point to **Protection**, and then click **Unprotect Sheet**.

    > [!NOTE]
    > In Excel 2007, click **Unprotect Sheet** in the **Changes** group on the **Review** tab.
1. If prompted type the worksheet password, and then click **OK**.
1. On the **Tools** menu, point to **Protection**, and then click **Allow Users to Edit Ranges**. 

    > [!NOTE]
    > In Excel 2007, click **Allow Users to Edit Ranges** in the **Changes** group on the **Review** tab.
1. Click a range in the list, and then click **Modify**.
1. Click **Password**.
1. Type the new password in the **New password** box, and then retype the new password in the **Confirm new password** box.
1. Click **OK**, and then click **OK**.
1. To change the password for another range, repeat steps 3 through 6. Otherwise, click **Protect Sheet**.
1. Type the worksheet password in the **Password to unprotect sheet** box.
1. Click **OK**, retype the worksheet password to confirm it, and then click **OK**.

> [!IMPORTANT]
> Note these aspects of applying passwords and group-level permissions to specific ranges:
>
> - Excel 2003 runs only on Microsoft Windows XP and on Microsoft Windows 2000.
>
>- When a workbook with protected ranges is opened in Excel 2002 on a Windows XP-based computer, on a Windows 2000-based computer, or on a Microsoft Windows NT-based computer, the worksheet range and group protection are the same as they are in Excel 2003.
>
>- When a workbook with protected ranges is opened in Excel 2002 on a Microsoft Windows Millennium Edition-based computer or on a Microsoft Windows 98-based computer, ranges with user-level and group-level permissions require the range password.

## More information

For more information about the Microsoft Office features that help enable collaboration, see [Description of Office features that are intended to enable collaboration and that are not intended to increase security](https://support.microsoft.com/help/822924).
