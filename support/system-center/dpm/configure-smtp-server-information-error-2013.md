---
title: Error 2013 when configuring SMTP server information
description: Fixes an issue where you receive error 2013 when you configure SMTP server information in System Center Data Protection Manager.
ms.date: 07/23/2020
ms.reviewer: slight, cbutch
---
# Configuring SMTP server information in Data Protection Manager fails with error ID 2013

This article helps you fix an issue where you receive error 2013 when you configure Simple Mail Transfer Protocol (SMTP) server information in System Center Data Protection Manager.

_Original product version:_ &nbsp; System Center Data Protection Manager 2010, System Center 2012 Data Protection Manager  
_Original KB number:_ &nbsp; 2020373

## Symptoms

Configuring SMTP server information in System Center Data Protection Manager 2010 and System Center 2012 Data Protection Manager (DPM) fails with the following error:

> ID: 2013  
> Details: Logon failure: unknown user name or bad password

## Cause

It can occur if you configure credentials for a non-authenticated SMTP server as DPM expects credentials for an authenticated SMTP server. Configuring a non-authenticated SMTP server only supplies the SMTP server name, server port, and **from** address. Because of it, DPM passes incorrect information resulting in the error.

## Resolution

Fill in all the fields of the **SMTP Server** dialog with the correct information including a username and password.

## More information

DPM requires the population of all fields under the **SMTP Server** options regardless whether the SMTP server accepts anonymous connections or not.

When providing a username and password, ensure the account has administrative privileges on the DPM server. A non-administrative account receives the following error:

> An authentication error occurred when trying to connect to the SMTP server. (ID: 518)  
> You typed an incorrect user name, password, or SMTP server name. Type the correct user name or password to enable e-mail delivery of reports and alerts notifications.
