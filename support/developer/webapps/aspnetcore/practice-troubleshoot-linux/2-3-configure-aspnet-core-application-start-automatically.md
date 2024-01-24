---
title: Configure the ASP.NET Core application to start automatically
description: This article describes how to configure the ASP.NET Core application to ensure that the application starts automatically after the server restart.
ms.date: 03/18/2021
ms.service: aspnet-core
ms.reviewer: ramakoni, ahmetmb
ms.subservice: practice-troubleshoot-linux
author: ahmetmithat
---
# Part 2.3 - Configure the ASP.NET Core application to start automatically

_Applies to:_ &nbsp; .NET Core 2.1, .NET Core 3.1, .NET 5  

This article introduces how to configure the ASP.NET Core application to ensure that the application starts automatically after the server restarts.

## Prerequisites

To follow the exercises in this part, you must have an ASP.NET Core web application installed and deployed in Linux.

You also have to configure the Nginx web server as a reverse proxy to route the requests to the back-end ASP.NET Core application from port 80.

## Goal of this part

The previous parts in this series showed how to configure Nginx as a reverse proxy and how to troubleshoot an HTTP 502 proxy error. The cause of the HTTP 502 response code is that the back-end ASP.NET Core application wasn't running when Nginx tried to forward traffic to it.

The issue was resolved temporarily by running your ASP.NET Core application manually. But what if the application crashes? Or the server has to be restarted? Manually restarting the ASP.NET Core application every time isn't a practical solution. Therefore, in this section, you'll configure Linux to start your application after it crashes.

So far, you have configured Nginx and ASP.NET Core to work together. Nginx listens on port 80 and routes requests to the ASP.NET Core application that listens on port 5000. Although Nginx starts automatically, the ASP.NET Core application must be started manually every time that the server is restarted. Otherwise, the ASP.NET Core application exits gracefully or crashes.

If you run the ASP.NET Core by having IIS as a proxy, the IIS ASP.NET Core Module (ANCM) handles the process management, and the ASP.NET Core process starts automatically. Another option is to run the ASP.NET Core as a service in Windows so that the auto-start feature can be configured as soon as the computer starts.

## Create service file for your ASP.NET Core application

Recall that the `systemctl` command is used to manage the "services", or "daemons". A daemon is a similar concept to that of a Windows service. Such a service can be restarted automatically when the system starts.

### What is a service file?

In Linux, there are also unit configuration files that have a ".service" extension that is used to control the behavior of daemons when the process exits. These are also known as *service files*, *unit files*, and *service unit files*.

These service files are located in one of the following directories:

- */usr/lib/systemd/*: Stores service files for downloaded applications
- */etc/systemd/system/*: Stores service files that are created by system administrators

Inspect the Nginx service file. It's installed through a package manager. Its configuration file should be in the */usr/lib/systemd/system/* folder. Running the `systemctl status nginx` command also displays the location of the service file.

:::image type="content" source="./media/2-3-configure-aspnet-core-application-start-automatically/systemctl-status-nginx-command.png" alt-text="Screenshot of systemctl status nginx command." border="true":::

This is what the Nginx service file looks like.

:::image type="content" source="./media/2-3-configure-aspnet-core-application-start-automatically/cat-command.png" alt-text="Screenshot of cat command." border="true":::

### Sample service file for ASP.NET Core applications

The following example unit file content is taken from [Host ASP.NET Core on Linux with Nginx](/aspnet/core/host-and-deploy/linux-nginx):

```ini
[Unit]
Description=Example .NET Web API App running on Ubuntu

[Service]
WorkingDirectory=/var/www/helloapp
ExecStart=/usr/bin/dotnet /var/www/helloapp/helloapp.dll
Restart=always
# Restart service after 10 seconds if the dotnet service crashes:
RestartSec=10
KillSignal=SIGINT
SyslogIdentifier=dotnet-example
User=www-data
Environment=ASPNETCORE_ENVIRONMENT=Production
Environment=DOTNET_PRINT_TELEMETRY_MESSAGE=false

[Install]
WantedBy=multi-user.target
```

Here are some key aspects of this content:

- `WorkingDirectory` is the directory where you publish your application.
- `ExecStart` is the actual command that starts the application.
- `Restart=always` is self-explanatory. This process is always started if it stops for some reason, whether manually or because of a crash.
- `RestartSec=10` is also self-explanatory. After the process is stopped, it will be started after 10 seconds have elapsed.
- `SyslogIdentifier` is important. It means "system log identifier". Information about the daemon is logged under this name in the system logs. You can also use this identifier to find the PID of your process.
- `User` is the user that manages the service. It should exist in the system and have appropriate ownership of the application files.
- You can set any number of environment variables in the service file.

> [!NOTE]
> The `www-data` user is a special user in the system. You can make use of this account. You'll create a new user for practicing user permissions in Linux. However, it's fine to use `www-data` if you don't want to create another Linux user.

### Create a service file for the ASP.NET Core application

You'll use `vi` to create and edit the service file. Your service file will go into the */etc/systemd/system/* folder. Remember that, in this series, you published your first application to the */var/firstwebapp/* folder. Therefore, *WorkingDirectory* should point to this folder.

Here's the final configuration file:

```ini
[Unit]
Description=My very first ASP.NET Core applications running on Ubuntu

[Service]
WorkingDirectory=/var/firstwebapp/
ExecStart=/usr/bin/dotnet /var/firstwebapp/AspNetCoreDemo.dll
Restart=always
# Restart service after 10 seconds if the dotnet service crashes:
RestartSec=10
KillSignal=SIGINT
SyslogIdentifier=myfirstapp-identifier
User=www-data
Environment=ASPNETCORE_ENVIRONMENT=Development
Environment=DOTNET_PRINT_TELEMETRY_MESSAGE=false

[Install]
WantedBy=multi-user.target
```

Run sudo `vi /etc/systemd/system/myfirstwebapp.service` , paste the final configuration, and save the file.

:::image type="content" source="./media/2-3-configure-aspnet-core-application-start-automatically/sudo-command.png" alt-text="Screenshot of sudo command." border="true":::

This completes the required configuration for the ASP.NET Core web application to run as a daemon.

Because the web application is now configured as a service, you can check its status by running `systemctl status myfirstwebapp.service`. As you can see in the following screenshot, the application is disabled (won't start automatically after a system restart), and it's not currently running.

:::image type="content" source="./media/2-3-configure-aspnet-core-application-start-automatically/systemctl-status-command.png" alt-text="Screenshot of systemctl status command." border="true":::

To start the service, run the `sudo systemctl start myfirstwebapp.service` command, and then check the status again. This time, you should see the service running, and a process ID should be listed next to it. The command output also shows the final few lines from system logs for the newly created service, and it shows that the service is listening on `http://localhost:5000`.

:::image type="content" source="./media/2-3-configure-aspnet-core-application-start-automatically/sudo-systemctl-start-command.png" alt-text="Screenshot of sudo systemctl start command." border="true":::

Should the web application stop unexpectedly, it will automatically start again after 10 seconds.

There is one final step: The service is running but not enabled. "Enabled" means that it starts automatically after the server is started. This is the desired final configuration. Run the following command to make sure that the service is enabled:

```bash
sudo systemctl enable myfirstwebapp.service
```

:::image type="content" source="./media/2-3-configure-aspnet-core-application-start-automatically/sudo-systemctl-enable-command.png" alt-text="Screenshot of sudo systemctl enable command." border="true":::

This is a milestone for your ASP.NET Core application because you have configured it to start automatically after a server restart or a process termination.

## Test whether ASP.NET Core application restarts automatically

Before you advance to the next part, make sure that everything is working as expected. The current configuration is as follows

- Nginx runs automatically, and it listens to requests sent on port 80.
- Nginx is configured as a reverse proxy, and it routes requests to the ASP.NET Core application. The application is listening on port 5000.
- The ASP.NET Core application is configured to start automatically after the server restarts or if the process stops or crashes.

Therefore, whenever the ASP.NET Core service stops, it should restart in 10 seconds. To test this behavior, you'll force the process to stop. You can expect it to start again in 10 seconds.

> [!NOTE]
> The current process ID of the ASP.NET Core application. The process ID for the attempt that's shown here was **5084** before the process was killed. To find the process ID for your ASP.net Core application, run the `systemctl status myfirstwebapp.service` command.

To force the process to stop, run the following command:

```bash
sudo kill -9 <PID>
```

> [!NOTE]
> `9` here is the signal type. According to the `man` signal command, `9` is SIGKILL (kill signal). You can open the Help pages by using the `man` command for "kill and signal" to learn more about this topic.

Run the `systemctl status myfirstwebapp.service` command immediately after the `kill` command, wait for about 10 seconds, and then run the same command again.

:::image type="content" source="./media/2-3-configure-aspnet-core-application-start-automatically/kill-command.png" alt-text="Screenshot of kill command." border="true":::

In this screenshot, you can see the following information:

- Before it was killed, the ASP.NET Core process had a process ID of 5084.
- The service status indicated that the process that uses PID 5084 was killed, and it is activating again because auto-restart is configured.
- A few seconds later, a new process (PID 5181) was started.

If you try to access the site by using `curl localhost`, you should see that the ASP.NET Core application is still responding.

## Next steps

[Part 2.3.1 - [Optional] Configure the ASP.NET Core application in Linux to start automatically under a different user](2-3-1-configure-aspnet-core-application-start-automatically.md).
