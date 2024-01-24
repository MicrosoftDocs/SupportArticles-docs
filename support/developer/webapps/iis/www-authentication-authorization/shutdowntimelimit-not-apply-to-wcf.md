---
title: ShutdownTimeLimit doesn't apply to WCF
description: This article provides workarounds for the problem where IIS application pool ShutdownTimeLimit recycle property does not apply to WAS-hosted WCF services using net.tcp.
ms.date: 04/07/2020
ms.custom: sap:WWW authentication and authorization
ms.technology: www-authentication-authorization
---
# IIS application pool ShutdownTimeLimit recycle property does not apply to WAS-hosted WCF services using net.tcp

This article helps you resolve the problem where Microsoft Internet Information Services (IIS) application pool `ShutdownTimeLimit` recycle property doesn't apply to WAS-hosted Communication Foundation (WCF) services by using net.tcp.

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 2819362

## Symptoms

After implementing a Windows WCF service hosted by the Windows Activation Service (WAS), the IIS application pool assigned to the application has a recycle shutdown time `ShutdownTimeLimit` set to 90 seconds. This allows the WCF service time to complete any active work items should the application pool be recycled. However, when the application recycle occurs the existing worker process shuts down prior to 90 seconds, preventing the active work from completing.

## Cause

This behavior is by design.

Net.tcp behaves differently than Hypertext Transfer Protocol (HTTP) in the presence of an IIS application pool recycle and aborts the connection before the `ShutdownTimeLimit` timer is reached, shutting down the worker process that was handling the request. HTTP applications will honor the `ShutdownTimeLimit` timer however net.tcp applications do not.

The underlying problem is that when the IIS application pool recycle occurs the session information for the net.tcp channel is lost. When the application pool is restarted it can reopen an HTTP channel as IIS handles the channel information, however for the net.tcp connection it is SMSvcHost.exe that actually controls this channel. IIS does not re-engage the SMSvcHost.exe to reopen the channel. At that point, the client connection has been closed and the client must restart the communication.

The net.tcp WAS implementation uses SMSvcHost.exe to listen for incoming TCP requests. When received, SMSvcHost.exe sets up an internal named-pipe connection to invoke the corresponding WCF service. This is effectively an invisible duplex channel. When the IIS application pool is recycled, session state information is lost and the named-pipe duplex connection is broken. A hard-coded one-minute timeout inside SMSvcHost.exe eventually aborts the socket connection.

This has two consequences:

- The client channel gets a socket exception and must be reopened to be used again.
- The WCF operation that was running gets aborted before the normal IIS `ShutdownTimeLimit` timer value. The broken duplex connection causes WCF to abort the operation.

## Workaround

To work around this issue, consider a way to queue the necessary cleanup work somewhere not reliant on session state as opposed to relying on the IIS `ShutdownTimeLimit` interval to do necessary cleanup work in a fixed period of time.

## More information

It is also advised to install a hotfix from [Microsoft Connect Has Been Retired](/collaborate/connect-redirect?downloadid=35626). However, it does not resolve this issue. It avoids a related issue where SMSvcHost.exe stops responding to all requests.
