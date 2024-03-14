---
title: Guidelines that support professionals use
description: Describes the guidelines we use to determine when a support case becomes a consulting engagement.
ms.reviewer: theley, kyouells
ms.date: 03/13/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# Guidelines that Microsoft support professionals use to determine when a support case becomes a consulting engagement

This article describes the guidelines that Microsoft support professionals use to determine when a support case becomes a consulting engagement.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 850201

## Introduction

Microsoft support professionals use to determine when a support case becomes a consulting engagement for the following items:

- Report Writer in Microsoft Dynamics GP
- Microsoft SQL Server Reporting Services (SSRS)
- Word Template in Microsoft Dynamics GP
- SmartList Builder in Microsoft Dynamics GP
- SmartList Designer in Microsoft Dynamics GP 2013 SP2
- SQL scripts (including Business Alerts)
- Integration Manager VB Script customizations
- Modifier/VBA Customizations
- Configurator File setup for eBanking modules (RM EFT, PM EFT, SafePay, Lockbox, Electronic Reconcile)
- Extender in Microsoft Dynamics
- Workflow

## More information

> [!NOTE]
> Typically, if the engineer spends more than 30 minutes on the issue, they will ask for an advisory/consulting service to be opened to continue assisting with the customization. Consulting services are handled through the Partner and can be opened by having the Partner send an email to the Microsoft Partner Advisory team.

> [!IMPORTANT]
> Advisory requests are no longer being accepted by Microsoft Dynamics GP Support. Support engineers will do the best they can to help you within a regular support case, within reason. However, they may use their judgement when to discontinue helping and close the case. (If they worked more than one hour on your issue, the case will remain chargeable, even if the issue is not resolved.) For any complex modifications or customizations, you must search for an ISV on your own for further assistance. Here is a link to help you search:
>
> [Dynamics ISV central](http://www.isv-central.com/search/products.aspx)

## Report Writer

- We offer step-by-step assistance for the following functions in a support case:
  - One table link per report
  - One calculated field
  - One header or footer
  - One restriction per reportIf you need help for more than one of each function, the support case becomes a consulting engagement.
- A support case that requires the removal of temporary tables from a report is automatically considered a consulting engagement. The removal of these tables frequently involves the deletion of restrictions, of fields, and of calculated fields. The removal of these tables also frequently involves other table linking to completely remove the temporary table. For example, a support case that involves edit lists or posting journals is automatically considered a consulting engagement.
- A reporting question that takes more than 30 minutes to test and to explain is considered a consulting engagement.
- If your reporting needs require a custom report, we can offer the following assistance:
  - We can help you determine the main table.
  - We can explain the files that must be linked to the main table.
  - We can provide information about the sorts, the headers, the footers, and the restrictions that you may have to add.
  
However, any request for step-by-step information or detailed steps becomes a consulting engagement.

## Microsoft SQL Server Reporting Services (SSRS)

- We offer step-by-step assistance for the following functions in a support case:
  - Add a data field on a report from an existing dataset
  - Modify the default value for a parameterIf you need help for adding more than one data field from an existing dataset or for adding extra data to the report that doesn't exist in the datasets in the canned report in required format, then the support case becomes a consulting engagement.
- A support case that requires addition/modification of parameters is considered a consulting engagement.
- A reporting question that takes more than 30 minutes to test and to explain is considered a consulting engagement.
- If your reporting needs require a custom report, we can offer the following assistance:
  - We can help you determine which table(s) would have the main data.
  - We can explain the tables that which need to be linked.
- However, any request for step-by-step information or detailed steps becomes a consulting engagement.

## Word Templates in Microsoft Dynamics GP 2010

We offer step-by-step assistance for the following functions in a support case:

- How to add one field to the Word Template Document from the Field List.
- How to format one field on the Word Template (May require referral to Word Team).
- How to add one Image to the Template.
- How to split one cell on the Word Template (May require referral to Word Team).
- How to add/remove one row/column on the Template (May require referral to Word Team).
  
If you need help for more than one of each function, the support case becomes a consulting engagement or you can create a new request for each other field you need assistance with.

- A support case that requires the removal, addition, or positioning of Word tables or sections on a Template is automatically considered a consulting engagement.
- A support case that requires custom Word functions on the Template is automatically considered a consulting engagement.
- A Template question that takes more than approximately 30 minutes to test and to explain is considered a consulting engagement. It wouldn't include the time for assistance on the Report Write report (See Report Writer Section Above).
- If your Template needs require a custom Template, we can offer the following assistance:
  - We can help you determine the tables needed in Report Writer to populate the data on the Word Template.
  - We can explain how to re-create the xml data file so the existing Template can be used with the additions/changes in Report Writer.
  
 However, any request for step-by-step information or detailed steps on a custom Template becomes a consulting engagement.

## SmartList Builder

> [!NOTE]
> Support for SmartList Builder in **Microsoft Dynamics GP 2013 R2** (build 21 for Product ID 3830 [in the DU000020 table]) **and later versions** has went back to the ISV. Contact **eOne** for assistance with SmartList Builder in Microsoft Dynamics GP 2013 R2 and later versions. Their contact information is:  
     Email: `support@eonesolutions.com`  
     Phone: 888-319-3663

For **Microsoft Dynamics GP 2013 SP2 and prior versions,** SmartList Builder is supported by Microsoft Dynamics GP Support using the same criteria as defined in the [SmartList Designer](#smartlist-designer) section below.  

## SmartList Designer

We offer step-by-step assistance for the following functions in a support case:

- One table link to a SmartList Designer query

    > [!NOTE]
    > If you're linking data from Extender to a SmartList Designer query, you may have to add two table links. In this case, we provide step-by-step assistance to add both table links.
- One "Go To" element for a SmartList Designer query
- One Restriction element for a SmartList Designer query
- One Calculation element for a SmartList Designer queryWe also provide step-by-step assistance to help you configure SmartList Designer security.

If you need help for more than one of each function, the support case becomes a consulting engagement.

SmartList Designer services that include a consulting engagement are subject to a one-hour minimum charge. Support professionals will try to create the customization that you request. However, some customizations can't be created because of limitations in SmartList Builder or because of how data is stored in the database tables. So some customizations may not meet your exact specifications.

We support SmartList Designer queries that are customized for use with Microsoft Dynamics GP and with dictionaries that integrate with Microsoft Dynamics GP. These dictionaries include the following ones:

- Human Resources
- Manufacturing
- Fixed Assets

We don't support the customization of third-party products, such as dictionaries, tables, and views. We don't support the customization of third-party products because Microsoft may not be familiar with the table structures in the third-party products.

## SQL scripts, Views, and Business Alerts

In a support case, we can provide information about the following attributes so that you can create your own SQL scripts, views, and Business Alerts:

- Table names
- Column names
- Field values

However, if you need help with writing the SQL script, view or Business Alert, the support case becomes a consulting engagement. A request that takes more than 30 minutes to test and explain is considered a consulting engagement.

> [!NOTE]
> A blog article is available with sample SQL Views for various modules and could save you a lot of time: [Microsoft Dynamics GP SQL Views for Smartlist Designer to Enhance Reporting](https://community.dynamics.com/blogs/post/?postid=fe83b706-7a65-489a-86de-cfbf19587ad2)

## Integration Manager VB Script customizations  

We offer the following within a support case:

- We can assist with Break/Fix for any script that is in the Integration Manager Script library or in the Integration Manager User's Guide.
- A script requiring more than 30 minutes to test is considered a consulting engagement (it includes a custom script or editing of an existing script in the Integration Manager script library)

### Modifier/VBA Customizations

We offer the following within a support case:

- We can assist with Break/Fix for any sample that is available on the CustomerSource/PartnerSource sample downloads page.
- Customizations coming from unsupported methods as found in community forums or blogs aren't supported by Microsoft Technical support. Contact the forum or blog author for assistance with these types of issues.

### Configurator File setup for eBanking modules

The eBanking configurator files include:

- Electronic Funds Transfer (EFT) for Payables Management
- Electronic Funds Transfer (EFT) for Receivables Management
- Safe Pay
- Lockbox for Receivables Management
- Electronic Reconcile for Bank Reconciliation

We can assist with the following in a support case:

- Step-by-step assistance to set up one specific field within the configurator file per support case
- Troubleshoot one specific error message generated from Microsoft Dynamics GP
- Troubleshoot one specific error message from the bank, provided you understand from your bank what the message means

When the support case becomes a consulting engagement:

- If you need step-by-step assistance to configure more than one specific field within the configurator file
- If you need step-by-step assistance to set up a configurator file from scratch or interpret the bank's requirement documentation
- If you need step-by-step assistance troubleshooting more than one specific error message generated from Microsoft Dynamics GP
- If you need step-by-step assistance troubleshooting more than one specific error message from the bank
- If you need a Microsoft Dynamics GP Support Engineer to engage in a phone call with your bank
- If assistance has exceeded 30 minutes for an unsupported or custom format or field.

### Extender

We offer the following assistance within a support case:

- Create one calculated field on a single report in Report Writer.
- Configure an existing Extender object.
- Link an Extender object to a SmartList.
- Create an Extender View.
 When the support case becomes a consulting engagement:
- Data fixing is required.
- Configuring more than one calculated field on a single report in Report Writer.
- Creating an Extender object from start to finish.

### Workflow

If you would like to create a condition for your workflow that isn't in Microsoft Dynamics GP by default, you can use the [Joining in Additional Tables for Workflow Conditions](https://community.dynamics.com/blogs/post/?postid=878cf128-45ad-497d-b586-c7b57df6251c) tool to help with the development of new workflow types or modifications of existing workflow types. This tool is supported in Microsoft Dynamics GP 2015 (14.00.0817) and later versions. Support will be limited to creating one single line in a condition. If your customization for workflow takes more than 30 minutes to test and explain, it's considered a consulting service at the discretion of the Microsoft Engineer.

> [!NOTE]
> Review [Microsoft Dynamics GP Workflow 2.0 AND & OR conditions when setting up approval steps.](https://community.dynamics.com/blogs/post/?postid=a487f20b-e595-4ecd-b51b-81aae053a1e0) to help with `And/Or` statements in workflow conditions.

## Additional information

For more information about consulting engagements that involve Report Writer, SmartList Builder, SmartList Designer, SSRS, or SQL script/view customizations, use one of the following methods, depending on whether you're a customer or a partner:

- Customers

    For more information about consulting services, contact your partner of record. If you don't have a partner of record, visit [Microsoft Partner Center](https://partnercenter.microsoft.com/pcv/search) to identify a partner.

- Partners

    For more information about consulting services, contact Microsoft Advisory Services at 800-MPN-SOLVE.

> [!IMPORTANT]
> Advisory requests are no longer being accepted by Microsoft Dynamics GP Support. You must search for an ISV on your own to assist with any customizations. Here is a link to help you search:
>
> [Dynamics ISV central](http://www.isv-central.com/search/products.aspx)
