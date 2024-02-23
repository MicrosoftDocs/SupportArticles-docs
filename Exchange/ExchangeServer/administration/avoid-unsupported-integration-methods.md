---
title: Avoid unsupported methods to integrate with Exchange
description: Discusses how third-party applications that use unsupported methods to integrate with Exchange Server can cause crashes, data loss, and other problems.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: danba, brijs, catagh, gbratton, dvespa, v-six
appliesto: 
  - Exchange Server 2013 Enterprise
  - Exchange Server 2010 Enterprise
  - Exchange Server 2016 Enterprise Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Avoid unsupported integration methods for Exchange

_Original KB number:_ &nbsp;3086992

## Introduction

This article describes how Microsoft Customer Service and Support can help developers produce custom solutions that use various open standards and that also integrate with Microsoft Exchange Server.

## More information

It's important to use supported APIs and methodologies when you write code for Exchange Server. Sometimes, developers try to augment the behavior of Exchange or otherwise integrate applications with Exchange Server by using some unsupported methodology. This can cause Exchange to become unstable and behave in an unexpected manner.

The following practices aren't supported by Microsoft:

- Using thread impersonation against Exchange by using APIs that don't specifically support thread impersonation.
- Changing the Outlook Web App (OWA), Exchange Web Services (EWS), Exchange ActiveSync (EAS), or similar streams on the Client Access server (CAS).
- Running an ISAPI extension or module in an Exchange application pool.
- Changing the account under which an Exchange application pool runs.
- Injecting DLLs into Exchange processes in an unsupported mannerExchange Server uses specific interfaces and practices for which it's designed and tested. Because these particular practices introduce features by using an unsupported methodology, Microsoft considers this type of development to be unsupported.

When Microsoft Support agents find third-party applications that seem to use one of the listed methodologies, they'll most likely ask you to remove the application to check whether the issue reproduces. If the issue doesn't reproduce after the third-party application is removed, you would have to contact the support engineers for that product to resolve the problem.

Exchange has checks to prevent code from doing thread impersonation. For example, Exchange can shut down its process suddenly (FastFail). In this situation, Event 4999 is logged in the Exchange event log. It contains the following text:

> M.E.D.D.ConnectionPoolManager.BlockImpersonatedCallers

APIs such as EWS that allow impersonation by other applications have the mechanisms to impersonate accounts themselves. Security software and single sign-on software are common examples of applications that use thread impersonation to change credentials on calls that are sent to Exchange.

Third-party code that's run in one application under the worker pool process of another application can cause issues unless the applications are made to work with one other. Exchange doesn't allow other applications to run under its worker processes. The Exchange application pool processes belong exclusively to Exchange, and you shouldn't run third-party code under them. Doing this may cause conflicts with Exchange and could cause processes to fail.

Some developers change the account under which parts of Exchange work to gain some functionality that they wouldn't have otherwise. This can cause server crashes, data corruption, and other unexpected problems. These problems might occur at any point in the process.

There are supported ways to integrate custom DLLs with Exchange, such as custom transport agents. We don't recommend using a method that's not supported by Exchange development. For example, a forced injection of a DLL is an unsupported method to load a custom DLL into Exchange.

It's important that you avoid methods that aren't supported when you consider the option to integrate third-party applications with Exchange. This kind of practice can have severe consequences later, such as lost functionality or the need to rewrite an application. In the end, you might meet a road block and have no path in which to move forward.
