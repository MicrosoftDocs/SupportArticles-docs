---
title: UCWA mobility web service does not accept connections from mobile clients
description: Describes an issue in which unscheduled and unsynchronized recycling processes for the LyncUcwa application pool cause connectivity issues for existing and new Lync 2013 mobile client sessions. Workarounds are provided.
author: simonxjx
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Lync Server 2013
ms.date: 03/31/2022
---

# Lync Server 2013 UCWA mobility web service does not accept connections from Lync 2013 mobile clients

## Summary

The Lync Server 2013 LyncUcwa application pool manages resources for Lync Server 2013 UCWA mobility web services. These web services are hosted locally on the Internet Information Services (IIS) installation for a Lync Server 2013 Front End (FE) server or a Lync Server 2013 Director server. 

Some third-party vendor software may trigger recycling of all the IIS application pools. The LyncUcwa application pool is not reinitialized correctly following an application pool recycle. You can diagnose and fix this problem by using the methods in the "More Information" section. We also recommend that you work with your third-party software vendors to prevent frequent recycling of IIS application pools. 

> [!NOTE]
> Antivirus software may also trigger this kind of event.

## More Information

To identify this issue on the Lync Server 2013 FE server role or on the Lync Server 2013 Director server role, open Event Viewer. To do this, use one of the following methods, depending on the operating system that you're running.

### Windows Server 2008 R2

1. On the **Start** menu, type eventvwr.mscin the Windows search feature.   
2. Right-click the **Event Viewer** icon, and then click **Open**.   

### Windows Server 2012

1. Press the Windows key to access the Start page.   
2. Use the Windows search feature to locate eventvwr.msc.   
3. Right-click the **Event Viewer** icon, and then click **Open**.   

Use Event Viewer to search for the following error events

The following Warning event is logged in the Application log:

```AsciiDoc
Log Name: Application
Source: ASP.NET 4.0.30319.0
Date: dd/mm/yyyy hh:mm:ss AM|PM
Event ID: 1309
Task Category: Web Event
Level: Warning
Keywords: Classic
User: N/A
Computer: server01.contoso.com
Description:
Event code: 3005
Event message: An unhandled exception has occurred. 
Event time: mm/dd/yyy hh:mm:ss AM|PM 
Event time (UTC): mm/dd/yyyy hh:mm:ss AM|PM 
Event ID: 38136224cea44d0190c8a8632b3702b3 
Event sequence: 36 
Event occurrence: 1 
Event detail code: 0 
```

Application information:

```AsciiDoc
Application domain: /LM/W3SVC/34578/ROOT/Ucwa-5-130469956856288486 
Trust level: Full 
Application Virtual Path: /Ucwa 
Application Path: D:\Program Files\Microsoft Lync Server 2013\Web Components\Ucwa\Ext\ 
Machine name: server01
```

Process information:

```AsciiDoc
Process ID: 19988 
Process name: w3wp.exe 
Account name: NT AUTHORITY\NETWORK SERVICE 
```

Exception information:

```AsciiDoc
Exception type: InvalidOperationException 
Exception message: An instance of CollaborationPlatform cannot be used to create an endpoint once it has been shut down.
at System.Web.Http.WebHost.HttpControllerHandler.EndProcessRequest(IAsyncResult result)
at System.Web.HttpApplication.CallHandlerExecutionStep.OnAsyncHandlerCompletion(IAsyncResult ar)
```

Request information:

```AsciiDoc
Request URL: https://xyz.contoso.com/ucwa/v1/applications/212137037738/batch 
Request path: /ucwa/v1/applications/212137037738/batch 
User host address: 10.xxx.xxx.xx 
User: user1@contoso.com
Is authenticated: True 
Authentication Type: WebTicketAssertions 
Thread account name: NT AUTHORITY\NETWORK SERVICE 
```

Thread information:

```AsciiDoc
Thread ID: 144 
Thread account name: NT AUTHORITY\NETWORK SERVICE 
Is impersonating: False 
Stack trace: at System.Web.Http.WebHost.HttpControllerHandler.EndProcessRequest(IAsyncResult result)
at System.Web.HttpApplication.CallHandlerExecutionStep.OnAsyncHandlerCompletion(IAsyncResult ar)
```

Custom event details:

```AsciiDoc
Event Xml:
<Event xmlns="https://schemas.microsoft.com/win/2004/08/events/event">
 <System>
 <Provider Name="ASP.NET 4.0.30319.0" />
 <EventID Qualifiers="32768">1309</EventID>
 <Level>3</Level>
 <Task>3</Task>
 <Keywords>0x80000000000000</Keywords>
 <TimeCreated SystemTime="2014-06-11T21:28:33.000000000Z" />
 <EventRecordID>54402</EventRecordID>
 <Channel>Application</Channel>
 <Computer>server01.constoso.com</Computer>
 <Security />
 </System>
 <EventData>
 <Data>3005</Data>
 <Data>An unhandled exception has occurred.</Data>
 <Data>6/11/2014 9:28:33 PM</Data>
 <Data>6/11/2014 9:28:33 PM</Data>
 <Data>38136224cea44d0190c8a8632b3702b3</Data>
 <Data>36</Data>
 <Data>1</Data>
 <Data>0</Data>
 <Data>/LM/W3SVC/34578/ROOT/Ucwa-5-130469956856288486</Data>
 <Data>Full</Data>
 <Data>/Ucwa</Data>
 <Data>D:\Program Files\Microsoft Lync Server 2013\Web Components\Ucwa\Ext\</Data>
 <Data>server01</Data>
 <Data>
 </Data>
 <Data>19988</Data>
 <Data>w3wp.exe</Data>
 <Data>NT AUTHORITY\NETWORK SERVICE</Data>
 <Data>InvalidOperationException</Data>
 <Data>An instance of CollaborationPlatform cannot be used to create an endpoint once it has been shut down.
 at System.Web.Http.WebHost.HttpControllerHandler.EndProcessRequest(IAsyncResult result)
 at System.Web.HttpApplication.CallHandlerExecutionStep.OnAsyncHandlerCompletion(IAsyncResult ar)
</Data>
 <Data>https://abc.contoso.com:4443/ucwa/v1/applications/212137037738/batch</Data>
 <Data>/ucwa/v1/applications/212137037738/batch</Data>
 <Data>10.xxx.xxx.xx</Data>
 <Data>abc.contoso.com</Data>
 <Data>True</Data>
 <Data>WebTicketAssertions</Data>
 <Data>NT AUTHORITY\NETWORK SERVICE</Data>
 <Data>144</Data>
 <Data>NT AUTHORITY\NETWORK SERVICE</Data>
 <Data>False</Data>
 <Data> at System.Web.Http.WebHost.HttpControllerHandler.EndProcessRequest(IAsyncResult result)
 at System.Web.HttpApplication.CallHandlerExecutionStep.OnAsyncHandlerCompletion(IAsyncResult ar)
</Data>
 </EventData>
</Event>Note The Application event information that's displayed in bold in the preceding text will be included in instances of event ID 1309 when the issue that's described in the "Summary" section occurs.
```

This issue is triggered by the default configuration of the LyncUcwa application pool's disallowOverlappingRotation and shutdownTimeLimit properties. These properties function correctly during the LyncUcwa application pool's default operation. To provide more efficient performance by the LyncUcwa application pool during periods of non-default operation, use the method that's described in the "Workaround" section.

> [!NOTE]
> The LyncUcwa application pool's configuration updates that are described in the "Workaround" section will be added to a future version of the Lync Server 2013 UCWA mobility web services role.

## Workaround

The following procedures must be performed on all Lync Server 2013 FE server and Director Lync 2013 server roles. To perform these procedures, first open a command prompt as an administrator.

### Windows Server 2008 R2

1. On the **Start** menu, type cmd.exe in the Windows search feature, and then press Enter.   
2. Right-click **cmd.exe**, and then click **Run as administrator**.

### Windows Server 2012

1. Press the Windows key to access the Start page.   
2. Use the Windows search feature to locate cmd.exe.   
3. Right-click **cmd.exe**, and then click **Run as administrator**.   

In the Command Prompt window, follow these steps:

1. Navigate to the %install drive%:\Windows\System32\inetsrv> directory prompt.   
2. Enter the following command, and then press Enter:

    ```powershell
    appcmd set config /section:applicationPools /[name='LyncUcwa'].recycling.disallowOverlappingRotation:true
    ```
3. Enter the following command, and then press Enter:

    ```powershell
    appcmd set config /section:applicationPools /[name='LyncUcwa'].processModel.shutdownTimeLimit:0.00:00:30
    ```
4. To confirm the changes from steps 2–3, enter the following command, and then press Enter:

    ```powershell
    appcmd list apppools lyncucwa /config
    ```

The following information should be returned to the console to confirm the update to the LyncUcwa application pool settings:

```AsciiDoc
<add name="LyncUcwa" autoStart="true" managedRuntimeVersion="v4.0" managedPipelneMode="Integrated" startMode="AlwaysRunning">
 <processModel identityType="NetworkService" idleTimeout="00:00:00" shutdownTieLimit="00:00:30" />
 <recycling disallowOverlappingRotation="true">
 <periodicRestart time="00:00:00">
 <schedule>
 </schedule>
 </periodicRestart>
 </recycling>
 <failure />
 <cpu />
</add>
```

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
