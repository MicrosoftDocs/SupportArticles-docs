---
title: IIS events are not displayed remotely
description: This article provides workarounds for the problem where IIS 8.0 events from a Windows Server 2012 Server Core machine are not displayed remotely in Server Manager.
ms.date: 12/11/2020
ms.custom: sap:WWW Administration and Management
ms.subservice: www-administration-management
---
# IIS 8.0 events from a Windows Server 2012 Server Core machine are not displayed remotely in Server Manager

This article helps you work around the problem where Internet Information Services (IIS) 8.0 events from a Windows Server 2012 Server Core machine are not displayed remotely in Server Manager.

_Original product version:_ &nbsp; Internet Information Services 8.0  
_Original KB number:_ &nbsp; 2721972

## Symptoms

When using Server Manager on a full installation of Windows Server 2012 to view IIS 8.0 events from a remote Windows Server 2012 Server Core machine, the IIS-specific events from the Server Core machine are not displayed in the Events tile in Server Manager on the Windows Server 2012 computer.

## Cause

The *WebServer.Events.xml* file is missing from the `Microsoft\ServerManager\Events directory` on the Windows Server 2012 Server Core machine.

## Workaround

To workaround this problem, please take the following steps:

1. On the Windows Server 2012 Server Core machine, navigate to  `%programdata%\Microsoft\ServerManager\Events\`.

2. Create a new .xml file. Name the file *WebServer.Events.xml*.

3. Save the following xml into the *WebServer.Events.xml* file:

    ```xml
    <ViewerConfig>
        <QueryConfig>
            <QueryParams>
                <UserQuery />
            </QueryParams>
            <QueryNode>
                <Name ResourceId="%windir%\system32\svrmgrnc.dll,-422">Web Server</Name>
                <Description ResourceId="%windir%\system32\svrmgrnc.dll,-423">System events for Web Server</Description>
                <SuppressQueryExecutionErrors>1</SuppressQueryExecutionErrors>
                <QueryList>
                    <Query>
                        <Select Path="System">*[System[Provider[@Name='Microsoft-Windows-IIS-APPHOSTSVC']]]</Select>
                        <Select Path="System">*[System[Provider[@Name='Microsoft-Windows-IIS-FTP']]]</Select>
                        <Select Path="System">*[System[Provider[@Name='Microsoft-Windows-IIS-IisMetabaseAudit']]]</Select>
                        <Select Path="System">*[System[Provider[@Name='Microsoft-Windows-IIS-IISReset']]]</Select>
                        <Select Path="System">*[System[Provider[@Name='Microsoft-Windows-IIS-W3SVC']]]</Select>
                        <Select Path="System">*[System[Provider[@Name='Microsoft-Windows-IIS-W3SVC-PerfCounters']]]</Select>
                        <Select Path="System">*[System[Provider[@Name='Microsoft-Windows-IIS-W3SVC-WP']]]</Select>
                        <Select Path="System">*[System[Provider[@Name='Microsoft-Windows-IIS-WMSVC']]]</Select>
                        <Select Path="System">*[System[Provider[@Name='Microsoft-Windows-WAS']]]</Select>
                        <Select Path="System">*[System[Provider[@Name='Microsoft-Windows-WAS-ListenerAdapter']]]</Select>
                    </Query>
                </QueryList>
            </QueryNode>
        </QueryConfig>
    </ViewerConfig>
    ```

## More information

Microsoft has confirmed that this is a problem in the *Original product version* section of this article.
