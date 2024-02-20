---
title: Home pages and area pages features
description: This article describes the answers to some of the most frequently asked questions about home pages and area pages in Microsoft Dynamics GP.
ms.reviewer: theley
ms.date: 02/20/2024
---
# Frequently asked questions about the home pages and area pages features in Microsoft Dynamics GP

This article describes the answers to some of the most frequently asked questions about home pages and area pages in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 918313

## Introduction

This article contains answers to frequently asked questions about the home pages feature and the area pages feature that are included in Microsoft Dynamics GP.

## Home pages in Microsoft Dynamics GP

- **Q1: What occurs when I select an industry and then select a role? Are the home pages different for the different industries?**

  A1: The default settings for home pages are the same regardless of the industry. However, home pages use specific industry information to provide a refined list of roles to the user. This refined list enables users to find applicable roles more easily.

- **Q2: After I select a home page role, can I change the role?**

  A2: Yes. In the upper-right corner of the home page, click **Customize this page**, and then click **Change Role**.

- **Q3: If I change roles, what information is removed?**

  A3: The home page layout is changed. This change includes the order of the areas on the home page and whether these areas are turned on or are turned off. Specifically, you experience the following behavior:

  - The **Microsoft Office Outlook** area, the **Quick Links** area, and the **Metrics** area are changed.
  - The **My Reports** area is not changed.
  - Reminder settings for the new role are added to the **Reminders** area. However, existing reminders are not removed.

- **Q4: What determines the timing of the home page refresh operation in Microsoft Dynamics GP? How does this timing affect resource usage?**

  A4: After a user logs on to Microsoft Dynamics GP, the home page refreshes every 60 minutes. Therefore, as long as all users do not log on at the same time, the refresh operation is staggered. Therefore, Microsoft Dynamics performance is not adversely affected.

  The amount of resources that are required for the home page depends on the options that are configured for a particular user. More reminders, tasks, and metrics on the home page require an increased amount of resources during the home page refresh operation. Metrics items are the most resource-intensive items.

- **Q5: If a user makes a change to a home page, are the settings for the particular role changed?**

  A5: No. When a user makes a change to a home page, the change only applies to that particular user.

- **Q6: Can the Administrator assign a role to all users?**

  A6: The Administrator can log on to Microsoft Dynamics GP as each user, and then select the role for each user. To log on by using each user ID, the Administrator must have the password for each user. The Administrator can also run the following script to automatically set the role for all users who do not have a role assigned. These users have the Blank home page assigned. This script also sets the options so that the home page does not display at logon, and the home page does not refresh after an hour.

    ```sql
    USE DYNAMICS
    set nocount on
    declare @Userid char(15)
    declare cDispHP cursor for  
    select A.USERID
    from SY01400 A left join SY08000 B on A.USERID = B.USERID
    where B.USERID is null or B.DISPHP <> 0
    open cDispHP
    while 1 = 1
    begin
    fetch next from cDispHP into @Userid
    if @@FETCH_STATUS <> 0 begin
    close cDispHP
    deallocate cDispHP
    break
    end
    
    if exists (select DISPHP from DYNAMICS.dbo.SY08000 where USERID = @Userid)
    begin
    print 'adjusting ' + @Userid
    update DYNAMICS.dbo.SY08000
    set DISPHP = 0
    where USERID = @Userid
    end
    else begin
    print 'adding ' + @Userid
    insert DYNAMICS.dbo.SY08000 ( USERID, DISPHP, REFRSHHP, User_Role )
    values ( @Userid, 0, 0, 121 )
    end
    end /* while */
    set nocount off
    ```

- **Q7: Can the Administrator lock down the home page so that users cannot customize it?**

  A7: The Administrator can revoke security access to the **Customize Home Page** dialog box. This prevents users from customizing the home page and from customizing each area of the home page. Therefore, users cannot add an area to the home page. Also, users cannot remove an area from the home page.

  To revoke the security access in Microsoft Dynamics GP 9.0, follow these steps:

    1. Click **Tools**, click **Setup**, click **System**, and then click **Security**.
    2. In the **User ID** area, select the user ID.
    3. In the **Company** area, select the company database.
    4. In the **Type** area, select **Windows**.
    5. In the **Series** area, select **System**.
    6. Double-click **Customize Home Page** to remove access to the window.
    7. Click **OK**.

  To revoke the security access in Microsoft Dynamics GP 10.0 and Microsoft Dynamics GP 2010, follow these steps:

    1. On the **Microsoft Dynamics GP** menu, click **Tools**, click **Setup**, click **System**, and then click **Security Tasks**.
    2. In the **Task ID** area, select the **DEFAULTUSER**.
    3. In the **Product** area, select **Microsoft Dynamics GP**.
    4. In the **Type** area, select **Windows**.
    5. In the **Series** area, select **System**.
    6. Click to clear the **Customize Home Page** check box to remove access to the window.
    7. Click **OK**.

    > [!NOTE]
    > By default, access to the Customize Home Page window is granted to the DEFAULTUSER security task. These steps revoke access to this window in the DEFAULTUSER security task. If another security task grants access to this window, you must follow these steps for that security task.

- **Q8: Can I create new roles for the home page?**

  A8: Yes. You can create new roles by using a Dexterity customization. For more information about how to create new roles, see the Integration Guide manual (IG.pdf) that is installed with Dexterity.

- **Q9: How can I disable the home page?**

  A9: For information about how to disable the home page, see [How to disable the home page feature in Microsoft Dynamics GP](https://support.microsoft.com/help/917998).

- **Q10: How do I disable the Microsoft Office Outlook content from the home page for all users?**

  A10: Run the following script from SQL Query Analyzer, from the Support Administrator Console, or from Microsoft SQL Server Management Studio.

    ```sql
    UPDATE A SET COLNUMBR = 0, SEQNUMBR = 0, Visible = 0 
    FROM DYNAMICS.dbo.SY08100 A WHERE (SectionID = 2) AND (DICTID = 0) AND ((COLNUMBR <> 0) OR (SEQNUMBR <> 0) OR (Visible <> 0))
    ```
- **Q11: How does the home page integrate with security?**

  A11: The **Quick Links** area, the **Reminders** area, the **My Reports** area, and the **Metrics** area integrate with the Microsoft Dynamics GP security. If a user does not have access to a window, that window is not listed in the **Quick Links** area. If a user does not have access to the Reminder Smart List, the reminder is not displayed in the **To Do** area. Also, the metrics that appear in the **Metrics** area are controlled by the window security settings.

- **Q12: If I change my home page role, are my security settings affected?**

  A12: No. When a user changes a role, only the default settings that Microsoft Dynamics GP creates for the user are changed. These default settings are then filtered according to the particular user's security settings.

- **Q13: Can I create new metrics, add to Quick Links, and add to My Reports for the home page?**

  A13: Yes. You can perform all these tasks by using a Dexterity customization. For more information about how to perform these tasks, see the Integration Guide manual (IG.pdf) that is installed with Dexterity.

- **Q14: If I click in the Metrics area, I can modify the displayed graph. However, when the home page is refreshed, my changes are not saved. Can I save my changes to the metrics graph?**

  A14: Currently, you cannot save changes to the graph in the **Metrics** area.

- **Q15: How is the SQL Server Reporting Services reports activated for the Microsoft Dynamics GP home page?**

  A15: In order to display the SQL Server Reporting Services reports in the Metrics part of the Microsoft Dynamics GP home page, you need to do the following:

    1. Use the SQL Server Reporting Services Wizard for Microsoft Dynamics GP to deploy the reports in the 'Charts and KPIs' series to your report site.
    2. Open the Reporting Tools Setup window in Microsoft Dynamics GP and enter the URL to your Report Server site in SQL Server Reporting Services tab the using the following format:

        `http://servername:port/ReportServer/ReportService2005.asmx`

       > [!NOTE]
       > You need to check the 'Enable SQL Server Reporting Services Home Page Metrics' option on this window.

    3. Go to the home page and click **Customize this page...**.
    4. Click to select in **Metrics**.
    5. Click on the blue expansion button beside **Metrics** and select the SQL Server Reporting Services reports to list on your home page.

        > [!NOTE]
        > You will need permission to run these reports in SQL Server Reporting Services in order for them to display on the Microsoft Dynamics GP 2010 home page.

- **Q16: When I start Microsoft Dynamics GP on a terminal server, I receive the following error message on the home page: The XML page cannot be displayed**

  > Cannot view XML input using XSL style sheet. Please correct the error and then click the Refresh button, or try again later.
  >
  > Access is denied. Error processing resource 'file:///C:/Program Files/Microsoft Dynamics/GP/Background/HomePage.xsl'.

  What causes this error message?

  A16: This issue occurs if roaming profiles are configured for the users. Specifically, this issue occurs because of the way in which the user profile Temp folders are mapped. To resolve this issue, reconfigure the roaming profile to remove the Temp folder from the shared network location. A user's roaming profile must be configured to use the local computer's Temp folder. The roaming profile must not be configured to use a shared network location.

- **Q17: When I start the home page, I receive the following error message in the Metrics area:**

  Metrics are not available because Microsoft Office Chart

  What causes this error message?

  A17: This problem is documented in the following Microsoft Knowledge Base article:

  [Error message when you view the home page in Microsoft Dynamics GP: "Metrics are not available because Microsoft Office Chart..."](https://support.microsoft.com/help/916673)

- **Q18: When I start Microsoft Dynamics GP, the home page displays the XML code for the home page.**

  A18: To resolve this issue, follow these steps:

    1. Exit Microsoft Dynamics GP.
    2. Click **Start**, click **Run**, type cmd in the **Open** box, and then click **OK**.
    3. At the command prompt, type *regsvr32 MSXML3.dll*, and then press ENTER.
    4. Start Microsoft Dynamics GP.

    Additionally, make sure that the following items are installed on the computer on which you experience this issue:

  - The Microsoft Office Web Components

      > [!NOTE]
      > If you are running the 2007 Office programs, install the Office Web Components for Office 2003. If you are running Office 2000, install the Office Web Components for Office XP.

  - The latest version of the Microsoft XML Parser (MSXML)

    To obtain the latest version of MSXML, follow these steps:

    1. Visit the following Microsoft Web site: [Download Center](https://www.microsoft.com/download/default.aspx).

    2. In the box to the right of the **Search** list, type XML Parser, and then click **Go**.

- **Q19: When I start Microsoft Dynamics GP, I may receive one or both of the following error messages:**

  - Error Message 1

  > An error has occurred in the script on this page. Line: **XXX** Char 6 Error Object doesn't support this property or method Code: 0 URL file:///C:/Documents%20and%20Settings/ **XXX** /Local%20Settings/Temp/HomePage.xml Do you want to continue running scripts on this page?

  - Error Message 2

  > Metrics are not available because Microsoft Office Chart

  > [!NOTE]
  > Error Message 2 appears in the Metrics area.

  A19: This problem occurs when the Microsoft Office Web Components are not installed. The Microsoft Office Web Components are required for the metric feature of the Microsoft Dynamics GP home page. If the computer has a Microsoft Office 2000 program or a Microsoft Office XP program installed, use the Office Web Components for Office XP. If the computer has a Microsoft Office 2003 program or a 2007 Microsoft Office program installed, use the Office Web Components for Office 2003.

- **Q20: How can reminders be removed from the home page?**

  A20: To remove reminders from the home page, use the appropriate method:

  - Method 1: Remove security for all reminders on the home page

    1. Log on to Microsoft Dynamics GP as the sa user.
    2. Select a company to log on to.
    3. Point to **Tools**, point to **Setup**, point to **System**, and then click **Advanced Security**.
    4. Click the user for whom you who want to remove all reminders from the home page.
    5. In the **Navigation** pane, expand **by Menu**, and then expand **View**.
    6. Click to clear the **by Reminders** check box to remove access to reminders on the home page.
    7. Click **Apply**.
    8. Click **OK** to close.

  - Method 2: Remove security for custom reminders that are created in SmartList on the home page

    1. Log on to Microsoft Dynamics GP as the sa user.
    2. Select a company to log on to.
    3. Point to **Tools**, point to **Setup**, point to **System**, and then click **Advanced Security**.
    4. Click the user for whom you who want to remove custom SmartList reminders from the home page.
    5. In the **Navigation** pane, expand **by SmartList**.
    6. Click to clear the check box that is under the SmartList object to which you want to remove access. For example, click to clear the check box that is under **Customers Over Credit Limit**.
    7. Click **Apply**.
    8. Click **OK**. The reminder will not appear the next time that the user logs on to Microsoft Dynamics GP.

- **Q21: How do I work around the error messages that I receive an I add a report to the My Reports section of the home page and then try to print the report?**

  After you add a report to the My Reports section of the home page and then try to print the report, you may receive one of the following error messages.

  - Error message 1

  > Unhandled Script Exception: Illegal Address for field 'IsPrinting in script 'PrintReport'. Script Terminated.

  - Error message 2

  > Unhandled script exception: Cannot find report ". EXCEPTION_CLASS_SCRIPT_MISSING SCRIPT_CMD_REPORTDICT"

    > [!NOTE]
    > The error message that you receive depends on the report that you added to the My Reports section.

  A21: This problem is fixed in Microsoft Dynamics GP 10.0 Service Pack 1. To obtain the latest update for Microsoft Dynamics GP 10.0, visit one of the following Microsoft Web sites, depending on whether you are a partner or a customer.

  - [Partners](https://partner.microsoft.com/solutions/business-applications/dynamics-onprem?printpage=false)

  - [Customers](https://mbs2.microsoft.com/Pages/csretirement.aspx?printpage=false)

- **Q22: How do I add a report to the My Reports list on the home page?**

  A22:

    1. Access the report that you want to add to the **My Reports** list on the home page. For example, if you want to add the Item Detailed List, follow these steps:

        1. Click **Reports**, click **Inventory**, and then click **Item**.
        2. In the Inventory Item Reports window, click **New** if you are creating a new report, or select one of the available report options.
        3. To open the Inventory Item Report Options window, click **Modify**.

    2. In the Report Options window, click **My Reports** on the Report Options menu bar.
    3. In the "Add to My Reports" window, enter information in the **Name** field, or accept the default information.
    4. To close the window, click **Ok**.
    5. To close the report windows, click the **Close** button. To view the reports in the **My Reports** list on the home page, follow these steps:

        1. To view the home page, click **Home** in the navigation pane, or press CTRL+1.
        2. To open the Customize Home Page window, click the **Customize this page** link at the top of the content pane.
        3. To display the **My Reports** list on the home page, click the **My Reports** option.
        4. To save the changes, click **OK**, and then close the Customize Home Page window.
        5. On the home page, expand **My Reports**. You will see the new report that you added to the **My Reports** list.

- **Q23: How do I remove the Outlook, Metrics, or To Do: Reminders areas of the home page for new users?**

  A23: To remove the **Outlook**, **Metrics**, or **To Do: Reminders** areas of the home page for new users, follow these steps:

  1. Access the System Preferences window. To do this, click **Microsoft Dynamics GP**, click **Tools**, click **Setup**, click **System**, and then click **System Preferences**.

  2. In the **Home Page Defaults** section, click to clear the **Load To Do: Reminders**, **Load Metrics**, or **Load Microsoft Office Outlook** check boxes.

    > [!NOTE]
    > This does not affect the existing users. This affects only new users who are created after you change these settings. See question and answer 13 if you have to disable the Outlook part of the home page for the existing users.

- **Q24: When you click the expand and collapse drop-down arrows on the homepage or area page, you receive the following error message:

    > Internet Explorer Script Error**
    >
    > An error has occurred in the script on this page
    > Line: 320
    >
    > Char: 6
    >
    > Error: The system cannot find the file specified  
    Code: 0  
    URL: file:///D:/Documents%20and%20Settings/gptestuser/Local%20Settings/Temp/1/tmp10.tmp  
    Do you want to continue running scripts on this page?

  A24: The users are using Terminal Server, and the UserData folder does not exist in the %appdata%\Microsoft\Internet Explorer\ folder. Create the UserData folder in that location.

## Area pages in Microsoft Dynamics GP

- **Q1: When you open a Personalized List in Microsoft Dynamics GP, there are no check boxes next to each item. Therefore, you cannot select an item.**

  A1: This issue occurs because the DPI settings are not set to **Normal size (96 DPI)**. If you use Windows XP, follow these steps:

    1. Right-click the desktop, and then click **Properties**.
    2. Click the **Settings** tab, and then click **Advanced**.
    3. Click the **General** tab.
    4. Under **Display**, click **Normal size (96 DPI)** in the **DPI setting** list.
    5. Click **OK** to restart the computer.
    6. Start Microsoft Dynamics GP, and then confirm that the issue is resolved.

  If you use Windows Vista, follow these steps:

    1. Right-click the desktop, and then click **Personalize**.
    2. In the **Personalization** dialog box, click **Adjust font size (DPI)**.

       If you are prompted for an administrator password or for a confirmation, type the password, or click **Continue**.

    3. In the **DPI Scaling** dialog box, click **Default scale (96 DPI) - fit more information**.
    4. Click **OK**.
    5. Click **OK** to restart the computer.
    6. Start Microsoft Dynamics GP, and then confirm that the issue is resolved.
