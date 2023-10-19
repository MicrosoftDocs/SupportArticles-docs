---
title: Proxy server requires authentication or it is blocking access to cloud services error
description: Provides a resolution for the proxy-related errors that occur in Power Automate for desktop.
ms.reviewer: pefelesk
ms.date: 10/19/2023
ms.subservice: power-automate-desktop-flows
---
# Proxy server related errors in Power Automate for desktop

This article helps resolve the proxy-related errors that occur in Microsoft Power Automate for desktop.

_Applies to:_ &nbsp; Power Automate

## Symptoms

You receive one of the following errors in the Power Automate for desktop console:

- > The proxy server in your network requires authentication.

- > The communication with the cloud services requires network proxy authentication.

- > During startup Power Automate couldn't sign you in. The proxy server in your network requires authentication.

- > The proxy server in your network is blocking access to Microsoft cloud services.

## Cause

Power Automate for desktop can't authenticate with the proxy server used by the machine.

## Resolution

> [!NOTE]
> The following configurations require administrator rights.

To solve this issue, follow these steps:

1. [Configure the proxy address and port](/power-automate/desktop-flows/governance#configure-power-automate-for-desktop-to-interact-with-a-corporate-proxy-server) that Power Automate for desktop uses to interact with the proxy server.

2. Use one of the following options:

   - Option 1: [Configure Power Automate for desktop to authenticate to a corporate proxy server using the current user's credentials](/power-automate/desktop-flows/governance#configure-power-automate-for-desktop-to-authenticate-to-a-corporate-proxy-server-using-the-current-users-credentials).
   - Option 2: [Configure Power Automate for desktop to interact with a corporate proxy server using Windows credentials](/power-automate/desktop-flows/governance#configure-power-automate-for-desktop-to-authenticate-to-a-corporate-proxy-server-using-windows-credentials).

   Alternatively, you can [configure Power Automate for desktop to bypass a corporate proxy server](/power-automate/desktop-flows/governance#configure-power-automate-for-desktop-to-bypass-a-corporate-proxy-server).

## Workaround

> [!NOTE]
> If the steps described in the [Rsolution](#resolution) section don't solve the issue, try the following workaround. However, this method isn't recommended since the configuration files are updated after a product update and the following process will need to be repeated.

1. Close all instances of Power Automate for desktop.
   
   - Ensure that the icon doesn't exist in the system tray.
   - Ensure that no processes are running in the background using Windows Task Manager.

2. Navigate to the installation folder (_C:\Program Files (x86)\Power Automate Desktop_) and back up the following configuration files. If something goes wrong, you can recover them:

   - *PAD.Designer.exe.config*
   - *PAD.Console.Host.exe.config*
   - *PAD.Robot.exe.config*
   - *UIFlowService.exe.config*

3. For all files, edit each file with administrator rights, and add the following child XML node at the end of the root XML node (`<configuration>`).

    ```xml
    <system.net> 
      <defaultProxy enabled="true" useDefaultCredentials="true" />
    </system.net>
    ```

    For example:

    ```xml
    <configuration>
      <userSettings>
        <PAD.Console.Host.Properties.Settings>
          <setting name="DataCollectionActiveFileRetryInterval" serializeAs="String">
            <value>00:05:00</value>
          </setting>
          <setting name="DataCollectionBatchSize" serializeAs="String">
            <value>50</value>
          </setting>
        </PAD.Console.Host.Properties.Settings>
      </userSettings>
      <!-- Beginning of proxy authentication -->
      <system.net>
        <defaultProxy enabled="true" useDefaultCredentials="true" />
      </system.net>
      <!-- End of proxy authentication -->
    </configuration>
    ```

4. Save the changes.
5. Restart Power Automate for desktop.
6. Restart the Power Automate service:
     1. In Windows, open the **Services** desktop app. Press <kbd>Windows</kbd>+<kbd>R</kbd> to open the **Run** box, enter *services.msc*, and then press <kbd>Enter</kbd> or select **OK**.
     2. Look for **Power Automate service**.
     3. Right-click the service and select **Restart**.
