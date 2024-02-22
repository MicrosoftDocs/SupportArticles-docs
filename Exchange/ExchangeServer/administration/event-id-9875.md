---
title: Getting errors 9875 in the event log
description: Provides a resolution to solve the Event ID 9875 that may occur for a recurring meeting in Exchange Server 2010 Service Pack 3 (SP3).
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: anthonge, nbanup, v-six
appliesto: 
  - Exchange Server 2010 Service Pack 3
search.appverid: MET150
ms.date: 01/24/2024
---
# Event ID 9875 source MSExchangeIS Mailbox Store error

_Original KB number:_ &nbsp; 3033272

## Symptoms

You may get errors 9875 in the event log:

> Log Name: Application  
Source: MSExchangeIS Mailbox Store  
Event ID: 9875  
Task Category: Content Indexing  
Level: Error  
Keywords: Classic  
User: N/A  
Description:  
Unexpected error "DOC_TOO_HUGE: There are not enough resources to process the document or row" occurred while indexing document.  
Mailbox Database: DB01  
Folder ID: 2ec8-57936CCC  
Message ID: 2ec8-20C5D9AAAA  
Document ID: 1447155777  
Error Code: 0x8004364a  

Event Xml:

```xml
<Event xmlns="http://schemas.microsoft.com/win/2004/08/events/event">
    <System>
        <Provider Name="MSExchangeIS Mailbox Store" />
        <EventID Qualifiers="49198">9875</EventID>
        <Level>2</Level>
        <Task>46</Task>
        <Keywords>0x80000000000000</Keywords>
        <TimeCreated SystemTime="2014-12-08T20:45:49.000000000Z" />
        <EventRecordID>527895</EventRecordID>
        <Channel>Application</Channel>
        <Security />
    </System>
    <EventData>
        <Data>DB01</Data>
        <Data>2ec8-57936CCC</Data>
        <Data>2ec8-20C5D9AAAA</Data>
        <Data>1447155777</Data>
        <Data>0x8004364a</Data>
    </EventData>
</Event>
```

## Cause

Typically this event is logged if there is a recurring meeting that happens often, say once a day and that meeting has no end date or some end date far into the future. If an exception is made to a recurrent meeting, a modified occurrence attachment is created. The only resolution is to delete the meeting and recreate it and give it an end date not more than a few months in the future. In order to find the offending meeting, use the following action below in the resolution section. Then delete the meeting.

## Resolution

1. Run Exfolders tool and Export the FIDs from the server. To do so, perform these steps:

    1. Download the file ExFolders_SP1.zip.

    2. Exact files, place the file ExFolders.exe in the server's Exchange \bin folder.

    3. Import registry key TurnOffSNVerificationForExFolders.reg to the system.

    4. Double select ExFolders.exe to open the ExFolder Tool, select **File** on menu bar, and choose connect.

    5. Select Mailbox type, select connected by Database, select a Global Catalog to connect, select the database \<database in question>, then select **OK**.

    6. In the left pane of Exfolder window, select the top folder Mailbox, select **Tools** on the menu bar, choose **Export Folder Properties**, choose **Selected folder and subfolders**, input *C:\FolderID.txt* in the **Output** file box, only check the `ptagPID: 0x67480014` property and leave the other properties unchecked, and then select **OK**.

2. Go to C:\ and open the file FolderID.txt, search through the list of FIDS looking for the mailbox and folder associated with the Folder ID in the event.

3. Run Exfolders and open the mailbox that contains the folder. To do so, please repeat the steps d and e in Step 1 and navigate to the affected mailbox in the left pane of ExFolders window.

4. Select the folder associated with the folder ID (which you found in step2) in the event. On the Right-hand side, select all the contents of the folder.

5. Select **Tools** on the menu bar, choose **Export Item Properties**, input *C:\MessageD.txt* in the **Output** file box, input *ptagMID : 0x674A0014* in the box at the bottom, select **Add property to list**, then select **OK**.

6. Go to C:\ and open the file FolderID.txt, you will have a searchable list of Message IDs for messages in the affected folder. Look for the message associated with the Message ID in the event.

7. Open the affected mailbox using Outlook, delete the message we found in step 7 and check the issue again.

You might have to repeat all the steps if you are getting multiple 9875 events with different folder and message IDs.
