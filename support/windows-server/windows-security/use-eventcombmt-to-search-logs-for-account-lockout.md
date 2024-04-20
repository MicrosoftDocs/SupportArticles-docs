---
title: How to use the EventCombMT utility to search event logs for account lockouts
description: Describes how to use the EventCombMT utility (EventCombmt.exe) to search the event logs of multiple computers for account lockouts.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, mikeres
ms.custom: sap:Windows Security Technologies\Account lockouts, csstroubleshoot
---
# How to use the EventCombMT utility to search event logs for account lockouts

This article describes how to use the EventCombMT utility (EventCombmt.exe) to search the event logs of multiple computers for account lockouts.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 824209

## More information

EventCombMT is a multithreaded tool that you can use to search the event logs of several different computers for specific events, all from one central location. You can configure EventCombMT to search the event logs in a very detailed fashion.

The following are some of the search parameters that you can specify:

- Individual event IDs
- Multiple event IDs
- A range of event IDs
- An event source
- Specific event text
- How many minutes, hours, or days back to scan

Some specific search categories are built-in, such as Account Lockouts. The Account Lockouts search is preconfigured to include event IDs 529, 644, 675, 676, and 681. Additionally, you can add event ID 12294 to search for potential attacks against the Administrator account.

To download the EventCombMT utility, download [Account Lockout and Management Tools](https://www.microsoft.com/download/details.aspx?id=18465). The EventCombMT utility is included in the Account Lockout and Management Tools download (ALTools.exe).

To search the event logs for account lockouts, follow these steps:

1. Start EventCombMT.
2. On the **Options** menu, click **Set Output Directory**, select an existing folder, or click **New Folder** to create a new folder to save the output to, and then click **OK**.

    > [!NOTE]
    > If you do not specify an output directory, the default location is C:\\Temp.
3. On the **Searches** menu, point to **Built In Searches**, and then click **Account Lockouts**.

    All domain controllers for the domain appear in the **Select To Search/Right Click To Add** box. Also, in the **Event IDs** box, you see that event IDs 529, 644, 675, 676, and 681 are added.
4. In the **Event IDs** box, type a space, and then type *12294* after the last event number.
5. In the **Options** menu, select **Set Date Range**.
6. In the **From** box, choose your start date and time.
7. In the **To** box, choose your end date and time, and then click **OK**.
8. Click **Search**.
9. To search other computers (non-domain controllers) for account lockout events, right-click the **Select To Search/Right Click To Add** box, and then click **Remove Selected Servers From List**. To add computers to search, right-click the **Select To Search/Right Click To Add** box, and then click one of the options. For example, to add computers one at a time, click **Add Single Server**. Click the server or servers that you want to search, and then click **Search**.

When the query completes, you can view the search results in the output directory that you specified in step 2. You can also import the files into Microsoft Excel. Or, if there is a very large output file, you can import the information into a SQL Server database and use queries to evaluate the information.

For more information about the EventCombMT utility, see the Help files that are included with the tool.
