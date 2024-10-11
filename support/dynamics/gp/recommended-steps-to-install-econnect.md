---
title: Recommended steps to install eConnect for Dynamics GP in a Workgroup Environment
description: The installation process requires that the eConnect service account be a Windows user. The installation fails because the user logged into the Workgroup computer does not have access to create SQL users or the account being used for the eConnect service account cannot be resolved. This article contains a workaround to the issue.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# The recommended steps to install eConnect for Microsoft Dynamics GP in a Workgroup Environment that will resolve the "Unable to add user to SQL" error message

This article provides a solution to an issue where the installation process for eConnect on Microsoft Dynamics GP will fail when you install eConnect on a Workgroup computer that points to a SQL server on another computer in a domain.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2534520

## Symptoms

The installation process for eConnect on Microsoft Dynamics GP will fail when you install eConnect on a Workgroup computer that points to a SQL server on another computer in a domain. You will receive the following error message in this environment:

> Unable to add user to SQL.

## Cause

The installation process requires that the eConnect service account be a Windows user. The installation fails because the user logged into the Workgroup computer does not have access to create SQL users or the account that is used for the eConnect service account cannot be resolved.

## Resolution

The installation process requires that the desired computer for the eConnect installation must be on a domain.

The following steps can be used to ultimately have the eConnect Integration Service that is running on a workgroup computer and the SQL Server is running on another computer in a domain. The process requires the installer to join the eConnect computer to the domain, run the installation for eConnect on the desired computer, and then remove the computer from the domain so that it is back in a Workgroup.

1. Create a domain account called eConnectService that will be used during the installation for the eConnect service account.
2. Join the eConnect computer to the domain and run the eConnect installation. During the installation, you will have to use the domain account from step 1 for the eConnect service account.
3. After the installation completes, remove the eConnect computer from the domain, and then create a local user account called eConnectService with the same password used for the domain account in step 1.
4. Run the statements listed here at a command prompt to set the URL reservation for the local account from step 3:

    > [!NOTE]
    > You will receive "The parameter is incorrect" for any syntactical error (leaving off the trailing slash, for example).

    1. `netsh http delete urlacl url=http://+:80/Microsoft/Dynamics/GP/eConnect/`
    2. `netsh http add urlacl user=computer_name\econnectService url=http://+:80/Microsoft/Dynamics/GP/eConnect/`

        > [!NOTE]
        > Replace "computer_name" with the computer name of the eConnect computer.

5. On the SQL server, create a local user account called eConnectService with the same password used for the domain account (and the local user account on the workgroup machine). Ensure that this local user account (on the SQL server) has a SQL login and is added to the DYNGRP role in the DYNAMICS and company databases.

6. eConnect for Microsoft Dynamics GP should now be ready to use on the workgroup computer.
