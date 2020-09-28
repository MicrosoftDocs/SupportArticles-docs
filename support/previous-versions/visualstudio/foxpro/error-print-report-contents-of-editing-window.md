---
title: Fail to print report or contents of Editing window
description: This article provides resolution for the problem that occurs when you use the Universal Printer Driver feature in Citrix MetaFrame Presentation Server.
ms.date: 09/08/2020
ms.prod-support-area-path: 
ms.reviewer: trevorh
ms.prod: visual-studio-family
---
# FIX: Error when you try to print a report or the contents of the Editing window

This article provides resolution for the problem that occurs when you use the Universal Printer Driver feature in Citrix MetaFrame Presentation Server.

_Original product version:_ &nbsp; Visual FoxPro  
_Original KB number:_ &nbsp; 909283

## Symptoms

Consider the following scenario. You are using Visual FoxPro or a Visual FoxPro application. The application is running on a computer that is running Citrix MetaFrame Presentation Server. Additionally, you have configured MetaFrame Presentation Server to use the Universal Printer Driver feature.

When you try to print a report in Visual FoxPro or in the Visual FoxPro application, you receive the following error message:

> Error 1958: Error loading printer driver

When you try to print the contents of the Editing window in Visual FoxPro, you receive the following error message:

> Error 125: Printer is not ready

When you try to print the contents of the Editing window in the Visual FoxPro application, you do not receive an error message. However, the contents of the Editing window do not print.

## Resolution

- **Visual FoxPro 9.0**

    To resolve this problem, obtain the latest service pack for Visual FoxPro 9.0. For more information, see [How to obtain Service Pack 1 for Visual FoxPro 9.0](https://support.microsoft.com/help/906478).

- **Visual FoxPro 8.0**

    A supported hotfix is now available from Microsoft, but it is only intended to correct the problem that is described in this article. Only apply it to systems that are experiencing this specific problem. This hotfix may receive additional testing. Therefore, if you are not severely affected by this problem, we recommend that you wait for the next Visual FoxPro service pack that contains this hotfix.

    To resolve this problem immediately, contact Microsoft Product Support Services to obtain the hotfix. For a complete list of Microsoft Product Support Services telephone numbers and information about support costs, visit the following Microsoft Web site: [https://support.microsoft.com/contactus/?ws=support](https://support.microsoft.com/contactus/?ws=support)

    > [!NOTE]
    > In special cases, charges that are ordinarily incurred for support calls may be canceled if a Microsoft Support Professional determines that a specific update will resolve your problem. The usual support costs will apply to additional support questions and issues that do not qualify for the specific update in question.

    **File information**

    The English version of this hotfix has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it is converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the Date and Time tool in Control Panel.

    ```console
    Date         Time    Version      Size   File name
    ----------------------------------------------------------
    07-Oct-2005 01:50 8.0.0.3402 5,345,280 Vfp8.exe
    07-Oct-2005 01:53 8.0.0.3402 1,466,368 Vfp8chs.dll
    07-Oct-2005 01:53 8.0.0.3402 1,466,368 Vfp8cht.dll
    07-Oct-2005 01:26 8.0.0.3402 1,466,368 Vfp8enu.dll
    07-Oct-2005 01:53 8.0.0.3402 1,466,368 Vfp8kor.dll
    07-Oct-2005 01:51 8.0.0.3402 4,300,800 Vfp8r.dll
    07-Oct-2005 01:53 8.0.0.3402 1,150,976 Vfp8rchs.dll
    07-Oct-2005 03:26 259,584 Vfp8rchs.msm
    07-Oct-2005 01:53 8.0.0.3402 1,150,976 Vfp8rcht.dll
    07-Oct-2005 03:26 262,144 Vfp8rcht.msm
    07-Oct-2005 01:53 8.0.0.3402 1,150,976 Vfp8rcsy.dll
    07-Oct-2005 03:26 269,312 Vfp8rcsy.msm
    07-Oct-2005 01:53 8.0.0.3402 1,150,976 Vfp8rdeu.dll
    07-Oct-2005 03:26 270,336 Vfp8rdeu.msm
    07-Oct-2005 01:30 8.0.0.3402 1,150,976 Vfp8renu.dll
    07-Oct-2005 01:53 8.0.0.3402 1,150,976 Vfp8resn.dll
    07-Oct-2005 03:26 268,288 Vfp8resn.msm
    07-Oct-2005 01:53 8.0.0.3402 1,150,976 Vfp8rfra.dll
    07-Oct-2005 03:26 267,776 Vfp8rfra.msm
    07-Oct-2005 01:53 8.0.0.3402 1,150,976 Vfp8rkor.dll
    07-Oct-2005 03:26 261,632 Vfp8rkor.msm
    07-Oct-2005 01:53 8.0.0.3402 1,150,976 Vfp8rrus.dll
    07-Oct-2005 03:26 271,872 Vfp8rrus.msm
    07-Oct-2005 03:25 4,206,592 Vfp8runtime.msm
    07-Oct-2005 01:51 8.0.0.3402 3,776,512 Vfp8t.dll
    ```

## More information

Citrix MetaFrame Presentation Server 3.0 and later versions of MetaFrame Presentation Server include a feature that is named Universal Printer Driver. You can use this feature to handle printing on those versions of MetaFrame Presentation Server.

> [!NOTE]
> Starting with version 4.0, this product is named Citrix Presentation Server.

## Steps to reproduce the problem in Visual FoxPro

1. Start Visual FoxPro.
2. In the Command window, type the following command, and then press **ENTER**:

    `modify file printtest.txt`

    The Editing window appears. The Editing window contains the *Printtest.txt* file. However, this file is empty.

3. In the Editing window, type *Test*.
4. On the **File** menu, click **Print**. The **Print** dialog box appears.
5. In the **Print** dialog box, click **Print**. You receive the following error message:

    > Error 125: Printer is not ready

6. Create a program (.prg) file that contains the following code, and then run the program file.

    ```console
    create table testtab1 (f1 i, f2 C(15))
    for lni = 1 to 3
    insert into testtab1 (f1, f2) values (lni, sys(2015))
    endfor
    create report printtest from testtab1.dbf
    report form printtest to printer prompt
    ```

7. In the **Print** dialog box, click **Print**. You receive the following error message:

    > Error 1958: Error loading printer driver

## Steps to reproduce the problem in a Visual FoxPro application

1. Start Visual FoxPro.
2. Create a program (.prg) file that contains the following code, and then run the program file.

    ```console
    local lcText
    text to lcText noshow textmerge
    local lni
    * Open the editor.
    modify file printtest.txt
    * Create a table.
    create table testtab1 (f1 i, f2 C(15))
    for lni = 1 to 3
    insert into testtab1 (f1, f2) values (lni, sys(2015))
    endfor
    * Create a report.
    create report printtest from testtab1.dbf
    * Print the report.
    report form printtest to printer prompt
    endtext
    * Create a .prg file.
    =StrToFile(lcText, "testxx.prg" )
    * Build a project by using the .prg file.
    build project testxx from testxx.prg
    * Build and then run an executable file.
    build exe testxx from testxx
    run /n testxx.exe
    return
    ```

   The Visual FoxPro application starts. When the application starts, the Editing window appears.
3. In the Editing window, type *Test*.
4. On the **File** menu, click **Print** to print the contents of the Editing window.
5. In the **Print** dialog box, click **Print**. You do not receive an error message. However, the print job does not print. Close the Editing window.
6. In the **Print** dialog box, click **Print** to print the report. You receive the following error message:

    > Error 1958: Error loading printer driver

For more information about software update terminology, see [Description of the standard terminology that is used to describe Microsoft software updates](https://support.microsoft.com/help/824684)

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, regarding the performance or reliability of these products.
