---
title: Single-application sharing with Terminal Server
description: Describes how to set up a Terminal Server and Terminal Server Client for single-application sharing.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, willgloy
ms.custom: sap:remote-desktop-sessions, csstroubleshoot
---
# Single-application sharing with Terminal Server

This article describes how to set up a Terminal Server and Terminal Server Client for single-application sharing.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 186608

## Summary

With single-application sharing, the user clicks a shortcut icon (or the shortcut executes in a logon script, startup group, and so on) that launches the Terminal Server Client; automatically logs the user, and launches a single application, with no accompanying desktop. When the user exits the application, the Terminal Server Client session terminates.

## More information

Administrators may want to create an environment for single-application users using Terminal Server and the Terminal Server Client. It is possible to create a startup environment in which every user connecting to a particular Terminal Server logs on automatically and/or runs a common, single application. It is also possible to define multiple connections on a Terminal Server so that one connection supplies one application, and another connection supplies another application. User Manager may also be used to specify a single application for a specific user.

There are two general areas on which the administrator must focus to be able to set up a Terminal Server and Terminal Server Client for single- application sharing. First, determine the environment.

1. Determine whether you want users to:

    1. Specify a unique username and password at logon.
    2. Log on with a predefined username, and required to specify a password.
    3. Log on with both a predefined username and password.
    4. All use the same account and password (as might be true for anonymous access).
2. Determine whether you want users to:

    1. Run a single application.
    2. Some users to run a single application and others to get a normal desktop.
    3. Some users to run one application, others to run a separate application, and others to get a normal desktop.
    4. Most users to get a normal desktop but individual users to run single applications.

The second area of focus is that the administrator needs to be familiar with the tools and their options.

1. Connection Configuration One connection is defined by default - rdp-tcp. This is the RDP protocol being encapsulated within TCP. If you add a second network adapter, you can define a second connection (also using the rdp-tcp protocol/transport). Only one connection can be defined per network adapter.

    If you examine the advanced properties of the connection, you will see that you can specify the following for that connection:

    A username to automatically use.A password to automatically use.A domain to automatically log on to. An initial program to run. These options can be used separately or together. They will affect every user who connects using this defined connection. Specifying all these options would create an environment in which all users would automatically log on with this username and password into this domain and would run this single application. When the user exits the application, the client session terminates.
2. User Manager Terminal Server's User Manager allows specific user configurations. Open a user account and then press the CONFIG button. The options here will look similar to those in Connection Configuration, and they work the same way. With configuration options, you can specify an automatic logon and a single application that the user will run.

If you create both Connection Configuration options and User Manager options for autologon and/or an initial program, the Connection Configuration settings always override those set in User Manager. This means that if you want to specify options in Connection Configuration and also create configurations for specific users in User Manager, you will need to install at least two network adapters; define a configuration for each adapter in Connection Configuration; use one defined connection for general connections and modified User Manager accounts; and use the other defined connections and its options for autologon/single-application launching.
