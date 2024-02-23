---
title: Can't create System.Management.Automation runspaces
description: Describes a by-design behavior that prevents users from creating System.Management.Automation runspaces in a web app. Occurs when implicit credentials are being used. A workaround is provided.
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
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2010 Enterprise
  - Windows Server 2012 R2 Essentials
  - Windows Server 2012 R2 Standard
  - Windows Server 2012 Essentials
  - Windows Server 2012 Standard
  - Windows Server 2008 R2 Enterprise
  - Windows Server 2008 R2 Standard
  - Windows Server 2008 Enterprise
search.appverid: MET150
---
# You can't create multiple System.Management.Automation runspaces in a web app for two or more different users

_Original KB number:_ &nbsp; 3115600

## Symptoms

When you try to allow multiple users to create System.Management.Automation runspaces in a web application and you're using implicit credentials (for example, credentials from impersonation), you notice that only the first user who accesses the web application can call the `CreateRunspace` method. All subsequent requests fail with an exception that resembles:

> System.Management.Automation.PSInvalidOperationException  
at System.Management.Automation.Remoting.Client.WSManClientSessionTransportManager.Initialize  
at System.Management.Automation.Remoting.Client.WSManClientSessionTransportManager..ctor  
at System.Management.Automation.Remoting.ClientRemoteSessionDSHandlerImpl..ctor  
at System.Management.Automation.Remoting.ClientRemoteSessionImpl..ctor  
at System.Management.Automation.Internal.ClientRunspacePoolDataStructureHandler..ctor  
at System.Management.Automation.Runspaces.Internal.RemoteRunspacePoolInternal.CreateDSHandler  
at System.Management.Automation.Runspaces.RunspacePool..ctor  
at System.Management.Automation.RemoteRunspace..ctor  
at System.Management.Automation.Runspaces.RunspaceFactory.CreateRunspace  
at System.Management.Automation.Runspaces.RunspaceFactory.CreateRunspace

## Cause

This behavior is by design.

## Workaround

To create multiple System.Management.Automation runspaces in a web application for two or more different users, you must pass in explicit credentials.

## More information

To create multiple remote management runspaces, make sure that the following conditions are true:

- ASP.NET impersonation isn't enabled on the IIS virtual directory.
- All Windows impersonation logic has been removed from your code.
- Your users are prompted for a user name and password.
