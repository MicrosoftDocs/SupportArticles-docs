---
title: Cannot install Dynamics CRM for Microsoft Office Outlook with error
description: The installation of Microsoft Dynamics CRM for Outlook fails during the Initializing Organization phase of the configuration process. Provides a resolution.
ms.reviewer: debrau
ms.topic: troubleshooting
ms.date: 
---
# There is a problem communicating with the Microsoft Dynamics CRM server error when configuring Microsoft Dynamics CRM for Outlook

This article provides a resolution to make sure the Microsoft Dynamics CRM for Outlook can be installed without any error during the Initializing Organization phase of the configuration process.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011, Microsoft Dynamics CRM Mobile, Microsoft Dynamics CRM 2013, Microsoft Dynamics CRM 2015  
_Original KB number:_ &nbsp; 2714083

## Symptoms

When attempting to configure the Microsoft Dynamics CRM for Microsoft Office Outlook, a user receives the following error during the Initializing Organization phase of the configuration process:

> There is a problem communicating with the Microsoft Dynamics CRM server. The server might be unavailable. If the problem persists, contact your system administrator

or

> Cannot configure the organization for Microsoft Dynamics CRM for Outlook. Try to configure the organization again. If the problem persists, contact your system administrator

When you select **Details**, the following additional details are shown:

> An item with the same key has already been added.  
at Microsoft.Crm.Application.Outlook.Config.OutlookConfigurator.InitializeMapiStoreForFirstTime()  
at Microsoft.Crm.Application.Outlook.Config.OutlookConfigurator.Configure(IProgressEventHandler progressEventHandler)  
at Microsoft.Crm.Application.Outlook.Config.ConfigEngine.Configure(Object stateInfo)

## Cause

This issue is caused by duplicate site-map entries in the site-map XML relative to the \<SubArea Id> tag. A duplicate site-map entry will sometimes contain a trailing **(1)** at the end of the title, as seen in the screenshot below:

:::image type="content" source="media/dynamics-crm-for-office-outlook-installation-fails-during-initializing-orgnization/example.png" alt-text="Accounts(1)":::

However, it also possible to experience this error without seeing a duplicated entity name in the web client UI. Instead, the issue may also occur where the \<SubArea Id> tag references the same name, while the Entity parameter is different, as highlighted below:

\<SubArea Id="new_entity" Entity="new_entity"/>

\<SubArea Id="new_entity" Entity="new_otherentity"/>

## Resolution

To fix this issue, follow these steps:

1. In Microsoft Dynamics CRM, select **Settings**, and then select **Solutions**.
2. Select **New**. Enter an appropriate Display Name, Name, Publisher, and Version. Select **Save**.
3. Select **Add Existing** and select **Site Map**.
4. Select **Save** and then select **Export Solution**.
5. Follow the **Export Solution** dialog box and ensure the solution is exported as Unmanaged.
6. Once the solution is exported, unzip the contents of the solution file.
7. In the unzipped folder, right-click customizations.xml, select **Open With**, and select **Notepad**.
8. Based on where the duplicate entry is located in the web client UI, locate and remove the duplicate site-map entry. For example, if the duplicate site-map entry was **Accounts(1)**, and this appeared in the Sales pane, the duplicate entry would appear as below:

    > \<Area Id="SFA" ResourceId="Area_Sales" Icon="/_imgs/sales_24x24.gif" DescriptionResourceId="Sales_Description">  
    > \<Group Id="SFA">  
    > \<SubArea Id="nav_leads" Entity="lead" DescriptionResourceId="Lead_SubArea_Description"  
    > GetStartedPanePath="Leads_Web_User_Visor.html" GetStartedPanePathAdmin="Leads_Web_Admin_Visor.html"  
    > GetStartedPanePathOutlook="Leads_Outlook_User_Visor.html"  
    > GetStartedPanePathAdminOutlook="Leads_Outlook_Admin_Visor.html" />  
    > \<SubArea Id="nav_oppts" Entity="opportunity" DescriptionResourceId="Opportunity_SubArea_Description"  
    > GetStartedPanePath="Opportunities_Web_User_Visor.html" GetStartedPanePathAdmin="Opportunities_Web_Admin_Visor.html"  
    > GetStartedPanePathOutlook="Opportunities_Outlook_User_Visor.html" GetStartedPanePathAdminOutlook="Opportunities_Outlook_Admin_Visor.html" />  
    > \<SubArea Id="nav_accts" Entity="account" DescriptionResourceId="Account_SubArea_Description"  
    > GetStartedPanePath="Accounts_Web_User_Visor.html" GetStartedPanePathAdmin="Accounts_Web_Admin_Visor.html"  
    > GetStartedPanePathOutlook="Accounts_Outlook_User_Visor.html"  
    > GetStartedPanePathAdminOutlook="Accounts_Outlook_Admin_Visor.html" />  
    > \<SubArea Id="nav_accts" Entity="account" DescriptionResourceId="Account_SubArea_Description" GetStartedPanePath="Accounts_Web_User_Visor.html"  
    > GetStartedPanePathAdmin="Accounts_Web_Admin_Visor.html"  
    > GetStartedPanePathOutlook="Accounts_Outlook_User_Visor.html"  
    > GetStartedPanePathAdminOutlook="Accounts_Outlook_Admin_Visor.html" />

    As seen above, the Area ResourceId is **Area_Sales**, while the original and duplicate Site Map entry for **Accounts** is listed in the bolded SubArea Id tags.

9. With the duplicate entry removed, save the customizations.xml file.
10. Repackage the customizations.xml, [Content_Types].xml, and solution.xml into a new zipped file. Select these files, right-click, select **Send To**, and select **Compressed zipped folder**.
11. In Microsoft Dynamics CRM, select **Settings**, and then select **Solutions**.
12. Select **Import**.
13. Select the modified site map solution zip file, select **Next**.
14. Select **Next** on the **Import Solution** dialog box. Select **Publish All Customizations**. Select **Close**.

## More information

If you're still having issues connecting Microsoft Dynamics CRM for Outlook to your Microsoft Dynamics CRM Online organization, a diagnostic tool is available to help diagnose the issue:

[Microsoft Support and Recovery Assistant](/outlook/troubleshoot/performance/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant)
