---
title: Intune Connector for Active Directory installed but doesn't appear
description: Describes an issue in which the Intune Connector for Active Directory is installed but doesn't appear in Intune, and you receive an error message.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Windows enrollment
ms.reviewer: kaushika
---
# Intune Connector for Active Directory is installed but doesn't appear in Intune

This article provides a solution for the issue that the Intune Connector for Active Directory doesn't appear after it is installed in Microsoft Intune.

## Symptoms

After you [install the Intune Connector for Active Directory](/mem/intune/enrollment/windows-autopilot-hybrid#install-the-intune-connector), it doesn't appear in Intune. Additionally, the following error entry is logged in the **ODJ Connector Service** event log on the server that hosts the connector:

> "DiagnosticText": "We are unable to complete your request because a server-side error occurred. Please try again. [Exception Message: \\"DiagnosticException: 0x0FFFFFFF. We are unable to complete your request because a server-side error occurred. Please try again.\\"] [Exception Message: \\"Failed to get a value for Key: OdjServiceBaseUrl\\"] [Exception Message: \\"The given key was not present in the dictionary.\\"]"

> [!NOTE]
> The **ODJ Connector Service** event logs are located under **Event Viewer** > **Application and Services Logs** > **Microsoft** > **Intune** > **ODJConnectorService**. Select **Microsoft-Intune-ODJConnectorService/Admin** or **Microsoft-Intune-ODJConnectorService/Operational**.

## Cause

This issue usually occurs when you use a proxy server in your environment. Additional configuration settings are required on the proxy so that the Intune Connector can communicate with the Intune service.

## Solution

To fix the issue, add the required proxy configuration to the following file:

`%ProgramFiles%\Microsoft Intune\ODJConnector\ODJConnectorSvc\ODJConnectorSvc.exe.config`

To do this, follow these steps:

1. Open the .config file. You can see the following lines at the top of the file:

    ```xml
    <?xml version="1.0" encoding="utf-8" ?>
    <configuration>
    ```

2. Add the following lines after `<configuration>`, then save the file.

    ```xml
    <system.net>
       <defaultProxy>
          <proxy usesystemdefault="false" proxyaddress="http://<proxy server address>:<port>" />
       </defaultProxy>
     </system.net>
    ```

3. Restart the **Intune ODJConnector Service**.
