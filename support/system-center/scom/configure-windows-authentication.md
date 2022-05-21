---
title: Configure Windows authentication in AVIcode
description: Describes how to configure Windows authentication for the SELog virtual directory in AVIcode Intercept Studio.
ms.date: 08/13/2020
---
# Configure Windows authentication for the SELog virtual directory in AVIcode Intercept Studio

In AVIcode Intercept Studio, the Intercept Service on the agents connects to the SELog virtual directory on the SE-Viewer to upload collected monitoring data. The SELog virtual directory is configured to allow anonymous authentication by default, but some organizations may want to enable Windows authentication for this virtual directory to prevent unauthorized systems from connecting.

_Original product version:_ &nbsp; AVIcode, Inc.  
_Original KB number:_ &nbsp; 2509259

## Configure Windows authentication for the SELog virtual directory

1. Create a service account for the Intercept Service to use on agents.
2. On the SE-Viewer computer, grant the service account **Read** and **Write** permissions for the SELog virtual directory. The following path is the default local path of the directory on 32-bit Windows versions:

    `C:\Program Files\AVIcode\Intercept\SEViewer\LogWS`

    On 64-bit Windows versions, the following path is the default path:

    `C:\Program Files (x86)\AVIcode\Intercept\SEViewer\LogWS`

3. On the Intercept Agent computers, add the service account to the local Administrators group to allow it to sign in as a service and monitor all .NET Framework applications.
4. Configure the Intercept Service on agents to sign in using the specific service account.
5. Add the username and password to the SEAgent.config file on each agent. See [details about this step](#details-about-step-5) later in the article.
6. Sign in to the Intercept Agent computers with the credentials of the service account and encrypt the SEAgent.config file using EFS to protect the username and password.
7. On the SE-Viewer computer, use IIS Manager to disable anonymous authentication for the SELog virtual directory and enable Windows authentication instead.
8. Restart the Intercept Service on agents and monitor the Intercept event log to make sure that it connects successfully.

## Details about step 5

The SEAgent.config file on each agent stores its connection configuration. The following path is the default location of the file:

`C:\Program Files\AVIcode\Intercept\Agent\v5.x.x\Configuration`

In the above folder path, *5.x.x* is the version and build number of Intercept Studio.

The Start menu contains a shortcut to open the configuration file. To use the shortcut, select **AVIcode Intercept Studio** on the **All Programs** menu, point to **Intercept Configuration** and then select **Connection Configuration**.

SEAgent.config is an XML file. Within its alias element, add `userName` and `password` elements immediately after initializeString. Here is an example:

```xml
<alias>
                                <name>SEViewer</name>
                                <connectionType>WebService</connectionType>
                                <initializeString>http://site/selog/semlogws.asmx</initializeString>
                                <userName>SomeUser</userName>
                                <password>SomePassword</password>
                                <proxy/>
</alias>
```
