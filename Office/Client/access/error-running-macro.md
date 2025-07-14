---
title: Unable to run macro in Access database
description: Fixes an issue in which you can't run a macro that calls a VBA function in an Access database.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CI 114797
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Access for Microsoft 365
  - Access 2019
  - Access 2016
  - Access 2013
  - Access 2010
  - Microsoft Office Access 2007
search.appverid: MET150
ms.date: 05/26/2025
---
# "Action Failed Error Number: 2950" error when running a macro that calls a VBA function in an Access database

_Original KB number:_ &nbsp; 931407

> [!NOTE]
> If you are a Small Business customer, find additional troubleshooting and learning resources at the [Support for Small Business](https://smallbusiness.support.microsoft.com) site.

## Symptoms

When you run a macro that calls a Microsoft Visual Basic for Applications (VBA) function in a Microsoft Office Access 2007 or later database, you receive the following error message:

> Action Failed  
> Macro Name: **MacroName**  
> Condition: **Condition**  
> Macro Name: RunCode  
> Arguments: **Arguments**  
> Error Number: 2950

## Cause

This issue occurs if the database is not trusted by Access. By default, recent versions of Access open databases that are not trusted in Disabled mode. In Disabled mode, executable content is disabled.

## Resolution

If you trust the author of the database, and if you want to enable the database, use one of the following methods.

### Method 1: Enable the database for the current session

When you use this method, Access enables the database until you close the database. To enable the database for the current session, follow these steps:

1. On the Message Bar, click **Options**.
2. In the **Microsoft Office Security Options** dialog box, click **Enable this content**, and then click **OK**.

> [!NOTE]
> Depending on your Access version, you may need to repeat these steps every time that you open the database.

### Method 2: Move the database to a trusted location

To do this, follow these steps:

1. Determine trusted locations to which you can move the database. To do this, follow these steps:
   1. Click **File**, and then click **Options**.
   2. Click **Trust Center**, and then click **Trust Center Settings** under **Microsoft Office Access Trust Center**.
   3. Click **Trusted Locations**, and then use one of the following procedures:

      - Note the paths of the trusted locations that are listed.
      - Add a new trusted location. To do this, click **Add new location**, and then specify the path of the location that you want to add.

2. Move the Access database to the trusted location that you specified.

## More Information

You can use an `AutoExec` macro to test whether a database is trusted when you open the database. Additionally, the macro can open a form that displays a customized message to users if the database is not trusted. This message lets users know that the database must be enabled or trusted for the code to run successfully.

To create the `AutoExec` macro and the form, follow these steps:

1. Create a new form in Design view.
2. Add a text box or a label to the form, and then type the information that you want to display to the user.
3. Save and then close the form.
4. Create a macro, and then name the macro `AutoExec`.
5. Show the **Conditions** column.
6. Type the following line in the **Conditions** column:

   `CurrentProject.IsTrusted = False`

7. In the **Actions** column, click **OpenForm**.
8. In the **Form Name** box under **Action Arguments**, click the form that you created in step 1.
9. Save and then close the macro.

When the database opens, the `AutoExec` macro starts and then tests the
`IsTrusted` condition. If the database is not trusted by Access, the macro opens the form that you specified in the `OpenForm` action of the macro.
