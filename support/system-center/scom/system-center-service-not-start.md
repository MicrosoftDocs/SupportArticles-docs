---
title: A service doesn't start after applying update 2677070
description: Describes a problem in which the System Center Data Access service or the System Center Management Configuration service doesn't start with a time-out error.
ms.date: 04/15/2024
ms.reviewer: cwallen, adoyle
---
# A System Center service may not start after applying the update 2677070

This article fixes an issue in which the System Center Data Access service or the System Center Management Configuration service doesn't start after you apply update 2677070.

_Original product version:_ &nbsp; Microsoft System Center 2012 Operations Manager, System Center 2012 Service Manager, Microsoft System Center Service Manager 2010  
_Original KB number:_ &nbsp; 2730040

## Symptoms

After applying the [update 2677070](https://support.microsoft.com/help/2677070), the System Center Data Access service or the System Center Management Configuration service may fail to start with a time-out error.

Also, after opening the Service Manager console, the following error may be displayed:

> Reporting Data Warehouse management Server is currently unavailable. You will be unable to view reports or administer the Data Warehouse until this server is available. Please contact your system administrator. After the server becomes available please close your console and re-open to connect.

## Cause

This issue occurs because the system cannot retrieve trusted and untrusted certificate trust lists (CTLs). If the system doesn't have access to Windows Update, either because the system isn't connected to the Internet or because Windows Update is blocked by firewall rules, the network retrieval times out before the service can continue its startup procedure. In some cases, this network retrieval time-out may exceed the service startup time-out of 30 seconds. If a service cannot report that startup completed after 30 seconds, the service control manager stops the service.

The URLs to update the CTL changed with this update. Therefore, if previous URLs were hard-coded as exceptions in the firewall or proxy, or if there is no Internet access on the computer, the CTL cannot be updated.

## Workaround 1

Validate that boundary firewalls, router access rules, or downstream proxy servers enable systems that have update 2677070 installed to contact Microsoft Update. For more information about this requirement, see [An automatic updater of revoked certificates is available for Windows Vista, Windows Server 2008, Windows 7, and Windows Server 2008 R2](https://support.microsoft.com/help/2677070). (This includes the URLs that the CTL update accesses.)

## Workaround 2

Change the Group Policy settings. To do this, follow these steps:

1. Under the **Computer Configuration** node in the Local Group Policy Editor, double-click **Policies**.
2. Double-click **Windows Settings**, double-click **Security Settings**, and then double-click **Public Key Policies**.
3. In the details pane, double-click **Certificate Path Validation Settings**.
4. Select the **Network Retrieval** tab, select the **Define these policy settings** check box, and then clear the **Automatically update certificates in the Microsoft Root Certificate Program (recommended)** check box.
5. Select **OK**, and then close the Local Group Policy Editor.

## Workaround 3

Modify the registry. To do this, follow these steps.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

1. Click **Start**, Click **Run**, type `regedit` in the **Open** box, and then click **OK**.
2. Locate and then select the following registry subkey:

   `HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\SystemCertificates`

3. Right-click `AuthRoot`, select **New**, and then select **DWORD**.
4. Type `DisableRootAutoUpdate`, and then press Enter.
5. Right-click `DisableRootAutoUpdate`, and then select **Modify**.
6. In the **Value data** box, type **1**, and then click **OK**.
7. On the **File** menu, click **Exit**.

## Workaround 4

Increase the default service time-out.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

1. Click **Start**, click **Run**, type `regedit` in the **Open** box, and then click **OK**.
2. Locate and then select the following registry subkey:

   `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control`

3. Right-click **Control**, point to **New**, and then select **DWORD**.
4. In the **New Value** box, type `ServicesPipeTimeout`, and then press Enter.
5. Right-click `ServicesPipeTimeout`, and then select **Modify**.
6. Click **Decimal**, type the number of milliseconds that you want to wait until the service times out, and then click **OK**.

   For example, to wait 60 seconds before the service times out, type **60000**.

7. On the **File** menu, click **Exit**, and then restart the computer.

## Workaround 5

Unblock the updated URLs in the firewall or proxy, or disable CRL checking for the Data Access service and the Management Configuration service.

To download the latest CTLs, use the following updated URLs:

- [http://ctldl.windowsupdate.com/msdownload/update/v3/static/trustedr/en/disallowedcertstl.cab](http://ctldl.windowsupdate.com/msdownload/update/v3/static/trustedr/en/disallowedcertstl.cab)

- [http://ctldl.windowsupdate.com/msdownload/update/v3/static/trustedr/en/authrootstl.cab](http://ctldl.windowsupdate.com/msdownload/update/v3/static/trustedr/en/authrootstl.cab)

Open one of the following files in a text editor:

- For the Data Access service: **Microsoft.Mom.Sdk.ServiceHost.exe.config**
- For the Management Configuration service: **Microsoft.Mom.ConfigServiceHost.exe.config** (in Service Manager) or **cshost.exe.config** (in Operations Manager)

To disable CRL checking, add the following line in the \<runtime> section:

`<generatePublisherEvidence enabled="false"/>`

The following example shows this tag being added for System Center 2012 Operations Manager in the Cshost.exe.config file.

```xml
<runtime>
<generatePublisherEvidence enabled="false"/>  
<assemblyBinding xmlns="urn:schemas-microsoft-com:asm.v1">
<dependentAssembly>
<assemblyIdentity name="Microsoft.EnterpriseManagement.HealthService" publicKeyToken="31bf3856ad364e35" />
<publisherPolicy apply="no" />
<bindingRedirect oldVersion="6.0.4900.0" newVersion="7.0.5000.0" />
</dependentAssembly>
<publisherPolicy apply="no" />
<probing privatePath="" />
</assemblyBinding>
<assemblyBinding xmlns="urn:schemas-microsoft-com:asm.v1">
<dependentAssembly>
<assemblyIdentity name="Microsoft.Mom.Common" publicKeyToken="31bf3856ad364e35" />
<publisherPolicy apply="no" />
<bindingRedirect oldVersion="6.0.4900.0" newVersion="7.0.5000.0" />
</dependentAssembly>
<publisherPolicy apply="no" />
<probing privatePath="" />
</assemblyBinding>
<gcServer enabled="true"/>
</runtime>
```

The following example shows the same added tag in the configuration file for System Center Operations Manager 2007 R2 (Microsoft.Mom.Sdk.ServiceHost.exe.config):

```xml
<?xml version="1.0" encoding="utf-8"?>
<configuration>
<runtime>
<generatePublisherEvidence enabled="false"/>  
<gcServer enabled="true"/>
</runtime>
```

The two \*.config files can be found in the following directories:

- System Center Service Manager 2010: `%ProgramFiles%\System Center Service Manager 2010`
- SystemCenter 2012 Operations Manager: `%ProgramFiles%\System Center 2012\Operations Manager\Server`
- System Center 2012 Service Manager: `%ProgramFiles%\System Center 2012\Service Manager`
