---
title: Connection Configuration in Terminal Server
description: Discusses the Terminal Server Administration tool, Connection Configuration.
ms.date: 05/16/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:administration, csstroubleshoot
ms.subservice: rds
---
# Connection Configuration in Terminal Server

This article discusses the Terminal Server Administration tool, Connection Configuration.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 186566

## More information

When you open this tool, you see that one connection is created by default, the RDP-TCP connection. Typically, this is the only connection that needs to be defined. Nothing needs to be done to enable this connection.

The RDP-TCP connection is a socket connection over TCP port 3389. In this tool, you can specify how long clients can remain connected, if a specific application should run when the client connects, choose the level of encryption, and so on.

You can have one connection defined per transport per type per adapter. So, in a normal Terminal Server with one adapter, you can define exactly one connection since there's only one connection type available. Terminal Server 4.0 by itself with no additional services supports ONLY RDP over TCP connections. If you add a second adapter, you can define a second RDP-TCP connection for that adapter.

Citrix's Metaframe product may be installed on the Terminal Server so Citrix's ICA clients rather than Microsoft's RDP client can be used to connect to Terminal Server. In this tool and in User Manager, you will find options that do not apply unless Metaframe is installed on the Terminal Server.

On a Citrix Winframe Server or on a Terminal Server with Metaframe installed, customers have the option of creating different connection types for different ICA clients (for example, Macintosh clients, asynch clients, SPX clients).

Right-clicking a defined connection brings up a menu that allows you to edit the connection configuration.

Notice that the connection Name, Type, and Transport are unavailable. The name can be changed under Connection/Rename, but the Type and Transport cannot be changed.

The Lan Adapter drop-down list shows "All Lan Adapters..." and any installed adapters. Notice that the connection by default applies to all installed adapters, so just because you have multiple adapters does not mean you must define new connections. You can, but it is not a requirement.

Maximum Connection Count means what it says. Do not confuse this with licensing. This setting governs how many socket connections are allowed. The default is Unlimited.

If you select Client Settings on the Edit Connection screen, you will see a list of options intended primarily for the Citrix ICA client. These settings do not apply to the RDP client. Because the RDP client establishes only a single data channel between the client and the server, mapping to local devices is not possible. Inside an RDP client session, all "local" resources are the Terminal Server's resources.

However, Citrix's ICA clients have been modified to create multiple data channels between client and server. These settings are included for customers who load Metaframe on Terminal Server and use the ICA clients.

Clicking Advanced on the Edit Configuration screen opens many options, although, again, some apply only to the Citrix ICA client.

Note the selections "Inherit user config," "Inherit client config," and "Inherit client/user config." User config selections are also available in Terminal Server User Manager as options for specific users. Client config options can be set at the client using Client Configuration Manager (installed with the Client software) or in the client's registry (for 32- bit) or .ini file (for 16-bit) settings.

Any values set on this screen apply to all connections at this Terminal Server (and no others, regardless of domain relationship, these settings are specific to the Terminal Server).

Note also that any values set here will override settings for users in User Manager.

Below is a description of the various advanced options:

### Logon

If you disable Logon, you're disabling client connections. This doesn't keep non-client users from connecting to the server (for that you would have to pause or stop the Server or Netlogon services). If you want to keep clients from connecting and establishing terminal sessions, this is where you do it.

> [!NOTE]
> If you're used to pausing or stopping the Server or Netlogon services to keep users from connecting to the server, you'll be tempted to try to stop the Terminal Server service. This service can't be stopped. You can change it to manual or disabled, but when you restart the server, this service will return to automatic and will start. This is by design. This service is integral to Terminal Server's operation.
>
> Stopping the Server or Netlogon services doesn't keep Terminal Server clients from connecting. These connections use a different connection path. Again, disabling logon here in Connection Configuration is the way to deny client connections. It's also possible to deny connections based on permissions (more detail below).

### Timeout Settings (in Minutes)

Here you can choose how long a connection should be maintained, how long a disconnected session should be maintained in memory, and how long a session should be allowed to be idle before disconnecting it.

The Connection Timeout determines how long the client can stay connected, regardless of whether the session is idle or not.

The Disconnected Session Timeout determines how long a disconnected session should be held in memory. If a client disconnects (rather than logging off), the session is not terminated. Rather, it is held in memory so that the client can reconnect and re-establish the session. Applications that were running previously should still be available.

The Idle Session Timeout determines how long a session with no activity should remain connected. Turning on the Menu Bar clock will generate enough continuous traffic to keep a session from being idle.

If you uncheck No Timeout, the default for Connection is 120 minutes, for Disconnection is 10 minutes, and for Idle is 30 minutes.

Setting these values here affects every Client that uses this connection. If you want to modify the values for a specific user, you can do so in User Manager. However, keep in mind that Connection Configuration values override values in User Manager. If you need both advanced options set in Connection Configuration AND separate options set for individual users in User Manager, you will need to add multiple network adapters to your Terminal Server and define a different connection for each adapter.

### Security

Low encryption = Microsoft 40-bit encryption from client to server only. Medium encryption = Same as low but applies in both directions. High encryption (Non-export) = 128-bit standard RC4 encryption High encryption (Export) = 40-bit standard RC4 encryption

Use Default NT Authentication: This forces any Client on this connection to use MSGINA. Otherwise, a third-party GINA might be used.

### Autologon

If a correct user name, domain, and password are entered here, clients will automatically log on as this user after connection. There are obvious drawbacks to this approach (for example, profiles, home directories). However, because clients are identified to the system by their unique SessionIDs, not their logon names, it is possible for all client users to use the same logon name.

### Initial Program

Here you can specify a program that will run for every Client user after connecting and logging on.

If a program is specified here, it is the ONLY application that runs on this connection. The user will connect, log on, and run this application (provided security is not an issue) but will get no desktop. When the user closes the application, the session is terminated. This can be a useful feature in a single application environment.

### User Profile Overrides: Disable Wallpaper

Disabling wallpaper can significantly decrease screen redraw times. This is especially useful for clients connecting over RAS.

### On a Broken or Timed out Connection

If a connection is lost or times out, you have the options of disconnecting the session, which leaves the session intact so the user can reconnect and keep working, or you can reset the connection, which terminates the session.

### Reconnect Sessions Disconnected

This option is used for Citrix direct-serial-port connecting devices only.

From Any Client: If your session is disconnected at one device, you can reconnect from any Client device.

From This Client Only: If your session is disconnected, you cannot reconnect from another Client device.

### Shadowing

This feature is only available with the Citrix ICA client.

Another feature of Connection Configuration is the Security/Permissions menu.

Users or groups can be assigned permissions to the connection. Permissions are cumulative except for No Access, so a user who normally has guest access but who is a member of a group with full access will receive full access.

### No Access

As you might expect, this means you have no access to the connection.

### Guest Access

This permits logging on and logging off only. Guests cannot disconnect sessions or reconnect to disconnected sessions.

### User Access

This allows users to:

- Log on or log off.
- Query information through Terminal Server Administrator or at a command prompt with the Query command.
- Send messages through Terminal Server Administrator.
- Reconnect to disconnected sessions.
- Disconnect their own session (leaving it resident on the Terminal Server).

### Full Access

This allows all of the above plus permission to:

- Shadow (ICA Clients only).
- Reset sessions.
- Delete sessionsAlong with Guest, User, and Full permissions, there's a more granular set of permissions called Special Access that is used to grant each of the above individually.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-user-experience.md#remote-desktop-disconnection-configuration).
