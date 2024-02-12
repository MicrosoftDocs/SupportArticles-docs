---
title: Error when WCF non-HTTP activation is not enabled
description: This article provides workaround for the error that occurs when you host a .NET Framework 3.5 Windows Communication Foundation service that uses non-HTTP activation in Windows Server 2012 or Windows 8.
ms.date: 08/24/2020
ms.reviewer: ericam, mlaing
---
# Error when you host .NET Framework 3.5 WCF service on Windows Server 2012 or Windows 8

This article helps you resolve the error that occurs when you host a .NET Framework 3.5 Windows Communication Foundation (WCF) service that uses non-HTTP activation in Windows Server 2012 or Windows 8.

_Original product version:_ &nbsp; Microsoft .NET Framework Windows Communication Foundation, Windows Server 2012, Windows 8  
_Original KB number:_ &nbsp; 2803161

## Symptoms

Consider the following scenario:

- The .NET Framework 3.5 WCF service is hosted on one of the following computers:
  - A computer that is running a clean installation of Windows Server 2012 or Windows 8.
  - A computer that is running a version of Windows Server 2012 that was upgraded from Windows Server 2008 R2, or a version of Windows 8 that was upgraded from Windows 7. The WCF Non-HTTP Activation feature (such as NET.TCP) on this computer was not enabled before the computer was upgraded to Windows Server 2012 or Windows 8.
- The WCF service that is hosted on Windows Server 2012 or Windows 8 is invoked.

In this scenario, you receive the following error message:

> Exception: System.InvalidOperationException: The protocol 'net.tcp' does not have an implementation of HostedTransportConfiguration type registered.  
at System.ServiceModel.AsyncResult.End[TAsyncResult](IAsyncResult result)  
at System.ServiceModel.Activation.HostedHttpRequestAsyncResult.End(IAsyncResult result)

> [!NOTE]
> This issue does not occur if the .NET Framework 3.5 WCF service is hosted in a version of IIS that uses non-HTTP activation on a computer that is running Windows Server 2008 R2 or Windows 7.

## Workaround

To work around the issue, use one of the following methods.

### Method 1

Manually change the root of the *Web.config* file. To do this, follow these steps.

> [!WARNING]
> If you change the *Web.config* file incorrectly, ASP.NET applications may stop working. We recommend that you back up the *Web.config* file before you change it.

1. Open the following file in a text editor, such as Notepad, as an administrator:

    `%windir%\Microsoft.NET\Framework\v2.0.50727\CONFIG\web.config`

2. Add the following configuration section before the `</configuration>` tag.

    > [!NOTE]
    > The `</configuration>` tag is located at the bottom of the file.

    ```xml
    <system.serviceModel>
       <serviceHostingEnvironment>
          <add name="net.tcp" transportConfigurationType="System.ServiceModel.Activation.TcpHostedTransportConfiguration, System.ServiceModel, Version=3.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089" />
          <add name="net.pipe" transportConfigurationType="System.ServiceModel.Activation.NamedPipeHostedTransportConfiguration, System.ServiceModel, Version=3.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089" />
          <add name="net.msmq" transportConfigurationType="System.ServiceModel.Activation.MsmqHostedTransportConfiguration, System.ServiceModel, Version=3.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089" />
          <add name="msmq.formatname" transportConfigurationType="System.ServiceModel.Activation.MsmqIntegrationHostedTransportConfiguration, System.ServiceModel, Version=3.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089" />
       </serviceHostingEnvironment>
    </system.serviceModel>
    ```

3. Add the following configuration sections to the file, if they do not already exist:

    ```xml
    <protocols>
       <add name="net.tcp" processHandlerType="System.ServiceModel.WasHosting.TcpProcessProtocolHandler, System.ServiceModel.WasHosting, Version=3.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089"
          appDomainHandlerType="System.ServiceModel.WasHosting.TcpAppDomainProtocolHandler, System.ServiceModel.WasHosting, Version=3.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089"
          validate="false" />
       <add name="net.pipe" processHandlerType="System.ServiceModel.WasHosting.NamedPipeProcessProtocolHandler, System.ServiceModel.WasHosting, Version=3.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089"
          appDomainHandlerType="System.ServiceModel.WasHosting.NamedPipeAppDomainProtocolHandler, System.ServiceModel.WasHosting, Version=3.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089"
          validate="false" />
       <add name="net.msmq" processHandlerType="System.ServiceModel.WasHosting.MsmqProcessProtocolHandler, System.ServiceModel.WasHosting, Version=3.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089"
          appDomainHandlerType="System.ServiceModel.WasHosting.MsmqAppDomainProtocolHandler, System.ServiceModel.WasHosting, Version=3.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089"
          validate="false" />
       <add name="msmq.formatname" processHandlerType="System.ServiceModel.WasHosting.MsmqIntegrationProcessProtocolHandler, System.ServiceModel.WasHosting, Version=3.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089"
          appDomainHandlerType="System.ServiceModel.WasHosting.MsmqIntegrationAppDomainProtocolHandler, System.ServiceModel.WasHosting, Version=3.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089"
          validate="false" />
    </protocols>
    ```

4. Save the file.

After the file is saved, follow the same steps to change the following file, and then restart computer.

`%windir%\Microsoft.NET\Framework64\v2.0.50727\CONFIG\web.config`

> [!NOTE]
> We recommend that you apply this method to work around the issue because this method has the minimum effect on the computer. These changes apply to the Web.config file only and do not affect other ASP.NET applications.

### Method 2

Run SmconfigInstaller.exe to update the *Web.config* file.

> [!WARNING]
> This method may update more configurations in the *Web.config* and IIS application *Host.config* files than are necessary to resolve the issue. The updated configurations depend on how many ASP.NET 2.0, ASP.NET 3.0 and ASP.NET 3.5 applications are hosted and configured on the computer. If you use this method, you must be cautions if you use other ASP.NET applications that should not be changed.

- To run SMConfigInstaller.exe on a computer that is running a 32-bit operating system, follow these steps:

  1. At a command prompt, type the following command, and then press **Enter**:
  
        `%windir%\Microsoft.NET\Framework\v3.0\Windows Communication Foundation\SMConfigInstaller.exe -c:install -f:tcp -f:pipe -f:msmq -f:http`

  2. Restart the computer.

- To run SMConfigInstaller.exe on a computer that is running a 64-bit operating system, follow these steps:
  1. At a 64-bit command prompt, type the following command, and then press **Enter**:
  
        `%windir%\Microsoft.NET\Framework64\v3.0\Windows Communication Foundation\SMConfigInstaller.exe -c:install -f:tcp -f:pipe -f:msmq -f:http`

  2. At a 32-bit command prompt, type the following command, and then press **Enter**:
  
        `%windir%\Microsoft.NET\Framework\v3.0\Windows Communication Foundation\SMConfigInstaller.exe -c:install -f:tcp -f:pipe -f:msmq -f:http`  

  3. Restart the computer.
