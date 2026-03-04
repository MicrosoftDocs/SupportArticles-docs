---
title: "Authentication failures during Microsoft Graph connector agent setup"
description: "Troubleshoot authentication failures during Microsoft Graph connector agent setup."
ms.date: 03/04/2026
ms.reviewer:
  - peterswimm
  - erickinser
ms.custom: sap:Actions\Connector actions
---

# Authentication failures during Microsoft Graph connector agent setup

The [Microsoft Graph connector agent](/microsoftsearch/graph-connector-agent) is a Windows desktop app used to connect on-premises data to Microsoft Graph.The **invalid application credentials** error usually occurs when the connector agent can’t authenticate using the app registration in Microsoft Entra ID.

To resolve this issue, verify the following:

- The app is correctly registered in Microsoft Entra ID.
- You copied the **Application (client) ID** and **client secret** when the secret was created. The client secret is shown only once.
- The app has the required **application permissions**:
  - `ExternalItem.ReadWrite.OwnedBy`
  - `ExternalItem.ReadWrite.All`
  - `ExternalConnection.ReadWrite.OwnedBy`
  - `Directory.Read.All`
- **Admin consent** has been granted for all required permissions.
- You’re using an account with one of the following roles to configure the agent:
  - Application Administrator
  - Search Administrator
- When entering agent details, the **Agent Name**, **Application ID**, and **Client Secret** are correct and don’t contain extra spaces or typos.
- The machine running the agent can access:
  - `login.microsoftonline.com`
  - `graph.microsoft.com`

If the issue persists, review the local agent logs at `C:\ProgramData\Microsoft\GraphConnectorAgent\Logs`.

Following these steps should allow the agent to register successfully.
