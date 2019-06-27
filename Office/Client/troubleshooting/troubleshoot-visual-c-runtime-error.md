---
title: Troubleshooting a Visual C++ runtime error in Word
description: Describes how to locate the COM Add-in causing a Visual C++ runtime error in Word and disable the add-in.
author: simonxjx
manager: willchen
audience: ITPro
ms.service: office-perpetual-itpro
ms.topic: article
ms.author: v-six
---

# How to troubleshoot a Visual C++ runtime error in Word

## SYMPTOMS

The error message encountered may be similar to the following:

**Microsoft Visual C++ Runtime Library Runtime Error!**

## CAUSE

A **runtime error** means that there is an error in an add-in that is attempting to run. Typically the add-ins are created by a third-party and are not part of the Word installation. These errors could be caused by a malfunctioning virus as well.

## RESOLUTION

A Visual C++ error usually indicates the error lies in a COM Add-in. COM add-ins are add-ins loaded by Registry rather than the Startup folders.

If you are unable to start Word then you should be able to utilize the Run command and the **/a** startup switch to start Word in a troubleshooting mode which uses the application defaults and prevents add-ins from loading.

### Starting Word with the /a switch

1. On the **Start** menu, click **Run**.
2. In the Run command text box type: **winword /a** (note the space before the forward slash).
3. Click **OK** to start Word.

The following methods should help you locate the COM Add-in causing the error:

### Method 1

1. On the **Tools** menu, click **Customize**.
2. Select the **Commands** tab if necessary.
3. In the **Categories** on the left select **Tools**.
4. In the **Commands** section on the right locate the **COM Add-ins…** command.
5. Drag/drop the COM Add-ins to a toolbar location of your choice.
6. Click **OK** to close the Customize Toolbars dialog.
7. Click the **COM Add-ins** command to open the COM Add-ins dialog.
8. Deselect the add-in to prevent it from loading when Word starts.

### Method 2

If a COM Add-in is installed per-machine (all users) rather than per-user, it will not appear in the COM Add-ins utility described in Method 1. Use the following steps to determine if the add-in is listed in **System Information**:

1. On the **Help** menu, click **About Microsoft Word**.
2. Click the **System Info** command.
3. Navigate to **Office Applications\Microsoft Word\COM Add-ins**.
4. Review each add-in listed on the right to determine if there are COM Add-ins listed that did not appear in the COM Add-in utility.
5. For those that are not listed in the COM Add-ins utility and the **Installed** value is **Yes**, follow the steps in the **Resolution** to disable the add-in.

> [!NOTE]
> - The exact path for Word COM Add-ins may vary depending on the version of Word you are using.
> - If you started Word using the **/a** switch the COM Add-ins list will be unavailable.

### Method 3

You may be able to find the add-in by modifying your Macro Security and noting each add-in that loads when Word starts:

1. On the **Tools** menu, point at **Macro**, and click **Security **in the submenu.
2. Select the **Security Level** tab.
3. Set macro security to **Medium**.
4. Select the **Trusted Publishers** tab.
5. Deselect **Trust all installed add-ins and templates**.
6. Select each Trusted Source and click **Remove**
7. Exit and restart Word (without using the **/a** switch).
8. When prompted to Enable/Disable macros note file name and location of the add-in displayed in the message box.
9. If you find an unknown add-in, follow the steps in the **Resolution** to disable the add-in.

> [!NOTE]
> - Add-ins that start with F*.DLL, such as FStock.DLL, FName.DLL are for smart tags and have not been known to cause errors at this time.
> - Enable/Disable macros at your discretion. They do not need to enabled to determine the location and name however they will need to be enabled in order to test your troubleshooting results.

### Method 4

Use a third-party utility to view all DLLs in use while Word is running such as the **Process Explorer** available for download at this location:

1. Start Word.
2. Run the **Process Explorer** utility.
3. In the upper pane select **Winword.exe**.
4. Locate the **View DLLs** command in the Toolbar.
5. In the lower pane locate the DLLs and see if you can determine which DLL could be causing the issue.
6. Locate the path for the DLL in a column on the right.
7. Follow the steps in **Resolution** to disable the add-in.

> [!NOTE]
> If you find the **View Handles** command then you are already viewing the DLLs in use.

### Resolution

1. Check Add Remove Programs in the Control Panel and if you find an entry for the Add-in uninstall it.
2. Use Windows Search to locate the add-in and rename it to prevent it from loading.

> [!NOTE]
> Rename the file extension rather than the file name. For example change SomeAddIn.DLL to SomeAddIn.DLLDoNotLoad.

## MORE INFORMATION

This article also applies to **Word 2003**.