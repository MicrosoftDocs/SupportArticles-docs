---
title: Troubleshoot public folder replication
description: Troubleshoots issues with public folder replication for Exchange Server 2010, 2007, and 2003.
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
  - Exchange Server 2010 Service Pack 3
  - Exchange Server 2007
  - Exchange Server 2003 Service Pack 2
search.appverid: MET150
---
# Troubleshoot public folder replication for Exchange Server

_Original KB number:_ &nbsp; 10042

## Summary

We'll begin by asking you to enable diagnostic logging and message tracking as a prerequisite. Then we'll take you through a series of steps to resolve your public folder replication issues.

Estimated time of completion:  
45-60 minutes.

To troubleshoot public folder replication for Exchange Server, you'll first need to enable diagnostic logging and message tracking.

## What do you want to do

- [Enable diagnostic logging](#enable-diagnostic-logging)
- [Enable Message Tracking](#enable-message-tracking)
- [I am ready to troubleshoot Public Folder Replication](#troubleshoot-public-folder-replication)

### Enable diagnostic logging

You'll need to turn on diagnostic logging on all servers you'll be working with. The steps for different Exchange version might be different, select your Exchange version:

#### For Exchange Server 2007 and Exchange Server 2010

1. Start the Exchange Management Shell.
2. Run the following cmdlet to check current logging levels:

    ```powershell
    Get-EventLogLevel | ? { $_.EventLevel -ne "Low" -AND $_.EventLevel -ne "Lowest" }
    ```

3. To turn on logging, run the following cmdlets on all public folder servers you're working with:

    ```powershell
    Set-EventLogLevel -Identity "MSExchangeIS\9001 Public\Replication DS Updates" -Level Expert
    Set-EventLogLevel -Identity "MSExchangeIS\9001 Public\Replication Incoming Messages" -Level Expert
    Set-EventLogLevel -Identity "MSExchangeIS\9001 Public\Replication Outgoing Messages" -Level Expert
    Set-EventLogLevel -Identity "MSExchangeIS\9001 Public\Replication NDRs" -Level Expert
    Set-EventLogLevel -Identity "MSExchangeIS\9001 Public\Replication Backfill" -Level Expert
    Set-EventLogLevel -Identity "MSExchangeIS\9001 Public\Replication General" -Level Expert
    Set-EventLogLevel -Identity "MSExchangeIS\9001 Public\Replication Errors" -Level Medium
    ```

4. On the Destination Server, increase Transport Logging by running these cmdlets:

    ```powershell
    Set-EventLogLevel -Identity "MSExchangeTransport\SmtpReceive" -Level 'Medium'
    Set-EventLogLevel -Identity "MSExchangeTransport\SmtpSend" -Level 'Medium'
    ```

5. To reset logging levels:
   1. Open the Exchange Management Console.
   2. In the console tree, navigate to **Server Configuration** > **Mailbox**.
   3. In the **Actions** pane, select **Manage Diagnostic Logging Properties**.
   4. On the **Manage Diagnostic Logging Properties** page, select the Exchange service you want to change the logging level for.
   5. Select the logging level you want, and then select **Configure**. If you want to restore defaults, select **Reset all services to default logging levels**, and then select **Configure**.
   6. On the **Completion** page, confirm that the process completed successfully. Tasks will show a status of **Completed** or **Failed**. If the task failed, review the summary for an explanation, and then select **Back** to make any needed configuration changes.
   7. Select **Finish** to complete the **Manage Diagnostic Logging Level** wizard.

#### For Exchange Server 2003

1. Start Exchange System Manager, and then display the properties of the server you want to enable diagnostic logging on.
2. Select the **Diagnostics Logging** tab, and then expand **MSExchangeIS** in the **Services** list.
3. Select **Public Folder**, press and hold Ctrl, and then select each of the following items to select them all:
   - Replication AD Updates
   - Replication Incoming Messages
   - Replication Outgoing Messages
   - Non-Delivery Reports
   - Replication Backfill
   - Replication General
4. Select **Maximum** > **Apply**.
5. Select **Replication Errors** > **Medium** > **Apply** > **OK**.
6. To increase logging on the destination server for the MSExchangeTransport service and set the SMTP level to Medium:
   1. Expand **Servers**, right-click **Your Server Name**, and then select **Properties**.
   2. Select the **Diagnostics Logging** tab, and then select **MSExchangeTransport** under **Services**.
   3. Under **Categories**, select **SMTP**.
   4. Under **Logging Level**, select **Medium**.

#### What do you want to do next

- [Enable Message Tracking](#enable-message-tracking)
- [I am ready to troubleshoot Public Folder Replication](#troubleshoot-public-folder-replication)

### Enable message tracking

To turn on Message Tracking on all servers, you'll be working with. The steps for different Exchange version might be different, select your Exchange version:

#### For Exchange Server 2007 and Exchange Server 2010

1. Verify that message tracking is on by going to Exchange Management Shell and running the following cmdlet:

    ```powershell
    Get-MailboxServer $env:computername | fl MessageTracking*
    ```

2. You should see output similar to this:

   :::image type="content" source="media/troubleshoot-public-folder-replication/verify-message-tracking-is-on.png" alt-text="Screenshot of running cmdlet to verify message tracking is on.":::

3. Make sure both `MessageTrackingLogEnabled` and `MessageTrackingLogSubjectLoggingEnabled` are set to **True**.

4. Make sure you note the `MessageTrackingLogPath` for the Log Location.

#### For Exchange Server 2003

1. Start Exchange System Manager, and then display the properties of the server where you want to enable message tracking. Message tracking collects data such as **To**, **From**, and **Date Sent**.
2. On the **General** tab, select the **Enable message tracking** check box.
3. Select the **Enable subject logging and display** check box.

#### What do you want to do

- [Enable Diagnostic Logging](#enable-diagnostic-logging)
- [I am ready to troubleshoot Public Folder Replication](#troubleshoot-public-folder-replication)

### Troubleshoot Public Folder Replication

Select one folder that includes data on one server but not on another server, and make just that folder the focus of your troubleshooting efforts. In the following steps, the server that contains the data is called the **source** server; the server that does not contain the data is called the **destination** server.

#### Exchange Server 2007 and Exchange Server 2010

1. In Exchange Management Console, select **Public Folder Management Console** under **Toolbox**.
2. Right-click **Public Folders**, and then select **Connect To**.
3. Select the server you want to connect to.

#### Exchange Server 2003

1. Open the Exchange System Manager.
2. Navigate to the Public Folder Hierarchy Object.
3. Right-click **Public Folders**, and then select **Connect To**.
4. Select the server you want to connect to.

**Does the folder you're looking for now appear in the hierarchy on both servers?**

- If yes, see [Focus on content; Replicate Always Interval and Schedule; Create a new item on the source server](#focus-on-content-replicate-always-interval-and-schedule-create-a-new-item-on-the-source-server).
- If no, see [Replicate Always Interval; Application log Event ID 3018](#replicate-always-interval-application-log-event-id-3018).

### Replicate Always Interval; Application log Event ID 3018

#### Replicate Always Interval

Verify that the Replicate Always Interval value is set to 15 or fewer minutes on the source server. If necessary, adjust the setting. Please select your Exchange version to check the steps:

##### Exchange Server 2007 and Exchange Server 2010

1. Start Exchange Management Console.
2. Run the following cmdlets and verify that `ReplicationPeriod`, `ReplicationSchedule`, and `ReplicationMessageSize` are set:

    ```powershell
    Get-PublicFolderDatabase -Server $env:computername| fl Replication*
    ```

    :::image type="content" source="media/troubleshoot-public-folder-replication/get-publicfolderdatabase.png" alt-text="Screenshot of running Get-PublicFolderDatabase to verify parameters are set.":::

3. Make sure all public f databases have the same `ReplicationMessageSize`.

Next, verify that the folder in question is configured to use the store schedule. To do this:

1. Start Exchange Management Console.
2. Run the following cmdlet and verify `Replicas` and `UseDatabaseReplicationSchedule` are set:

    ```powershell
    Get-PublicFolder | fl *Replica*
    ```

    :::image type="content" source="media/troubleshoot-public-folder-replication/get-publicfolder.png" alt-text="Screenshot of running Get-PublicFolder to verify parameters are set.":::

3. If `UseDatabaseReplicationSchedule` is set to **False**, make sure `ReplicationSchedule` is set.

##### Exchange Server 2003

1. Start Exchange System Manager.
2. Expand your **Administrative Groups** container, and then select the administrative group that contains the public folder server.
3. Expand the **Servers** container, select the public folder database, and then select **Properties**.
4. On the **Replication (Policy)** tab, note the value in the **Replication interval for always (minutes)** box.
5. If the value is not 15, type *15* in the **Replication interval for always (minutes)** box.
6. Select **Apply**, and then select **OK**.

Next, verify that the folder you're troubleshooting is configured to use the store schedule:

1. Expand **Public Folders**, and then right-click the folder you're troubleshooting.
2. Select **Properties**.
3. On the **Replication** tab, select **Use public store schedule** in the **Public folder replication interval** list.

#### Application log Event ID 3018

Create a new folder in the hierarchy on the source server, and then give the new folder a unique name you can remember.

We are using **Test 1** as the name of our folder in this example.
Watch the application log on the source server for Event ID 3018, which indicates message type 0x2 and contains the name of the folder you created. You may have to wait up to 15 minutes for the event to be logged.

|Event Type| Information|
|---|---|
|Event Source:|MSExchangeIS Public Store|
|Event Category:|Replication Outgoing Messages|
|Event ID:|3018|
|Message:|An outgoing replication message was issued.<br/>Type: 0x2<br/>Message ID: `<MessageID@Server.Domain.com>`<br/>Database "Storage Group\Public Folder"<br/>CN min: 1-100, CN max: 1-200<br/>RFIs:<br/>1) FID: 1-1234, PFID: 1-1, Offset: 28<br/>IPM_SUBTREE\Test 1|

**Do you see Event ID 3018?**

- If yes, see [Track the message in message tracking; Was the message delivered to the destination server?](#track-the-message-in-message-tracking-was-the-message-delivered-to-the-destination-server)
- If no, see [Troubleshoot the source server](#troubleshoot-the-source-server).

### Troubleshoot the source server

The source server is not generating outgoing hierarchy replication messages for new changes. We will first focus on troubleshooting on the source server.

#### Event ID 3079 when the public folder database is mounted

When the public folder database is mounted, Event ID 3079 is recorded in the Application log on the source server. Examine the Application log on the source server.

|Event Type| Information|
|---|---|
|Event Source|MSExchangeIS Public Store|
|Event Category|Replication Errors|
|Event ID|3079|
|Message|Unexpected replication thread error on database "\<name>".<br/>1) FID: 1-1234, PFID: 1-1, Offset: 28<br/>IPM_SUBTREE\Test 1<br/>|

**Do you see Event ID 3079?**

- If yes, see [EcReplStartup](#ecreplstartup).
- If no, sorry, we cannot resolve an unidentified issue using this guide. If you contact support about this issue, tell them that the source server is not generating outbound hierarchy replication messages and there is no 3079 event when the database mounts.

### EcReplStartup

Examine Event ID 3079 for the text: EcReplStartup.

Does Event ID 3079 contain EcReplStartup?

- If yes, see [Application log Event ID 9528](#application-log-event-id-9528).
- If no, sorry, we cannot resolve an unidentified issue by using this guide. If you contact support regarding this issue, please tell them that the source server is not generating outbound hierarchy replication messages. There is a 3079 event when the database mounts, but the event does not contain **EcReplStartup**.

### Application log Event ID 9528

If Event ID 3079 contains EcReplStartup, this indicates that the replication thread is dying at startup. Then, check if Event ID 9528 is recorded in the Application log of the source server.

|Event Type|Information|
|---|---|
|Event Source|MSExchangeIS|
|Event Category|General|
|Event ID|9528|
|Message|The SID S-1-5-32-544 was found on 2 users in the DS, so the store cannot map this SID to a unique user.<br/>The users involved are:<br/>/DC=com/DC=domain/DC=na/OU=Migrated/CN=John, Woods<br/>/DC=com/DC=domain/DC=ad/DC=corp/OU=EUC/OU=AMER/OU=Jersey City/OU=Harborside/OU=Users/CN=John, Woods|

Do you see Event ID 9528?

- If yes, see [Remove duplicate accounts](#remove-duplicate-accounts).
- If no, sorry, We can't solve unidentified issues with this guide. For more help resolving this issue, contact Microsoft Exchange Server support and tell them that when the database mounts, a 3079 event is logged.

### Track the message in message tracking; Was the message delivered to the destination server

#### Track the message in message tracking

On the source server, use the message ID from the description of Event ID 3018 to track the message in message tracking.

|Event Type|Information|
|---|---|
|Event Source|MSExchangeIS Public Store|
|Event Category|Replication Outgoing Message|
|Event ID|3018|
|Message|An outgoing replication message was issued.<br/>Type: 0x2<br/>Message ID: `<MessageID@Server.Domain.com>`<br/>Database "Storage Group\Public Folder"|

#### Was the message delivered to the destination server

In the description of Event ID 3018, note the message ID, and then use message tracking to determine whether the message was delivered to the destination server. For example, the following message tracking excerpt includes the following text:

"Message transferred to through SMTP".

Message History

```console
SMTP Store Driver: Message Submitted From Store
SMTP: Message Submitted to Advanced Queuing
SMTP: Started Message Submission to Advanced Queue
SMTP: Message Submitted to Categorizer
SMTP: Message Categorized and Queued For Routing
SMTP: Message Routed and Queued For Remote Delivery
SMTP: Started Outbound Transfer of Message Message transferred to through SMTP
```

**Does message tracking indicate that the message was delivered to the destination server?**

- If yes, see [Event ID 3028 on the destination server](#event-id-3028-on-the-destination-server).
- If no, see [Transport issue; Does the message appear in message tracking?](#transport-issue-does-the-message-appear-in-message-tracking)

### Transport issue; Does the message appear in message tracking?

#### Transport issue

The message was not delivered to the destination server, which indicates that a transport issue is causing the problem. Next, we'll troubleshoot the transport process.

#### Does the message appear in message tracking

Go to the source server and find the outgoing Message ID. Next, go to the Destination server and run message tracking to see if it received the message. Please select your Exchange version to check the steps to run message tracking.

##### For Exchange Server 2007 and Exchange Server 2010

1. Start Exchange Management Console.
2. Run the following cmdlet:

    ```powershell
    Get-MessageTrackingLog -MessageId
    ```

##### For Exchange Server 2003 

1. Start Exchange System Manager.
2. In the console tree, expand **Tools**, and then select **Message Tracking Center**.
3. In the Server box, type the name of the server running Exchange Server 2003.

To browse a list of available servers, select **Server**, select a server, and then select **Add**. You can search for a message that was sent from or delivered to a particular server. You are only required to specify the server name.

**Did it receive the message?**

- If yes, see [Determine whether the public folder store on the source server has an email address](#determine-whether-the-public-folder-store-on-the-source-server-has-an-email-address).
- If no, see [Does performance monitor show a large number of messages queued for submission?](#does-performance-monitor-show-a-large-number-of-messages-queued-for-submission)

### Event ID 3028 on the destination server

On the destination server, examine the Application log for Event ID 3028, which contains the same message ID you noted from the description of Event ID 3018.

|Event Type| Information |
|---|---|
|Event Source|MSExchangeIS Public Store|
|Event Category|Replication Incoming Messages|
|Event ID|3028|
|Message|An incoming replication message was issued.<br/>Type: 0x2<br/>Message ID: `<MessageID@Server.Domain.com>`<br/>Database "Storage Group\Public Folder"<br/>CN min: 5-100 CN max: 5-200<br/>RFIs: 1<br/>1) FID: 5-1234, PFID: 1-1, Offset: 28<br/>IPM_SUBTREE\Test 1<br/>|

**Does the destination server Application log show Event ID 3028, and does this event contains the same message ID as Event ID 3018?**

- If yes, see [New folder visibility](#new-folder-visibility).
- If no, see [Replication Receive Queue Size in Performance Monitor](#replication-receive-queue-size-in-performance-monitor).

### Event ID 7004 and Event ID 7010 on the destination server

On the destination server, examine the Application log in Event Viewer for events that resemble the following events.

|Event Type|Error|
|---|---|
|Event Source|MSExchangeTransport|
|Event Category|SMTP Protocol|
|Event ID|7004|
|Date|Date|
|Time|Time|
|Users|Not available|
|Computer|Computer_Name|
|Description|This is an SMTP protocol error log for virtual server ID 1, connection #29. The remote host `E2k3server1.contoso.com`, responded to the SMTP command "xexch50" with "504 Need to authenticate first ". The full command sent was "XEXCH50 2336 3 ". This will probably cause the connection to fail.|

|Event Type| Error |
|---|---|
|Event Source|MSExchangeTransport|
|Event Category|SMTP Protocol|
|Event ID|7010|
|Date|Date|
|Time|Time|
|User|Not available|
|Computer|Computer_Name|
|Description:|This is an SMTP protocol log for virtual server ID 1, connection #30. The client at "6.5.2.4" sent a "xexch50" command, and the SMTP server responded with "504 Need to authenticate first ". The full command sent was "xexch50 1092 2". This will probably cause the connection to fail. These events indicate that the XEXCH50 protocol sink fired, but the exchange of the blobs failed between the servers that are listed in the events.|

**Do you see Event ID 7004 and Event ID 7010 on the destination server?**

- If yes, see [Resolve issue with the XEXCH50 command](#resolve-issue-with-the-xexch50-command).
- If no, see [Run isinteg –fix –test ReplState on the destination server; Tombstone because of a deletion](#run-isinteg--fix--test-replstate-on-the-destination-server-tombstone-because-of-a-deletion).

### Resolve issue with the XEXCH50 command

The problem that you are experiencing may be caused by an XEXCH50 command issue.

#### To resolve the XEXCH50 command issue

1. Verify that Integrated Windows Authentication is enabled on the SMTP virtual servers on the computers that are running Exchange Server in your organization. If Integrated Windows Authentication is not enabled:

   1. In Exchange System Manager, expand **Administrative Groups**, expand **Servers**, expand **Exchange Server Name**, expand **Protocols**, and then expand **SMTP**.
   2. Right-click the **SMTP virtual server**.
   3. Select **Properties**, select the **Access** tab, and then select **Authentication**. Make sure that the **Integrated Windows Authentication** check box is selected.

2. If Integrated Windows Authentication is enabled, but the events persist, the sending server in the 7004 event or in the 7010 event may lack or be denied the SendAs right on the receiving server. If the sending server and the receiving server are experiencing these events, the servers may lack the SendAs rights for each other. The SendAs right is not set explicitly. The SendAs right is typically inherited through membership in the Exchange Domain Servers (EDS) group. If the EDS does not have this DENY access control entry (ACE), the affected server may be nested in another group that has the DENY ACE, or the EDS may be nested in some other groups that have the DENY ACE. To run successfully, the **XEXCH50** command has to have the SendAs right for servers in the Exchange organization.
3. Determine whether you are using Transport Layer Security (TLS) and a security channel between servers in the Exchange organization. In this scenario, the STARTTLS transport event sinks occur before the AUTH command. The **XEXCH50** command fails later in the session because the **AUTH** command is missing.
4. If Exchange Protocol Security (EXPS) authentication is not working correctly between servers, the **XEXCH50** command does not work. Events 1704 and 1706 indicate EXPS authentication failures in the Application log.

    |Event Type|Warning|
    |---|---|
    |Event Source|MSExchangeTransport Event|
    |Event Category|MTP Protocol|
    |Event ID|1706|
    |Description:|EXPS is temporarily unable to provide protocol security with "..com". "CSessionContext::OnEXPSInNegotiate" called "HrServerNegotiateAuth" which failed with error code 0x8009030c ( i:\transmt\src\smtpsink\exps\expslib\context.cpp@1462 ). Data: 0000: 0c 03 09 80 ...?|

    > [!NOTE]
    > The description in Event ID 1706 includes error code 0x8009030c.  
    Error code 0x8009030c is the SEC_E_LOGON_DENIED Hresult value. This code indicates that the account could not be logged on.  
    These problems may be difficult to troubleshoot because the Microsoft Windows credentials of EXPS are required to pass this **AUTH** command. You can use various tools to troubleshoot the combination of Event ID 7004 and 7010; this includes the NLTEST tool and the NETDOM tool. Troubleshooting steps may include resetting computer account passwords.  
    If you have a combination of Event ID 7004 and 7010 in the Application log as described earlier, and you cannot discover the source of the problem by using EXPS authentication, contact [Microsoft Support Services](https://support.microsoft.com/contactus/?ws=support).  
    If you do not have the combination of Event ID 7004 and Event ID 7010 in the Application log, go to step 5.

5. Check whether there is a firewall or an antivirus wall between servers in the Exchange organization. If a firewall is operating between servers in the organization, temporarily disable the firewall to determine whether it is causing the problem.

**Did disabling the firewall resolve the issue?**

- If yes, congratulations! Your Public Folder Replication for Exchange Server 2003 issue is resolved.
- If no, see [Run isinteg –fix –test ReplState on the destination server; Tombstone because of a deletion](#run-isinteg--fix--test-replstate-on-the-destination-server-tombstone-because-of-a-deletion).

### Run isinteg -fix -test ReplState on the destination server; Tombstone because of a deletion

#### Run isinteg –fix –test ReplState on the destination server

Select your Exchange version to verify and adjust the ReplState setting with following steps:

##### For Exchange Server 2007 and Exchange Server 2010

1. Start Exchange Management Console.
2. Use the `New-PublicFolderDatabaseRepairRequest` cmdlet to detect and fix replication issues in the public folder database. Public folders on the public folder database can still be accessed while the request is running. However, the public folder currently being repaired is not available. After you begin the repair request, it can't be stopped unless you dismount the database.
3. Run the following cmdlet:

    ```powershell
    New-PublicFolderDatabaseRepairRequest -Database -CorruptionType ReplState
    ```

##### For Exchange Server 2003

1. On the destination server, install the hotfix KB925253.
2. After the hotfix is installed, dismount the public folder database on the server, and then run the following command at a command prompt:

    ```console
    cd C:\Program Files\Exchsrvr\bin
    Isinteg -s -fix -test ReplState
    ```

Next, run a test to determine whether the issue is resolved.

#### Tombstone because of a deletion

This indicates the folder is a tombstone because of a previous deletion that did not replicate. Go back to the source server and copy the folder to create a new folder with the same content, and then start over.

### New folder visibility

Is the new folder visible in the hierarchy on the destination server?

- If yes, see [Troubleshoot hierarchy backfill](#troubleshoot-hierarchy-backfill).
- If no, see [Looking for the folder ID (FID) (Isolate?)](#looking-for-the-folder-id-fid-isolate)

### Troubleshoot hierarchy backfill

At this point, we have verified that changes to the hierarchy are replicating correctly. We can now troubleshoot hierarchy backfill. To do this, run **Synchronize Hierarchy** on the destination server. Synchronize Hierarchy causes Event ID 3017 to occur. Event ID 3017 shows that a hierarchy status request (type 0x20) was sent to the source server.

#### For Exchange Server 2007 and Exchange Server 2010

1. Start Exchange Management Console.
2. Run the `Update-PublicFolderHierarchy -Server` cmdlet.
3. After you run **Synchronize Hierarchy** on the destination server, examine the Application log on the source server for the 3027 event and for the incoming status request.

#### For Exchange Server 2003

1. Start Exchange System Manager.
2. To run **Synchronize Hierarchy**, expand **Folders**, right-click the **Public Folders** object container, and then select **Synchronize Hierarchy**.
3. After you run **Synchronize Hierarchy** on the destination server, examine the Application log on the source server for event 3027 and for the incoming status request.

**Is event 3027 in the Application log on the source server?**

- If yes, see [Event ID 3017 on the source server](#event-id-3017-on-the-source-server).
- If no, see [Retrieve the message ID and track the message](#retrieve-the-message-id-and-track-the-message).

### Retrieve the message ID and track the message

On the source server, locate Event ID 3017, and then note the message ID. Use message tracking to track the message ID to determine whether the message was delivered to the source server.

**Does message tracking say the message was delivered to the source server?**

- If yes, see [Possible ReplState problem](#possible-replstate-problem).
- If no, see [Determine whether the public folder store on the source server has an email address](#determine-whether-the-public-folder-store-on-the-source-server-has-an-email-address).

### Determine whether the public folder store on the source server has an email address

To determine whether the public folder store on the source server has a proxy address assigned, examine the value of the `proxyAddresses` attribute in Active Directory directory service.

#### To examine the value

> [!WARNING]
> If you use the Active Directory Service Interface (ADSI) Edit snap-in, the LDP utility, or any other LDAP version 3 client, and you incorrectly change the attributes of Active Directory objects, you can cause serious problems. These problems may require you to reinstall Microsoft Windows 2000 Server, Windows Server 2003, Microsoft Exchange Server 2000, Microsoft Exchange Server 2003, or both Windows Server and Exchange Server. Microsoft cannot guarantee that problems that occur if you incorrectly change Active Directory object attributes can be resolved. Change these attributes at your own risk.

> [!NOTE]
> Depending on your version of Microsoft Windows, the following steps may be different on your computer. If they are, see your product documentation to complete these steps.

1. Start the ADSI Edit tool by choosing **Start** > **Run**, typing *adsiedit.msc* in the Open box, and then choosing **OK**.

   > [!NOTE]
   > ADSI Edit is included with Microsoft Windows 2000 Server Support Tools and with Windows Server 2003 Support Tools. To install Windows 2000 Support Tools, double-click **Setup.exe** in the Support\Tools folder on the Windows 2000 CD. To install Windows Server 2003 Support Tools, double-click **Suptools.msi** in the Support\Tools folder on the Windows Server 2003 CD.
2. Connect to a domain controller if you are not already connected.

     > [!NOTE]
     > In this step, `contoso.com` is a placeholder for your domain name; other words in italics are placeholders for the indicated names.Expand **Configuration Container [computername.contoso.com]**, expand **CN=Configuration, DC=contoso, DC=com**, expand **CN=Services**, expand **CN=Microsoft Exchange**, expand **CN=OrganizationName**, expand **CN=Administrative Groups**, expand **CN=AdministrativeGroupName**, expand **CN=Servers**, expand **CN=ExchangeServerName**, expand **CN=InformationStore**, and then select **CN=First Storage Group**.

3. In the right pane, right-click **CN=Public Folder Store (EXCHANGESERVERNAME)**, and then select **Properties**.
4. In the **Select which properties to view** list, select **both**.
5. In the **Select a property to view** list, select **proxyAddresses**.
6. In the **Value(s)** box, determine whether an email address is assigned. Typically, the public folder store has a Simple Mail Transfer Protocol (SMTP) address stamp similar to: `SMTP:ExchangeServerName-IS@contoso.com`.
7. In the **Select a property to view** list, select **mail**.
8. In the **Value(s)** box, verify the SMTP address is the same as the SMTP address displayed in step 7.

**Does the source public store have an email address?**

- If yes, sorry, we cannot resolve an unidentified issue using this guide. For more help to resolve this issue, contact Microsoft Exchange Server support.
- If no, see [Application log Event ID 3018](#application-log-event-id-3018).

### Event ID 3017 on the source server

In the Application log on the source server, immediately before Event ID 3027, locate Event ID 3017 for the same folder, which has type 0x10.

**Do you see Event ID 3017 and type 0x10 for the same folder?**

- If yes, see [Event ID 3027 that has type 0x10 on the destination server](#event-id-3027-that-has-type-0x10-on-the-destination-server).
- If no, see [Do the servers have different age limits?](#do-the-servers-have-different-age-limits)

### Event ID 3027 on the destination server

Event ID 3027 is the status response on the source server. In the Application log on the destination server, locate Event ID 3027 to examine the status response.

**Do you see Event ID 3027 on the destination server?**

- If yes, see [Troubleshooting backfill](#troubleshooting-backfill).
- If no, sorry, we cannot resolve an unidentified issue using this guide. For more help to resolve this issue, contact Microsoft Exchange Server support.

### Troubleshooting backfill

At this point, we know that the destination server is aware that data is missing. Now we focus on troubleshooting having the hierarchy backfill itself.

On the destination server, run **Synchronize Hierarchy** again, and then check the Application log on the destination server for Event ID 3014, which has type 0x8. Event ID 3014 is an outgoing backfill request for the hierarchy.

**Do you see Event ID 3014 and type 0x8 on the destination server?**

- If yes, see [Event ID 3024 on the source server](#event-id-3024-on-the-source-server).
- If no, sorry, we cannot resolve an unidentified issue using this guide. For more help to resolve this issue, contact Microsoft Exchange Server support.

### Event ID 3024 on the source server

Event ID 3024 is the incoming hierarchy backfill request.

**Do you see Event ID 3024 on the source server?**

- If yes, see [Event ID 3019 on the source server](#event-id-3019-on-the-source-server).
- If no, see [Track the message ID from Event ID 3014](#track-the-message-id-from-event-id-3014).

### Event ID 3019 on the source server

Event ID 3019, which has type 0x80000002, is the outgoing hierarchy backfill response on the source server. Examine the Application log on the source server for Event ID 3019.

**Is Event ID 3019 on the Application log on the source server?**

- If yes, see [Event ID 3029](#event-id-3029).
- If no, sorry, we cannot resolve an unidentified issue using this guide. For more help to resolve this issue, contact Microsoft Exchange Server support.

### Event ID 3029

Event ID 3029 is the incoming hierarchy backfill response on the destination server.

**Do you see Event ID 3029 in the Application log on the destination server?**

- If yes, see [Look for the folder in the hierarchy](#look-for-the-folder-in-the-hierarchy).
- If no, see [Track the message ID from Event ID 3019](#track-the-message-id-from-event-id-3019).

### Look for the folder in the hierarchy

On the destination server, look for the folder in the hierarchy.

**Do you see the folder in the hierarchy on the destination server now?**

- If yes, congratulations! Your Public Folder Replication for Exchange Server 2003 issue is resolved.
- If no, sorry, we cannot resolve an unidentified issue using this guide. For more help to resolve this issue, contact Microsoft Exchange Server support.

### Track the message ID from Event ID 3014

On the destination server, examine Event ID 3014 to obtain the message ID. Use message tracking to track the message ID.

**Does message tracking indicate that the message was delivered to the source server?**

- If yes, see [Focus on content; Replicate Always Interval and Schedule; Create a new item on the source server](#focus-on-content-replicate-always-interval-and-schedule-create-a-new-item-on-the-source-server).
- If no, sorry, we cannot resolve an unidentified issue using this guide.

### Track the message ID from Event ID 3019

On the source server, locate Event ID 3019, and then note the message ID in the event. Use message tracking to track the message ID.

**Does message tracking indicate that the message was delivered to the destination server?**

- If yes, see [Replication Receive Queue Size in Performance Monitor](#replication-receive-queue-size-in-performance-monitor).
- If no, sorry, we cannot resolve an unidentified issue using this guide. For more help to resolve this issue, contact Microsoft Exchange Server support.

### Focus on content; Replicate Always Interval and Schedule; Create a new item on the source server

#### Focus on content

Because the folder appears in the hierarchy on both servers, this is probably not a hierarchy replication issue. Therefore, we will focus on troubleshooting content.

#### Replicate Always Interval and Schedule

Verify that the Replicate Always Interval value is set to 15 minutes or fewer on the source server.

##### To verify and adjust the setting on Exchange Server 2007 and Exchange Server 2010

1. Start Exchange Management Console.
2. Run the following cmdlet and verify `ReplicationPeriod`, `ReplicationSchedule`, and `ReplicationMessageSize` are set:

    ```powershell
    Get-PublicFolderDatabase -Server $env:computername| fl Replication*
    ```

    :::image type="content" source="media/troubleshoot-public-folder-replication/get-publicfolderdatabase.png" alt-text="Screenshot of using Get-PublicFolderDatabase to verify parameters are set.":::

3. Make sure all public folder databases have the same `ReplicationMessageSize`.

Next, verify that the folder in question is configured to use the store schedule. To do this:

1. Start Exchange Management Console.
2. Run the following cmdlet and verify `Replicas` and `UseDatabaseReplicationSchedule` are set:

    ```powershell
    Get-PublicFolder | fl *Replica*
    ```

    :::image type="content" source="media/troubleshoot-public-folder-replication/get-publicfolder.png" alt-text="Screenshot of using Get-PublicFolder to verify parameters are set.":::

3. If `UseDatabaseReplicationSchedule` is set to **False**, make sure that `ReplicationSchedule` is set.

##### To verify and adjust the setting on Exchange Server 2003

1. Start Exchange System Manager.
2. Expand your **Administrative Groups** container, and then select the administrative group that contains the public folder server.
3. Expand the Servers container, expand the source server, select the public folder database, and then select **Properties**.
4. On the **Replication (Policy)** tab, type *15* in the **Replication interval for always (minutes)** box.
5. Select **Apply**, and then select **OK**.

Next, verify that the folder you're working with is configured to use the store schedule. To do this:

1. Expand **Public Folders**, and then right-click the folder you're working with.
2. Select **Properties**.
3. On the **Replication** tab, select **Use public store schedule** in the **Public folder replication interval** list.

#### Create a new item on the source server

Create a new item in the public folder on the source server, and then watch the Application log for Event ID 3020.

**Do you see Event ID 3020, and does it include the name of the folder you are testing and the name of the item we created?**

- If yes, see [Event ID 3030](#event-id-3030).
- If no, see [Source server is not generating outgoing content messages for that folder; Event ID 3079 when the public folder database is mounted](#source-server-is-not-generating-outgoing-content-messages-for-that-folder-event-id-3079-when-the-public-folder-database-is-mounted).

### Event ID 3030

On the destination server, examine the Application log for Event ID 3030.

#### Does the destination server Application log contain Event ID 3030 for the same folder and item

- If yes, see [Verify that the item is in the source folder on the destination server](#verify-that-the-item-is-in-the-source-folder-on-the-destination-server).
- If no, see [Track the message that is identified in Event ID 3020](#track-the-message-that-is-identified-in-event-id-3020).

### Source server is not generating outgoing content messages for that folder; Event ID 3079 when the public folder database is mounted

#### Source server is not generating outgoing content messages for that folder

The source server is not generating outgoing content messages for that folder. We'll focus our troubleshooting on the source server.

#### Event ID 3079 when the public folder database is mounted

On the source server, examine the Application log for Event ID 3079. Event ID 3079 occurs when the database is mounted, and it should contain the text: EcReplStartup. For example, Event ID 3079 should resemble the following table.

|Event Type| Information|
|---|---|
|Event Source|
MSExchangeIS Public Store|
|Event Category|Replication Errors|
|Event ID|3079|
|Message|Unexpected replication thread error 0x3f0.<br/>EcGetReplMsg<br/>EcReplStartup<br/>FReplAgent<br/>|

**Do you see Event ID 3079, and does it contain EcReplStartup when the database is mounted?**

- If yes, see [Application log Event ID 9528](#application-log-event-id-9528).
- If no, see [Run isinteg –fix –test ReplState; Event ID 3020](#run-isinteg--fix--test-replstate-event-id-3020).

### Run isinteg -fix -test ReplState; Event ID 3020

#### Run isinteg –fix –test ReplState on the destination server

Select your Exchange version to verify and adjust the ReplState setting with following steps:

##### For Exchange Server 2007 and Exchange Server 2010

1. Start Exchange Management Console.
2. Use the `New-PublicFolderDatabaseRepairRequest` cmdlet to detect and fix replication issues in the public folder database. Public folders on the public folder database can still be accessed while the request is running. However, the public folder currently being repaired is not available. After you begin the repair request, it can't be stopped unless you dismount the database.
3. Run the following cmdlet:

    ```powershell
    New-PublicFolderDatabaseRepairRequest -Database -CorruptionType ReplState
    ```

##### For Exchange Server 2003

1. On the destination server, install the hotfix KB925253 that was released on January 24, 2013.
2. After the hotfix is installed, dismount the public folder database on the server, and then run the following command at a command prompt:

    ```console
    cd C:\Program Files\Exchsrvr\bin
    Isinteg -s -fix -test ReplState
    ```

#### Event ID 3020

Create a new item in the public folder on the source server, and then examine the Application log for Event ID 3020.

Do you see Event ID 3020, and does it include the name of the folder you are testing and the name of the item you created?

- If yes, see [Event ID 3030](#event-id-3030).
- If no, sorry, we cannot resolve an unidentified issue by using this guide. If you contact support regarding this issue, please tell them that the source server is not generating outbound hierarchy replication messages. There is a 3079 event when the database mounts, but the event does not contain **EcReplStartup**.

### Verify that the item is in the source folder on the destination server

On the destination server, look for the item you created on the source server, and make sure that it is in the destination folder.

**Do you see the item in the folder on the destination server?**

- If yes, see [Troubleshoot content backfill](#troubleshoot-content-backfill).
- If no, see [Does the 3030 event show the message ID (MID) of the item but not the subject?](#does-the-3030-event-show-the-message-id-mid-of-the-item-but-not-the-subject)

### Troubleshoot content backfill

We have verified that changes to content are replicating. Next, we'll troubleshoot content backfill.

To do this, run Synchronize Content on the destination server. This should cause the destination server to ask the source server for the missing data.

#### To run Synchronize Content in Exchange Server 2007 and Exchange Server 2010

1. Start Exchange Management Console.
2. Run the following command:

   ```powershell
   Update-PublicFolder -Server <DestinationServer>
   ```

3. After you run Synchronize Hierarchy on the destination server, examine the Application log on the source server for event 3027 and for the incoming status request.

#### To run Synchronize Content in Exchange Server 2003

1. Expand **Public Folders**, and then select the destination folder.
2. In the right pane, select the **Status** tab.
3. Right-click the destination server, and then select **Synchronize Content**.

After you run Synchronize Content on the destination server, examine the Application log for Event ID 3017 for the outgoing status request.

#### Is Event ID 3017 in the Application log on the destination server

- If yes, see [Event ID 3027](#event-id-3027).
- If no, see [Run isinteg -fix -test ReplState (if Event ID 3017 isn't logged)](#run-isinteg--fix--test-replstate-if-event-id-3017-isnt-logged).

### Run isinteg -fix -test ReplState (if Event ID 3017 isn't logged)

Select your Exchange version to verify and adjust the ReplState setting with following steps:

#### For Exchange Server 2007 and Exchange Server 2010

1. Start Exchange Management Console.
2. Use the `New-PublicFolderDatabaseRepairRequest` cmdlet to detect and fix replication issues in the public folder database. Public folders on the public folder database can still be accessed while the request is running, but you cannot access the public folder currently being repaired. After you begin the repair request, it can't be stopped unless you dismount the database.
3. Run the following cmdlet:

    ```powershell
    New-PublicFolderDatabaseRepairRequest -Database -CorruptionType ReplState
    ```

#### For Exchange Server 2003

1. On the destination server, install the hotfix KB925253.
2. After the hotfix is installed, dismount the public folder database on the server, and then run the following command at a command prompt:

    ```console
     cd C:\Program Files\Exchsrvr\bin
    Isinteg -s -fix -test ReplState
    ```

3. After the isinteg process finishes, change the replica list on the public folder on the source server. To do this, either add a replica to or remove a replica from any server. Select **Apply**, reverse the change you just made, and then select **Apply** again.
4. Run **Synchronize Content** on the destination server again for the same folder.
5. Examine the Application log for Event ID 3017 for the outgoing status request.

**Is Event ID 3017 in the Application log on the destination server?**

- If yes, see [Event ID 3027](#event-id-3027).
- If no, sorry, we cannot resolve an unidentified issue using this guide. For more help to resolve this issue, contact Microsoft Exchange Server support.

### Event ID 3027

On the source server, examine the Application log for Event ID 3027 that has type 0x20.

**Do you see Event ID 3027, and does it have type 0x20 on the source server?**

- If yes, see [Event ID 3017 on the source server](#event-id-3017-on-the-source-server).
- If no, see [Track the Event ID 3027](#track-the-event-id-3027).

### Event ID 3017 on the source server

In the Application log on the source server, immediately before Event ID 3027, locate Event ID 3017 that has type 0x10 for the same folder.

**Do you see Event ID 3017, and does it have type 0x10 for the same folder?**

- If yes, see [Event ID 3027 on the destination server](#event-id-3027-on-the-destination-server).
- If no, see [Do the servers have different age limits?](#do-the-servers-have-different-age-limits)

### Do the servers have different age limits

Typically, if the source server does not generate a status response, it means that the source server has no data that the other server does not also have.

One situation where servers can be in-sync without having identical content is if they have different age limits. If the destination server has already expired the items in question, it will not backfill the items again.

Be sure to check and make sure that the servers do not have different age limits. There are several types of limits:

#### Storage Quotas

##### Use database quota defaults

Select this check box to use the public folder database quota limits on which the public folder resides. If you do not select the defaults, the **Issue warning at (KB)**, **Prohibit post at (KB)**, and **Maximum item size (KB)** check boxes will become available.

##### Issue warning at (KB)

Select this check box to automatically warn public folder owners that the public folder is approaching its storage limit. To specify this limit, select the check box, and then specify the size of the public folder in kilobytes (KB) at which you want to prohibit posting. You can enter a value between 0 KB and 2,147,483,647 KB (2.1 terabytes).

##### Prohibit post at (KB)

Select this check box to prevent posting to the public folder after the size of the folder reaches the specified limit. To specify this limit, select the check box, and then specify the size of the public folder in KB at which you want to prohibit posting. You can enter a value between 0 KB and 2,147,483,647 KB (2.1 terabytes).

##### Maximum item size (KB)

Select this check box to limit the maximum size of items users can post to the public folder. To specify the size, select the check box, and then specify the maximum size of items in KB that users can post to the public folders. You can enter a value between 0 KB and 2,097,151 KB.

#### Deleted Item Retention

##### Use database retention defaults

Select this check box to use the public folder database item retention limits on the server where this public folder resides. If you do not select this check box, the Retain deleted items for (days) check box becomes available.

##### Retain deleted items for (days)

Select this check box to set the number of days deleted items are retained in a public folder. You can enter a value between 0 and 24,855 days.

#### Age Limits

##### Use database age defaults

Select this check box to use the public folder database age limits for the server where this public folder resides. If you do not select this check box, the **Age limit for replicas (days)** check box becomes available.

##### Age limit for replicas (days)

Select this check box to limit the age of the public folder. Use the corresponding text box to specify the age limit in days. Replicas of this public folder are automatically deleted when the age limit is exceeded. You can enter a value between 0 and 24,855 days.

**Do the servers have different age limits?**

- If the answer is yes, the content difference is by design. You do not have to continue troubleshooting. You can work around the issue by copying the items so they become new items in a new folder.
- If the answer is no, an unknown error has occurred.

### Event ID 3027 that has type 0x10 on the destination server

On the destination server, examine the Application log for Event ID 3027 event that has type 0x10.

**Do you see Event ID 3027, and does it have type 0x10?**

- If yes, see [Focus on backfill](#focus-on-backfill).
- If no, sorry, we cannot resolve an unidentified issue by using this guide. If you contact support regarding this issue, please tell them that the source server is not generating outbound hierarchy replication messages. There is a 3079 event when the database mounts, but the event does not contain **EcReplStartup**.

### Focus on backfill

At this point, the destination server has calculated that some data is missing. Therefore, we will focus on backfill.

On the destination server, run **Synchronize Content** again on the destination folder. After you run **Synchronize Content**, Event ID 3016 is recorded in the Application log. Event ID 3016 has message type 0x8 that contains the name of the folder.

**On the destination server, do you see Event ID 3016, and does it have message type 0x8 that contains the name of the folder?**

- If yes, see [Event ID 3026 on the source server](#event-id-3026-on-the-source-server).
- If no, see [Outstanding backfill limit](#outstanding-backfill-limit).

### Event ID 3026 on the source server

In response to Event ID 3016 on the destination server, you should see Event ID 3026 in the Application log on the source server.

**On the source server, do you see Event ID 3026?**

- If yes, see [Event ID 3021 on the source server](#event-id-3021-on-the-source-server).
- If no, see [Message may have been sent to a different source server](#message-may-have-been-sent-to-a-different-source-server).

### Event ID 3021 on the source server

In the Application log on the source server, immediately after Event ID 3026, you should see one or more incidents of Event ID 3021 that include message type 0x80000004 for the folder.

**Do you see at least one Event ID 3021 that includes message type 0x80000004 for the folder?**

- If yes, see [Compare the number of Event ID 3021 to the number of Event ID 3031](#compare-the-number-of-event-id-3021-to-the-number-of-event-id-3031).
- If no, sorry, we cannot resolve an unidentified issue using this guide. For more help to resolve this issue, contact Microsoft Exchange Server support.

### Compare the number of Event ID 3021 to the number of Event ID 3031

Count the number of incidents of Event ID 3021 that are in the Application log on the source server. Then, count the number of incidents of Event ID 3031 that have message type 0x80000004 for the folder and that are in the Application log on the destination server.

**Are there an equal number of Event ID 3021 incidents and Event ID 3031 incidents between the servers?**

- If yes, see [Locate the content in the folder on the destination server](#locate-the-content-in-the-folder-on-the-destination-server).
- If no, see [One or more of the messages was lost in transport](#one-or-more-of-the-messages-was-lost-in-transport).

### Locate the content in the folder on the destination server

On the destination server, look for the content that was synchronized from the source server to the same folder on the destination server.

**Did you find the content in the same folder on the destination server?**

- If yes, congratulations! Your Public Folder Replication for Exchange Server 2003 issue is resolved.
- If no, sorry, we cannot resolve an unidentified issue using this guide. For more help to resolve this issue, contact Microsoft Exchange Server support.

### Message may have been sent to a different source server

Examine Event ID 3016 to verify that the message was sent to the expected source server. On the destination server, examine Event ID 3016 to determine which source server should have received the message. If a different source server received the message, use that server as the new source server, and then examine the Application log on the new source server for Event ID 3016.

|Event Type|Information|
|---|---|
|Event Source|MSExchangeIS Public Store|
|Event Category|Replication Outgoing Messages|
|Event ID|3016|
|Message|Outgoing message type \<value><br/>Message ID: \<id><br/>Folder: \<folder name><br/>Database "\<name>".<br/>CNSET: \<value><br/>CNSET(FAI): \<value><br/>Server: \<server name>|

**Is the expected source server identified in Event ID 3016?**

- If yes, see [Event ID 3021 on the source server](#event-id-3021-on-the-source-server).
- If no, sorry, we cannot resolve an unidentified issue using this guide. For more help to resolve this issue, contact Microsoft Exchange Server support.

### Outstanding backfill limit

By default, the Public Folders store can hold up to 50 outstanding backfill requests at one time. This is known as the Outstanding Backfill Limit (OBL). When 50 backfill requests are in the store array, those requests are made repeatedly until they are satisfied; no further new requests can be made until at least one request has been completed.

Each time a backfill request is satisfied, an opening occurs in the OBL and a new set of data can be requested. However, if all 50 requests experience issues and cannot be satisfied, no new openings occur, no new requests can be made, and replication cannot continue.

To determine whether Outstanding Backfill Limit is the cause of the problem, increase the OBL limit by one (1) on the destination server, and then examine the Application log for at least five minutes for an instance of Event ID 3016.

To increase the OBL limit by one (1) on the destination server

1. Open the Registry Editor by choosing **Start** > **Run**, type *regedit*, and then choosing **OK**.

1. Expand the following subkey:  
`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\MSExchangeIS\<Server_Name>\Public-<GUID>`

1. Right-click **Public-\<GUID>**, point to **New**, and then select **DWORD Value**.
1. Type **Replication Outstanding Backfill** Limit, and then press Enter to name the new -subkey.
1. Right-click **Replication Outstanding Backfill Limit**, and then select **Modify**.
1. In the **Value data** box, type *51*, and then select **OK**.
1. Close the Registry Editor.
1. Restart the Microsoft Exchange Information Store service on Exchange Server 2003. To do this:

   - Select **Start**, point to **Administrative Tools**, and then select **Services**.
   - In the **Services** list, select **Microsoft Exchange Information Store**, and then select **Restart**.

If Event ID 3016 is recorded for some other folder, troubleshoot using that folder instead.

**Do you see Event ID 3016 for some other folder?**

- If yes, see [Troubleshoot content backfill](#troubleshoot-content-backfill).
- If no, sorry, we cannot resolve an unidentified issue using this guide. For more help to resolve this issue, contact Microsoft Exchange Server support.

### Track the message that is identified in Event ID 3020

On the source server, use message tracking to track the message is identified in Event ID 3020.

**Does message tracking indicate that the message was delivered to the destination server?**

- If yes, see [Troubleshoot the XEXCH50 command](#troubleshoot-the-xexch50-command).
- If no, see [Transport issue; Does the message appear in message tracking?](#transport-issue-does-the-message-appear-in-message-tracking)

### Troubleshoot the XEXCH50 command

To troubleshoot the XEXCH50 command, increase logging on the destination server for the MSExchangeTransport service, and set the SMTP protocol level to medium.

To verify and adjust the SMTP protocol level setting, please select your Exchange version to check the steps:

#### For Exchange Server 2007 and Exchange Server 2010

1. Start Exchange Management Console.
2. Use the `Set-EventLogLevel -Identity "MSExchangeTransport\SmtpReceive" -Level 'Medium'` and `Set-EventLogLevel -Identity "MSExchangeTransport\SmtpSend" -Level 'Medium'` cmdlets to turn on event logging for the SMTP.
3. Use the `Resume-PublicFolderReplication` cmdlet to start public folder replication for the entire organization.

#### For Exchange Server 2003

Next, examine the Application log in Event Viewer for events that resemble the following:

|Event Type|Error|
|---|---|
|Event Source|MSExchangeTransport|
|Event Category|SMTP Protocol|
|Event ID|7004|
|Date:|Date|
|Time|Time|
|User|Not available|
|Computer|Computer_Name|
|Description|This is an SMTP protocol error log for virtual server ID 1, connection #29. The remote host `E2k3server1.contoso.com` responded to the SMTP command "xexch50" with "504 Need to authenticate first. "The full command sent was "XEXCH50 2336 3". This will probably cause the connection to fail.|

|Event Type:|Error|
|---|---|
|Event Source|MSExchangeTransport|
|Event Category|SMTP Protocol|
|Event ID|7010|
|Date|Date|
|Time|Time|
|User|Not available|
|Computer:|Computer_Name|
|Description:|This is an SMTP protocol log for virtual server ID 1, connection #30. The client at "6.5.2.4" sent a "xexch50" command, and the SMTP server responded with "504 Need to authenticate first." The full command sent was "xexch50 1092 2". This will probably cause the connection to fail. These events indicate that the XEXCH50 protocol sink fired, but the exchange of the blobs failed between the servers that are listed in the events.|

**Do you see Event ID 7004 and Event ID 7010 on the destination server?**

- If yes, see [Resolve issue with the XEXCH50 command](#resolve-issue-with-the-xexch50-command).
- If no, see [Run isinteg –fix –test ReplState](#run-isinteg--fix--test-replstate-if-dont-see-event-ie-7004-and-7010).

### Run isinteg -fix -test ReplState (if don't see Event IE 7004 and 7010)

Select your Exchange version to verify and adjust the ReplState setting with following steps:

#### For Exchange Server 2007 and Exchange Server 2010

1. Start Exchange Management Console.
2. Use the `New-PublicFolderDatabaseRepairRequest` cmdlet to detect and fix replication issues in the public folder database. Public folders on the public folder database can still be accessed while the request is running, but you cannot access the public folder currently being repaired. After you begin the repair request, it can't be stopped unless you dismount the database.
3. Run the following cmdlet:

    ```powershell
    New-PublicFolderDatabaseRepairRequest -Database -CorruptionType ReplState
    ```

#### For Exchange Server 2003

1. On the destination server, install the hotfix KB925253.
2. After the hotfix is installed, dismount the public folder database on the server, and then run the following command at a command prompt:

    ```console
    cd C:\Program Files\Exchsrvr\bin
    Isinteg -s -fix -test ReplState
    ```

3. After the isinteg process is finished:
   1. Change the replica list on the public folder on the destination server. To do this, add a replica to or remove a replica from any server. Select **Apply**, reverse the change you just made, and then select **Apply** again.
   2. On the source server, create a new item.
   3. Examine the Application log on the source server for Event ID 3020.
   4. Examine the Application log on the destination server for Event ID 3030.
  
**Do you see Event ID 3030 in the Application log on the destination server?**

- If yes, congratulations! Your Public Folder Replication for Exchange Server 2003 issue is resolved.
- If no, sorry, we cannot resolve an unidentified issue by using this guide. If you contact support regarding this issue, please tell them that the source server is not generating outbound hierarchy replication messages. There is a 3079 event when the database mounts, but the event does not contain **EcReplStartup**.

### Replication Receive Queue Size in Performance Monitor

Public folder replication messages are received by SMTP, categorized and handed to the local SMTP queue. The messages are then submitted to the Public Folder store. Once messages are submitted to the Public Folder store, they are put in the Replication Receive Queue. The messages in the Replication Receive Queue are then processed and changes are performed on the appropriate public folder. The Replication Receive Queue Size performance counter indicates the number of public folder replication messages waiting to be processed.

The larger the replication queue becomes, the more out of synchronization the content in the folders can become. When replication queues grow, there is an increased load on resources as the messages in the replication queue are processed. Also, growing replication queues indicate that public folder content on the server is outdated.

No action is required in the two instances where growth in the Replication Receive Queue is expected and can be planned for:

- On a newly introduced public folder server, growth in the Replication Receive Queue can be caused by the expected initial backfill replication.
- If site consolidation or other major changes in the Exchange topology are occurring, it is expected that there will be lots of replication as the content is moved.

For existing, steady state servers where public folder replicas are not being changed in bulk, this error may indicate:

- Server resource performance bottlenecks such as disk, CPU, network, or memory. If there is a resource bottleneck on the server, the Store.exe process will not be able to process the replication messages fast enough and a queue will grow.
- The public folder replication interval is too short for the replication to complete before the next replication cycle starts.

To resolve this error:

- Monitor the MSExchangeIS Public\Replication Receive Queue Size until it shows that replication is completed before the next replication cycle starts.
- Consider reducing the total number of replicas in the Exchange organization to reduce the volume of replication traffic required.

If you have a High Queue, see [Pause replication](#pause-replication).

If you have a Low Queue, see [Possible ReplState problem](#possible-replstate-problem).

### Pause replication

Pause replication of public folders and let the queues drain or call support.

#### To pause replication

1. Start Exchange Management Console.
2. Use the `Suspend-PublicFolderReplication` cmdlet to stop public folder replication for the entire organization.
3. Monitor the Transport Queues by running `Get-TransportServer | Get-Queue`. Once the queue is reduced, you can resume replication.
4. Use the `Resume-PublicFolderReplication` cmdlet to restart public folder replication for the entire organization.

Sorry, we cannot resolve an unidentified issue by using this guide. If you contact support about this issue, tell them that Replication is Paused and you are waiting for the queues to reduce.

### Looking for the folder ID (FID) (Isolate?)

Does the Event ID 3028 event show the FID but not the folder's name?

- If yes, see [Tombstone because of a deletion](#tombstone-because-of-a-deletion-event-id-3028-event-shows-the-fid).
- If no, sorry, we cannot resolve an unidentified issue using this guide. For more help to resolve this issue, contact Microsoft Exchange Server support.

### Tombstone because of a deletion (Event ID 3028 event shows the FID)

This indicates the folder is a tombstone because of a previous deletion that did not replicate. Go back to the source server and copy the folder to create a new folder with the same content, and then start over.

Is this information helpful?

- If yes, see [Remove duplicate accounts](#remove-duplicate-accounts).
- If no, sorry, We can't solve unidentified issues with this guide. For more help resolving this issue, contact Microsoft Exchange Server support and tell them that when the database mounts, a 3079 event is logged.

### Does performance monitor show a large number of messages queued for submission

Open Performance Monitor.

Add Counter MSExchangeIS Public\Replication Receive Queue and monitor the size of the queue.

If you need to understand more about performance monitor you can go here: Performance Monitoring Getting Started Guide.

**Does performance monitor show a large number of messages queued for submission?**

- If yes, see [Check services](#check-services).
- If no, sorry, we cannot resolve an unidentified issue using this guide. If you contact support about this issue, please tell them that the server is generating outbound hierarchy messages, but those messages do not appear in message tracking, and nothing is being queued for submission.

### Check services

1. Select **Start** > **Run**.
2. Type *services.msc* in the box.
3. Find **MSExchangeTransport** and verify it is started

If you have PowerShell, open it and run the following cmdlet:

```powershell
Get-Service MSExchangeTransport
```

**Is the Transport Service Running?**

- If yes, see [Troubleshoot Public Folder Replication](#troubleshoot-public-folder-replication).
- If no, sorry, we cannot resolve an unidentified issue using this guide. If you contact support about this issue, please tell them that the server is generating outbound hierarchy messages, but those messages do not appear in message tracking, and nothing is being queued for submission.

### Does the 3030 event show the message ID (MID) of the item but not the subject

Does the 3030 event show the MID of the item, but not the subject?

- If yes, see [Tombstone](#tombstone).
- If no, sorry, we cannot resolve an unidentified issue using this guide. If you contact support about this issue, please tell them that the source server is not generating outbound hierarchy replication messages and there is no 3079 event when the database mounts.

### Tombstone

This is usually the result of a tombstone because of a message deletion that has not replicated. You can copy the messages within the folder to create new messages, or copy the entire folder.

Is this information helpful?

- If yes, see [Remove duplicate accounts](#remove-duplicate-accounts).
- If no, sorry, we can't solve unidentified issues with this guide. For more help resolving this issue, contact Microsoft Exchange Server support and tell them that when the database mounts, a 3079 event is logged.

### Track the Event ID 3027

Track the 3027 to see how far it got. If it didn't leave the source server, check the Messages Queued For Submission performance counter under MSExchangeIS Public to see if the outbound messages are stuck in the public store.

Is this information helpful?

- If yes, see [Remove duplicate accounts](#remove-duplicate-accounts).
- If no, sorry, we can't solve unidentified issues with this guide. For more help resolving this issue, contact Microsoft Exchange Server support and tell them that when the database mounts, a 3079 event is logged.

### Possible ReplState problem

It is possible that this issue could be an XEXCH50 problem or a ReplState issue. Before we continue, let's verify that SMTP logging is enabled.

Select your Exchange version to verify and adjust the ReplState setting with following steps：

#### For Exchange Server 2007 and Exchange Server 2010

1. Start Exchange Management Console.
2. Use the `Set-EventLogLevel -Identity "MSExchangeTransport\SmtpReceive" -Level 'Medium'` and `Set-EventLogLevel -Identity "MSExchangeTransport\SmtpSend" -Level 'Medium'` cmdlets to turn on event logging on the SMTP.
3. Use the `Resume-PublicFolderReplication` cmdlet to start public folder replication for the entire organization.

#### For Exchange Server 2003

1. Start Exchange System Manager.
2. Expand **Servers**, right-click **Your_ Server Name**, and then select **Properties**.
3. Select the **Diagnostics Logging** tab, and then select **MSExchangeTransport** under **Services**.
4. Under **Categories**, select **SMTP**.
5. Under **Logging Level**, select **Medium**.

**What's your Exchange version?**

- If Exchange Server 2003, see [Event ID 7004 and Event ID 7010 on the destination server](#event-id-7004-and-event-id-7010-on-the-destination-server).
- If Exchange Server 2007 and 2010, see [Resolve issue with the XEXCH50 command](#resolve-issue-with-the-xexch50-command).

### One or more of the messages was lost in transport

If the number of 3031 events on the destination server is fewer than the number of 3021 events on the source server, one or more of the messages was lost in transport. To troubleshoot the message loss, identify the message ID of the messages that were not replicated.

To do this, examine the Application log on the source server. Then, use message tracking to track the messages and troubleshoot the issue.

**Are there any Exchange Server 2007 or 2010 servers in the path of that message?**

- If yes, see [Exchange Server 2007 and Exchange Server 2010 in the path](#exchange-server-2007-and-exchange-server-2010-in-the-path).
- If no, see [Did that resolve the issue](#did-that-resolve-the-issue).

### Did that resolve the issue

Is your issue now resolved?

- If yes, congratulations! Your Public Folder Replication for Exchange Server 2003 issue is resolved.
- If no, sorry, we cannot resolve an unidentified issue using this guide. For more help to resolve this issue, contact Microsoft Exchange Server support.

### Exchange Server 2007 and Exchange Server 2010 in the path

The most common reason for a lost content backfill response on Exchange Server 2007 or Exchange Server 2010 is a store driver failure. For instance, a backfill response will be sent to an Exchange Server 2007 server, but if you look at the application log on the 2007 side, you never see the incoming replication event. Message tracking shows that the replication message got to the hub transport server and then failed in the store driver.

The first step for troubleshooting is to track the message and see where it failed.

Usually, the hub transport server will log an event 1020 that describes the problem with that particular content. After tracking the message and determining which hub transport server it failed on, please check 1020 event with source MSExchange Store Driver on that hub transport server.

**Do you see a 1020 event with source MSExchange Store Driver on that hub transport server?**

- If yes, you see 1020 event and contain the error **The Active Directory user wasn't found**, follow the instructions given in [Fail to replicate the public folder content to Exchange Server 2010](../migration/public-folders-not-replicate.md). If you contact support about this issue, tell them there is an Empty Servers Container.

  Is this information helpful?

  - If yes, see [Remove duplicate accounts](#remove-duplicate-accounts).
  - If no, sorry, We can't solve unidentified issues with this guide. For more help resolving this issue, contact Microsoft Exchange Server support and tell them that when the database mounts, a 3079 event is logged.
- If yes, you see 1020 event and contain the error **The message content has become corrupted**, see [Exchange Server 2007 and Exchange Server 2010 in the path (The message content has become corrupted)](#exchange-server-2007-and-exchange-server-2010-in-the-path-the-message-content-has-become-corrupted).
- If yes, you see 1020 event but neither of the above error message, see [Exchange Server 2007 and Exchange Server 2010 in the path (see 1020 event but neither of the above error message)](#exchange-server-2007-and-exchange-server-2010-in-the-path-see-1020-event-but-neither-of-the-above-error-message).
- If no, you don't see 1020 event with source MSExchange Store Driver, sorry, we cannot resolve an unidentified issue using this guide. If you contact support about this issue, tell them that the server is generating outbound hierarchy messages, but those messages do not appear in message tracking, and nothing is being queued for submission.

### Exchange Server 2007 and Exchange Server 2010 in the path (The message content has become corrupted)

This message is usually because of corrupt TNEF. If this is a hybrid environment, apply Exchange 2013 CU6 to prevent new corrupt messages, and delete the old ones. To identify the corrupt items, continue with the steps below.

To identify which items are corrupted:

1. Reduce the replication message size to 1k on the source server.
2. On the destination, force another backfill request with **Synchronize Content** or **Update-PublicFolder**.
3. You'll now see one backfill response (event 3021) per item in the folder on the source server. The application log may fill up with backfill responses if the folder contains many items. Once the 3021 activity has calmed down, clear the application log on the source server and force another backfill request. Since all of the good items already replicated in the last round of backfills, the only new items you should see in the new event 3021's should be the corrupted items.

Now you should have one backfill response (3021) for each corrupted item in the application log on the source server, and one 1020 event for each corrupted item in the application log on the hub transport server. Since you now know which items are corrupted (because you can read the item subjects in the 3021 events), you can delete those items or try to fix them.

For more information, see [Fixing Public Folder Replication Errors From Exchange Server 2003 to Exchange Server 2007 or 2010](/archive/blogs/bill_long/fixing-public-folder-replication-errors-from-exchange-2003-to-exchange-2007-or-2010).

**Did that resolve the issue?**

- If yes, see [Track the message in message tracking; Was the message delivered to the destination server?](#track-the-message-in-message-tracking-was-the-message-delivered-to-the-destination-server)
- If no, see [Troubleshoot the source server](#troubleshoot-the-source-server).

### Exchange Server 2007 and Exchange Server 2010 in the path (see 1020 event but neither of the above error message)

This is some other type of corrupted item. To identify which items are corrupted:

1. Reduce the replication message size to 1k on the source server.
2. On the destination, force another backfill request with **synchronize content** or **Update Public Folder**.
3. You'll now see one backfill response (event 3021) per item in the folder on the source server. The application log may fill up with backfill responses if the folder contains many items. Once the 3021 activity has calmed down, clear the application log on the source server and force another backfill request. Since all of the good items already replicated in the last round of backfills, the only new items you should see in the new event 3021 should be the corrupted items.

Now you should have one backfill response (3021 event) for each corrupted item in the application log on the source server, and one 1020 event for each corrupted item in the application log on the hub transport server. Since you now know which items are corrupted (because you can read the item subjects in the 3021 events), you can delete them or try to fix them.

For more information, see [Fixing Public Folder Replication Errors From Exchange Server 2003 to Exchange Server 2007 or 2010](/archive/blogs/bill_long/fixing-public-folder-replication-errors-from-exchange-2003-to-exchange-2007-or-2010).

**Is your issue now resolved?**

- If yes, see [Track the message in message tracking; Was the message delivered to the destination server?](#track-the-message-in-message-tracking-was-the-message-delivered-to-the-destination-server)
- If no, see [Troubleshoot the source server](#troubleshoot-the-source-server).

### Remove duplicate accounts

Remove the duplicate accounts mentioned in the event, or delete one of the users, so that the SID can be resolved for a single user in the DS.

Is this information helpful?

- If yes, congratulations! Your Public Folder Replication for Exchange Server issue is resolved.
- If no, sorry, we cannot resolve an unidentified issue using this guide. For more help to resolve this issue, contact Microsoft Exchange Server support.