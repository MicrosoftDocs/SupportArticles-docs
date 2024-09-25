---
title: FAQ about printer issues
description: Describes frequently asked questions about printer issues in Microsoft Dynamics GP
ms.reviewer: theley
ms.date: 03/20/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# Frequently asked questions about printer issues in Microsoft Dynamics GP
This article describes frequently asked questions about printer issues in Microsoft Dynamics GP
_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 959033

## Frequently asked questions

Q1. What are some general tips for troubleshooting printer issues?

A1 To troubleshoot printer issues, there are multiple tips that you can try:

- Try to print from a sample company, such as Fabrikam, Inc.
- If a report was changed, you can do the following:

  - Try to remove security from the modified version, and then print the default report.
  - Try to move or rename the Reports.dic file.
  - Reinstall the print driver because the print driver may be damaged. You can try both a newer version and an older version of the driver.
- Re-create the Reports.dic file. For more information about how to re-create the Reports.dic file in Microsoft Dynamics GP, see [How to re-create the Reports.dic file in Microsoft Dynamics GP](https://support.microsoft.com/help/850465).
- If you're using a Post Script (PS) print driver, switch to the Printer Control Language (PCL) driver for your printer. Or, if you're using the PCL driver, switch to the PS print driver.
- If the printer that has the issue is a network printer, send the report to a different printer that is local to a workstation.
- If you experience printing issues from Microsoft Dynamics GP, print the report by using Notepad. It's because Microsoft Dynamics GP uses the same operating system printer logic that Notepad uses.
- Try to print the report to the screen. Microsoft Dynamics GP uses an installed print driver to generate the on-screen preview of a report. If you can print to screen but can't print to the printer, the problem might be a network issue or a hardware issue.

Q2. How many kinds of print drivers are there?

A2 There are three general kinds of print drivers:

- Post Script (PS): PS drivers are more efficient when you print graphic reports.
- Printer Control Language (PCL): PCL drivers are usually the manufacturer's drivers that are installed with the driver. These drivers usually contain other utilities that enable the advanced functionality of a printer.
- Uni-driver: It's a text-based driver that most dot-matrix printers use. These drivers work on most printers, regardless of brand or model. However, you lose the advanced features of the printer.

Q3. When you start Microsoft Dynamics GP, the splash screen is displayed. However, Microsoft Dynamics GP won't start, and a button in the taskbar has the Microsoft Dynamics GP logo together with ERROR as its name. How do I resolve it?

A3 Right-click the **ERROR** taskbar button. A context menu appears. Select **Move**, and then use the arrow keys to move the taskbar from behind the splash screen. When you see the taskbar, note the error message.

If the error message resembles "Prop Res DLL not loaded," it usually indicates that the .dll files for a Dell printer or a Lexmark printer aren't registered. To register the .dll files that appear in the error message, use one of the following methods:

- Method 1: Copy the printer driver files to the System32 folder. To do it, follow these steps:

    1. In Windows Explorer, locate the `drive:\Windows\System32\Spool\Drivers\W32x86\3` folder.
    2. Press and hold CTRL, and then select each printer file.

        > [!NOTE]
        > Each printer driver file has a file name that resembles the following:
        >
        > - lx**prpb.dll
        > - lx**prpr.dll
        > - dl**prpb.dll
        > - dl**prpr.dll

        > [!NOTE]
        > In these file names, ** is a placeholder for a two-letter designation that is associated with the printer.

    3. Copy the selected printer files to the `drive:\Windows\System32` folder.

- Method 2: Update the Path environment variable to include the printer driver folder. To do it, follow these steps:

    1. Select **Start**, select **Control Panel**, select **System and Maintenance**, and then select
    **System**.
    2. Select the **Advanced** tab, and then select
    **Environment Variables**.
    3. Under **System variables**, select the
    **Path** variable, and then select **Edit**.
    4. Press **END** to move the pointer to the end of the path, type a semicolon (;), and then use the appropriate method to type the path of the printer driver file:

        - If the computer that you use is running a 32-bit version of Windows, type the following default path:  
        `C:\Windows\System32\Spool\Drivers\W32X86\3`
        - If the computer that you use is running a 64-bit version of Windows, type the following default path:  
        `C:\Windows\System32\Spool\Drivers\X64\3`  

        For example, after you update the Path variable on a computer that is running a 32-bit version of Windows, the path would resemble the following:  
        `%SystemRoot%\System32;%systemroot%;C:\Windows\System32\Spool\Drivers\W32X86\3`

    5. Select **OK** to close the **Edit System Variable** dialog box.
    6. Select **OK** to close the **Environment Variables** dialog box.
    7. Select **OK** to close the **System Properties** dialog box.

Q4: Users select **File**, select **Print Setup**, and then change their default printer. After the user closes and restarts Microsoft Dynamics GP, the printer changes back to the printer that was originally listed. Why does it occur?

A4 In this situation, Microsoft Dynamics GP is working as designed. The Microsoft Dynamics GP program selects whatever is listed as the computer's default printer when Microsoft Dynamics GP starts.

If you want to have the printer setting remain after a Microsoft Dynamics GP session ends, you can set up a Citrix environment or a Terminal Server environment to load the remote client's local printer drivers before Microsoft Dynamics GP is started. For more information about how to implement this configuration, see the Citrix/Terminal Server documentation.

> [!NOTE]
> On Citrix terminal servers, you can change the Citrix environment. Therefore, selecting a different default printer in Microsoft Dynamics GP causes the printer to remain marked as the default printer after Microsoft Dynamics GP is restarted. For more information about how to configure this setting, contact Citrix support.

Q5: When I try to print invoices or other documents in Microsoft Dynamics GP in a Citrix environment, I receive the following error message:
> "Unable to get printer context." How do I resolve this?

A5 When Microsoft Dynamics GP starts, Microsoft Dynamics GP selects the default printer that is set in Windows. When you use Microsoft Dynamics GP on a Citrix server as a published application, there isn't enough time for Microsoft Dynamics GP to select the Windows printer. To resolve this error message, follow these steps:

1. Select the **ICA Client Options** tab in the properties of the published application, and then select to clear the **Start this application without waiting for printers to be created** check box.

    Microsoft provides third-party contact information to help you find technical support. This contact information may change without notice. Microsoft doesn't guarantee the accuracy of this third-party contact information.  

2. Find the Dex.ini file in one of the following locations:
   - This file can be found in the Dynamics GP code folder.

   - Usually, this file can be found in the `C:\Program Files\Microsoft Dynamics\ GP` folder.
3. Open the Dex.ini file by using Notepad.
4. Search for any lines that contain an IP address that references a printer. For example, you may see a line that resembles the following line:  
    `P_192.168.100.10HP LaserJet 400=0;0`
5. If you find lines that contain an IP address that references a printer, modify them by inserting REM at the beginning of each line. For example, use a modified line that resembles the following line:
    `REM IP_192.168.100.10HP LaserJet 400=0;0`

Q6: I want to create a report option for a report that specifies that the report be sent to an Adobe PDF file and to the printer. I select the **Destination** button, and then select the Screen, Printer, and File check boxes. When I select a file name, and then select the Adobe PDF file format, the Screen, and Printer check boxes are no longer selected. Why does it occur?

A6 The functionality of Microsoft Dynamics GP allows multi-selected destinations for report options. The combination of the **Screen** and **Printer** options and the combination of the **Screen** option and the file format of PDF are available. However, sending a report to both a printer and to the PDF file format isn't possible because of print driver requirements in later versions of Adobe and Microsoft Dynamics GP. So any destination combination is possible except for printer and file format of PDF.

Q7: When you print Text reports for Microsoft Dynamics GP to a laser printer, they're printed in the built-in Courier printer font. How can I control the font typeface and size settings in the Dex.ini defaults file?

A7 The following three Dex.ini settings that can be used to control the font typeface and size:

- Font\<Dexterity Font Name>=\<TrueType Font>: This setting enables the selection of different fonts for use on the screen and in reports within Microsoft Dynamics GP. Because Text reports use the Courier New font, which is a non-proportional font, the font that is selected to replace Courier New must also be a non-proportional font. Additionally, the font that is selected must be available on the workstation where this change is being made. For more information, see the [How to check whether a font is non-proportional](#how-to-check-whether-a-font-is-non-proportional) section.

    > [!NOTE]
    > Non-proportional fonts are also known as fixed width fonts or monospaced fonts.

- Tolerance=-1: This setting requests Dexterity to ignore built-in printer fonts and to substitute a scalable Windows TrueType font.
- MinMilHeight=150: This setting is used to increase or reduce the size of the font. The default value is 150 for a laser printer.

> [!NOTE]
> Not all printers and printer driver combinations support the use of these settings. Even with these settings in the Dex.ini file, the report output may not be altered.

To change the font that is used for Text reports, follow these steps:

1. Locate the Dex.ini file:
   - For Microsoft Dynamics GP 10.0 or later versions, the Dex.ini file is in the Data Subfolder under the application folder.
2. Open the Dex.ini file by using Notepad.
3. Add the following lines at the bottom of the Dex.ini file.

    > FontCourier New=Lucida Console  
    Tolerance=-1  
    MinMilHeight=100

    > [!NOTE]
    > You can choose a different font or use a different Height setting.
4. On the **File** menu, select **Save** to save the Dex.ini file.
5. Start Microsoft Dynamics GP, and then print a Text report. For example, print the Customer report from the Customer Maintenance window.

## How to check whether a font is non-proportional

1. Start Microsoft Office Word.
2. Type ten 'I' characters on a line, and then press ENTER.
3. Type ten 'W' characters on a line, and then press ENTER.
4. Select both lines of text.
5. Change the font to the font that you want to check.
6. If the total width of the line of I's is the same as the line of the W's, the font is non-proportional.

Some examples of non-proportional fonts that are available in Windows Vista include the following fonts:

- Lucida Console
- Lucide Typewriter
- MS Gothic
- MS Mincho

> [!NOTE]
> Many fonts have multiple versions. If a version of a font ends with "Che," the font is non-proportional.

Q8: How can I tell which font a report is printed in?

A8 For more information about how to determine which font a report in printed in, see [Printer Fonts Selected by Dynamics](https://support.microsoft.com/help/870341).

Q9: How does Report Writer decide which font to use when Best Text Fit is marked in the Report Definition window?

A9 For more information about how Report Writer decides which font to use when Best Text Fit is marked in the Report Definition window, see [Font used when Best Text Fit is marked](https://support.microsoft.com/help/849370).

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.
