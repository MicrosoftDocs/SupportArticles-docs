---
title: The CRM For Outlook button appears
description: Describes a by design behavior that you may see the Get CRM For Outlook button at the top of the Microsoft Dynamics CRM web client after installing Update Rollup 7 for Microsoft Dynamics CRM 2011.
ms.reviewer: chanson, mmaasjo
ms.topic: article
ms.date: 
---
# The CRM For Outlook button appears after installing Update Rollup 7 for Microsoft Dynamics CRM 2011

You install Update Rollup 7 for Microsoft Dynamics 2011 and then you see a **Get CRM For Outlook** button at the top of the Microsoft Dynamics CRM web client. The button is an additional way for you to install Microsoft Dynamics CRM for Microsoft Office Outlook. It ensures you get the correct installation files and gives you a quicker deployment method if you do not use tools like SMS or GPO.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2004601

When you select **CRM for Outlook** button, it will launch the ClientInstaller.exe that is in the _root directory on the Dynamics CRM Application server. The ClientInstaller.exe is added with the Update Rollup 7 installation. This will start the install and also start the download of the rest of the install package from the Microsoft download site. You can then continue with the install.

> [!NOTE]
> The [Microsoft Dynamics CRM 2011 Implementation Guide](https://www.microsoft.com/download/details.aspx?id=3621) has the complete steps to install Microsoft Dynamics CRM for Microsoft Office Outlook.

Once Microsoft Dynamics CRM for Microsoft Office Outlook is installed then you need to start the Configuration Wizard. To start the Configuration Wizard complete one of the following methods:

- Start Microsoft Office Outlook and the Configuration Wizard will launch automatically.
- Select **Start**, select **All Programs**, select **Microsoft Dynamics CRM 2011**, and select **Configuration Wizard**.

The Configuration Wizard verifies if the client computer has a Default_Client_Config.xml file in the C:\Users\username\AppData\Roaming\Microsoft\MSCRM directory. If the Default_Client_Config.xml file exists there, it will use that xml file for the configuration. If the Default_Client_Config.xml file does not exist there, it will use the default values and input will be required for the server url and the organization to connect to.

> [!NOTE]
> More information on creating this configuration file can be found in the Chapter 7 of the Installing Guide in the Implementation Guide.

The following is an example of the Default_Client_Config.xml file:

```xml
<CRMConfiguration>
    <Client>
        <ServerUrl Type="OnPremise" ShowUser="True"> https://crmdiscoveryservice/MSCRMServices</ServerUrl>
        <ExtranetServerUrl>https://PathToExternalDiscoveryService</ExtranetServerUrl>
        <Organization>OrganizationName</Organization>
        <CEIP option="True|False" />
        <Database Reuseexisting="True | False"/> 
    </Client>
</CRMConfiguration>
```

To download the install package from a local network share instead of the Microsoft Download Site complete the following steps:

1. On each of the client machines select **Start**, select **Run** and type *Regedit*, and select **OK**.
2. Locate the following registry subkey:
   `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MSCRMClient`
3. Right-click MSCRMClient, select **New**, and then select **String Value**.
4. Name the new key `InstallerUrl`.
5. Right-click `InstallerUrl`, select **Modify**, and then type the path to the network share.

   Example: \\\\crmoutlookshare\\client\\CRMV4.0-I386-Client-ENU.exe

To turn off the **CRM for Outlook** button complete the following steps:

1. Start the Microsoft Dynamics CRM web application.
2. Select **Settings**, then select **Administration**, then select **System Settings**.
3. Under the Outlook tab, change the **Outlook client is advertised to users in the Message Bar** to **No**.
