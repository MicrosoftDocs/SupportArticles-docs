---
title: How to use Outlook Object Library to get message from Inbox
description: Explains how to retrieve a message from the Inbox in a Visual C# project by using the Outlook 2002 Object Library or the Outlook 2003 Object Library. This article also provides a code sample to illustrate how to perform this task.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
appliesto:
- Microsoft Office Outlook 2003
search.appverid: MET150
ms.reviewer: v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/30/2024
---
# How to use the Microsoft Outlook Object Library to retrieve a message by using Visual C# from the Inbox

## Introduction

This article describes how to use the Microsoft Outlook 2002 Object Library or the Microsoft Office Outlook 2003 Object Library to retrieve a message from the Inbox by using Microsoft Visual C#.

## More information

To use the Outlook 2002 Object Library or the Outlook 2003 Object Library to retrieve a message from the Inbox by using Visual C#, follow these steps:

1. In Microsoft Visual Studio .NET or Visual Studio 2005, create a new Console Application project:

   1. On the **File** menu, point to **New**, and then select **Project**.
   2. Under **Project Types**, select **Visual C# Projects**.

      > [!NOTE]
      > In Visual Studio 2005, select **Visual C#**.
   3. Under **Templates**, select **Console Application**.
   4. Select **OK**. By default, a file that is named _Class1.cs_ is created.

      > [!NOTE]
      > In Visual Studio 2005, Program.cs is created by default.

2. Add a reference to either the Outlook 2002 Object Library or the Outlook 2003 Object Library. To do this, follow these steps:

   1. On the **Project** menu, select **Add Reference**.
   2. Select the **COM** tab.
   3. On the **COM** tab, select **Microsoft Outlook 11.0 Object Library** if you are using Outlook 2003, or select **Microsoft Outlook 10.0 Object Library** if you are using Outlook 2002.
   4. Select **Select**.
   5. In the **Add References** dialog box, select **OK**.

      > [!NOTE]
      > If you receive a message to generate wrappers for the libraries that you selected, select **Yes**.

3. In the Class1.cs code window, replace all the existing code with the following code:

    ```cs
    using System;
    using System.Reflection; // to use Missing.Value
    
    //TO DO: If you use the Microsoft Outlook 11.0 Object Library, uncomment the following line.
    //using Outlook = Microsoft.Office.Interop.Outlook;
    
    namespace ConsoleApplication1
    {
    public class Class1
    {
    public static int Main(string[]args)
    {
    try
    {
    // Create the Outlook application.
    // in-line initialization
    Outlook.Application oApp = new Outlook.Application();
    
    // Get the MAPI namespace.
    Outlook.NameSpace oNS = oApp.GetNamespace("mapi");
    
    // Log on by using the default profile or existing session (no dialog box).
    oNS.Logon(Missing.Value,Missing.Value,false,true);
    
    // Alternate logon method that uses a specific profile name.
    // TODO: If you use this logon method, specify the correct profile name
    // and comment the previous Logon line.
    //oNS.Logon("profilename",Missing.Value,false,true);
    
    //Get the Inbox folder.
    Outlook.MAPIFolder oInbox = oNS.GetDefaultFolder(Outlook.OlDefaultFolders.olFolderInbox);
    
    //Get the Items collection in the Inbox folder.
    Outlook.Items oItems = oInbox.Items;
    
    // Get the first message.
    // Because the Items folder may contain different item types,
    // use explicit typecasting with the assignment.
    Outlook.MailItem oMsg = (Outlook.MailItem)oItems.GetFirst();
    
    //Output some common properties.
    Console.WriteLine(oMsg.Subject);
    Console.WriteLine(oMsg.SenderName);
    Console.WriteLine(oMsg.ReceivedTime);
    Console.WriteLine(oMsg.Body);
    
    //Check for attachments.
    int AttachCnt = oMsg.Attachments.Count;
    Console.WriteLine("Attachments: " + AttachCnt.ToString());
    
    //TO DO: If you use the Microsoft Outlook 10.0 Object Library, uncomment the following lines.
    /*if (AttachCnt > 0) 
    {
    for (int i = 1; i <= AttachCnt; i++) 
     Console.WriteLine(i.ToString() + "-" + oMsg.Attachments.Item(i).DisplayName);
    }*/
    
    //TO DO: If you use the Microsoft Outlook 11.0 Object Library, uncomment the following lines.
    /*if (AttachCnt > 0) 
    {
    for (int i = 1; i <= AttachCnt; i++) 
     Console.WriteLine(i.ToString() + "-" + oMsg.Attachments[i].DisplayName);
    }*/
    
    //Display the message.
    oMsg.Display(true); //modal
    
    //Log off.
    oNS.Logoff();
    
    //Explicitly release objects.
    oMsg = null;
    oItems = null;
    oInbox = null;
    oNS = null;
    oApp = null;
    }
    
    //Error handler.
    catch (Exception e)
    {
    Console.WriteLine("{0} Exception caught: ", e);
    }
    
    // Return value.
    return 0;
    
    }
    }
    }
    ```

4. In this code, make any necessary changes where you see the "TO DO" comments.
5. Press F5 to build and then run the program.

## References

For more information, see [Microsoft Office Development with Visual Studio](/previous-versions/office/developer/office-xp/aa188489(v=office.10)).
