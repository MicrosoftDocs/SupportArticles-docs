---
title: Reset the page number on a group level in a report
description: Describes methods for designing a report that breaks the page for each new entry in a group and resetting the page number of the report.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
ms.custom: 
  - CI 111294
  - CSSTroubleshoot
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: V-SHIRAP
appliesto: 
  - Access 2007
ms.date: 06/06/2024
---

# How to reset the page number on a group level in an Access report

Moderate: Requires basic macro, coding, and interoperability skills.

This article applies to a Microsoft Access database (.mdb or .accdb) and to a Microsoft Access project (.adp).

## Summary

When you modify the section properties of a report, you can design a report that breaks the page for each new entry in a group and then resets the page number of the report. For example, the Employee Sales by Country/Region report in the sample database Northwind.mdb is designed with this feature.

## More information

> [!NOTE]
> The method that is used to reset the page number for each new country/region depends on whether you want to display the page number in the page header or in the page footer. If you use the wrong method, the page number is not reset correctly.

### Method 1: The page number appears in the page footer

1. Start Access and then open the sample database Northwind.mdb or the sample project NorthwindCS.adp.   
2. Open the Employee Sales by Country/Region report in Design view.   
3. Click the **Country/Region Header** section, right-click the **On Format** property, and then click **Build**.

   Examine the event procedure.   
4. Click the **Country/Region Footer** section, right-click the **On Format** property, and then set the **ForceNewPage** property to **After Section**.   

### Method 2: The page number appears in the page header

1. Start Access and then open the sample database Northwind.mdb or the sample project NorthwindCS.adp.   
2. Open the Employee Sales by Country/Region report in Design view.
3. Click the **Country/Region Footer** section, right-click the **On Format** property, and then click **Build**.   
4. Click **Code Builder**, and then click **OK**.   
5. In the Code window, type: Page = 0   
6. Change the OnFormat event of the Country/Region Header so that the Page property is not set in this event. To do this type an apostrophe before the line with the starting page number.

    The code will look similar to the following code:

    ```vb
    Private Sub GroupHeader0_Format(Cancel As Integer, FormatCount As Integer)
    ' Set page number to 1 when a new group starts.
        ' Page = 1
    End Sub 
    ```

7. Click the **Page Header** section, set the Height property to 0.25, and then set the Back Color property to 8421504.   
8. Move the control that is named Page Number to the Page Header.

   The Page Number control displays the page number. 

When you use either of these methods, each country/region begins on a new page, and the numbering of each new section begins with the number 1.
