---
title: How to use the Microsoft Outlook Object Library to retrieve an appointment by using Visual C#
description: Describes how to retrieve an appointment in a Visual C# project by using the Outlook 2002 Object Library or the Outlook 2003 Object Library. This article also provides a code sample to show how to perform this task.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: CSSTroubleshoot
appliesto: 
- Outlook Development
search.appverid: MET150
ms.reviewer: v-six
author: cloud-writer
ms.author: meerak
ms.date: 10/30/2023
---
# How to use the Microsoft Outlook Object Library to retrieve an appointment by using Visual C\#

## Introduction

This article describes how to use the Microsoft Outlook 2002 Object Library or the Microsoft Office Outlook 2003 Object Library to retrieve an appointment by using Microsoft Visual C#.

## More information

To use the Outlook 2002 Object Library or the Outlook 2003 Object Library to retrieve an appointment in a Visual C# .NET project, follow these steps:

1. In Microsoft Visual Studio .NET or in Microsoft Visual Studio 2005, create a new Console Application project:
    1. On the **File** menu, point to **New**, and then select **Project**.
    1. Under **Project Types**, select **Visual C# Projects**.
         > [!NOTE]
         > In Visual Studio 2005, select **Visual C#** under **Project Types**.
    1. Under **Templates**, select **Console Application**.
    1. Select **OK**. By default, a file that is named Class1.cs is created.
        > [!NOTE]
        > In Microsoft Visual C# 2005, Program.cs is created by default.

1. Add a reference to either the Outlook 2002 Object Library or the Outlook 2003 Object Library. To do this, follow these steps:

    1. On the **Project** menu, select **Add Reference**.
    2. Select the **COM** tab.
    3. On the **COM** tab, select **Microsoft Outlook 11.0 Object Library** if you are using Outlook 2003, or select **Microsoft Outlook 10.0 Object Library** if you are using Outlook 2002.
    4. Select **Select**.
        > [!NOTE]
        > In Visual Studio 2005, you do not have to click **Select**.  

    5. In the **Add References** dialog box, select **OK**.
        > [!NOTE]
        > If you receive a message to generate wrappers for the libraries that you selected, click **Yes**.

1. In the Class1.cs code window, replace all the existing code with the following code:

    ```csharp
    using System;
    using System.Reflection; // to use Missing.Value
    
    //TO DO: If you use the Microsoft Outlook 11.0 Object Library, uncomment the following line.
    //using Outlook = Microsoft.Office.Interop.Outlook;
    
    namespace RetrieveAppointment
    {
        /// <summary>
        /// Summary description for Class1.
        /// </summary>
        public class Class1
        {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        public static int Main(string[] args)
        {
        try
        {
        // Create the Outlook application.
        Outlook.Application oApp = new Outlook.Application();
    
    // Get the NameSpace and Logon information.
        // Outlook.NameSpace oNS = (Outlook.NameSpace)oApp.GetNamespace("mapi");
        Outlook.NameSpace oNS = oApp.GetNamespace("mapi");
    
    //Log on by using a dialog box to choose the profile.
        oNS.Logon(Missing.Value, Missing.Value, true, true); 
    
    //Alternate logon method that uses a specific profile.
        // TODO: If you use this logon method, 
        // change the profile name to an appropriate value.
        //oNS.Logon("YourValidProfile", Missing.Value, false, true); 
    
    // Get the Calendar folder.
        Outlook.MAPIFolder oCalendar = oNS.GetDefaultFolder(Outlook.OlDefaultFolders.olFolderCalendar);
    
    // Get the Items (Appointments) collection from the Calendar folder.
        Outlook.Items oItems = oCalendar.Items;
    
    // Get the first item.
        Outlook.AppointmentItem oAppt = (Outlook.AppointmentItem) oItems.GetFirst();
    
    // Show some common properties.
        Console.WriteLine("Subject: " + oAppt.Subject);
        Console.WriteLine("Organizer: " + oAppt.Organizer);
        Console.WriteLine("Start: " + oAppt.Start.ToString());
        Console.WriteLine("End: " + oAppt.End.ToString());
        Console.WriteLine("Location: " + oAppt.Location);
        Console.WriteLine("Recurring: " + oAppt.IsRecurring);
    
    //Show the item to pause.
        oAppt.Display(true);
    
    // Done. Log off.
        oNS.Logoff();
    
    // Clean up.
        oAppt = null;
        oItems = null;
        oCalendar = null;
        oNS = null;
        oApp = null;
        }
    
    //Simple error handling.
        catch (Exception e)
        {
        Console.WriteLine("{0} Exception caught.", e);
        } 
    
    //Default return value
        return 0;
    
    }
        }
    }
    ```

1. In this code, make any necessary changes where you see the "TO DO" comments.

1. Press F5 to build and then run the program. Outlook security features may display additional dialog boxes before the appointment information appears.

## References

For more information, see [Microsoft Office Development with Visual Studio](/previous-versions/office/developer/office-xp/aa188489(v=office.10)).
