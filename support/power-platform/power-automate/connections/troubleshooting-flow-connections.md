---
title: Troubleshooting Flow Connections
description: Defines some errors occur while creating connections in Flow or Power Apps, and provides some troubleshooting steps and possible solutions.
ms.reviewer: 
ms.date: 03/31/2021
ms.subservice: power-automate-connections
---
# Troubleshooting Flow Connections

This article defines some errors you might see while creating connections in Flow or Power Apps, and provides some troubleshooting steps and possible solutions.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4526874

## User is unable to switch accounts on a connection

The behavior in this scenario is that a user tries to switch the account for an OAuth connection that they've created. However, when the pop-up is displayed and the user enters their credentials, they're redirected back and see that the account information for the connection hasn't updated.

A possible reason you might see this issue is because of single sign-on policies in your Microsoft Entra tenant. If single sign-on is enabled, your browser might prevent the currently signed in user to be logged out and instead tries to keep the user signed in.

One way to work around it's to open up another browser or incognito window, sign in as the user that owns/has access to the connection, and try to switch accounts on the intended connection. You should update the connection name and account details for the connection.
