---
title: Run two ASP.NET Core applications at the same time
description: This article describes how to run two ASP.NET Core applications at the same time.
ms.date: 09/01/2021
ms.prod: aspnet-core
ms.reviewer: ramakoni
---
# Part 2.6 - Run two ASP.NET Core applications at the same time

_Applies to:_ &nbsp; .NET Core 2.1, .NET Core 3.1, .NET 5  

This article introduces how to make two ASP.NET Core applications running side by side, listening on different ports and processing incoming requests.

## Prerequisites

You should have following set up in order to complete this part of the tutorial:

- Both .NET Core 3.1 and .NET Core 5.0 SDKs should be installed.
- Nginx running automatically and is listening for requests sent on port 80.
- Nginx configured as reverse proxy and routing all the requests the ASP.NET Core application which is listening on port 5000.
- One ASP.NET Core application running and configured to start automatically after server is rebooted or when the process is stopped / crashed.
- Linux local firewall enabled and configured to allow SSH and HTTP traffic.
- Sample buggy ASP.NET Core application is downloaded and extracted to */var/buggyamb_v1.1* directory.

The first ASP.NET Core demo application which was used is this series is an ASP.NET Core 5.0 application and the second application is an ASP.NET Core 3.1 application. If you do not have both .NET Core 3.1 and .NET Core 5.0 SDKs installed, install the missing one before going further.

> [!NOTE]
> You can check the installed version of runtimes and SDKs by running `dotnet --info` command. .NET Core installation is already discussed in previous parts.

## Goal of this part

At the end of this part, you will have two ASP.NET Core applications running side by side, listening on different ports and processing incoming requests.

Most of the actions you will take in this part will be very similar: create a service file for the second ASP.NET Core application so it can start anytime server is rebooted or the process is crashed / stopped.

## Run second application

Running second application as a service just like first application running. Before creating service file, make sure it runs correctly.

Remember, in earlier chapters, you were instructed to copy the test debugging application to */var/buggyamb_v1.1/* directory and run the application with `dotnet /var/buggyamb_v1.1/BuggyAmb.dll` command. If you run it and you will get an error message:

:::image type="content" source="./media/2-6-run-two-aspnetcore-applications-same-time/io-error-message.png" alt-text="Screenshot of IO error message." border="true":::

The error message is clear:

> System.IO.IOException: Failed to bind to address http://127.0.0.1:5000: address already in use.

Another process is already using port 5000. This is obvious from the error message, but how can you find which process is using the port? Run `sudo netstat -tulpn | grep 5000` command. In the following screenshot, the PID is 12536 and process name is dotnet, you will most likely see that your process ID will be different:

:::image type="content" source="./media/2-6-run-two-aspnetcore-applications-same-time/sudo-netstat-command.png" alt-text="Screenshot of sudo netstat command." border="true":::

The next step is to understand which ASP.net Core application is hosted by the dotnet process that is listening on port 5000. You can run `cat /proc/12536/cmdline` command and get a result similar to the one below:

:::image type="content" source="./media/2-6-run-two-aspnetcore-applications-same-time/cat-command.png" alt-text="Screenshot of cat command." border="true":::

This is the first ASP.NET Core application that was configured in this series. It is listening on port 5000 so our new ASP.NET Core buggy application can't listen on the same port.

> [!NOTE]
> You have learnt something new here. There is a directory called */proc* and if you list the content of this directory you will see directories named for each PID running at that moment. And each subfolder will have several files and you can use those files to get properties of each process such as the command line and memory or CPU information. For now, don't focus on this because it will be discussed this later when the discussion on tools and processes takes place.

The solution or workaround isn't stopping the first application. The end goal is to have both applications running at the same time. The solution is simple, you will have to run the second ASP.NET Core application on a different port.

## Configure second ASP.NET Core application to listen on a different port

There are some different ways to achieve this:

- Use `UseUrls()` to set the port in *Program.cs*: This means the port is hard-coded in the application. Although we can read the port from a configuration file, you do not want to change the application and compile again. Therefore, this training will not focus on this solution.
- Command line arguments - Use `--urls` parameter when running our application.
- Environment variables - Set the URL to listen to using an environment variable and use `DOTNET_URLS` or `ASPNETCORE_URLS` environment variable names to achieve this.

Both environment variables and command line argument approach are options we can consider. Try and test the `--urls` option:

:::image type="content" source="./media/2-6-run-two-aspnetcore-applications-same-time/dotnet-urls-command.png" alt-text="Screenshot of dotnet urls command." border="true":::

Remember that the end goal is to run the application as service, and this entails that we will have a service file where we can set environment variables. We can set the executable command to the one above or we can set environment variables. The below examples will make use of environment variables to configure the application to listen on an alternate port.

## Create a service unit file for the second application

We will use the following service definition in our service unit file. Remember that the second application will run in the */var/buggyamb_v1.1* directory.

> [!NOTE]
> The `Environment=ASPNETCORE_URLS=http://localhost:5001` line, that will declare an environment variable called `ASPNETCORE_URLS` and tell our application to listen on port 5001:

```bash
[Unit]
Description=BuggyAmb is a really buggy application
 
[Service]
WorkingDirectory=/var/buggyamb_v1.1/
ExecStart=/usr/bin/dotnet /var/buggyamb_v1.1/BuggyAmb.dll
Restart=always
# Restart service after 10 seconds if the dotnet service crashes:
RestartSec=10
KillSignal=SIGINT
SyslogIdentifier=buggyamb-identifier
User=www-data
Environment=ASPNETCORE_ENVIRONMENT=Development
Environment=DOTNET_PRINT_TELEMETRY_MESSAGE=false
Environment=ASPNETCORE_URLS=http://localhost:5001
 
[Install]
WantedBy=multi-user.target
```

The service file name will be *buggyamb.service* and created under the */etc/systemd/system/* directory. Just like you did before, use the vi editor and run the `sudo vi /etc/systemd/system/buggyamb.service` command to create the service definition file. Copy and paste the above configuration and save it, once again notice how you set `ASPNETCORE_URLS` environment variable:

:::image type="content" source="./media/2-6-run-two-aspnetcore-applications-same-time/sudo-vi-command.png" alt-text="Screenshot of sudo vi command." border="true":::

Now you have configured the buggy ASP.NET Core web application to run as a daemon. Is this enough to meet the goal stated at the beginning of the training? Enable and start the service by running the `sudo systemctl enable buggyamb.service` and `sudo systemctl start buggyamb.service` commands. Then check its status by running `systemctl status buggyamb.service` command:

:::image type="content" source="./media/2-6-run-two-aspnetcore-applications-same-time/systemctl-status-command.png" alt-text="Screenshot of systemctl status command." border="true":::

You are at the point where you can now check if the BuggyAmb application works as expected. Run `curl localhost:5001` command and see the welcome page of BuggyAmb HTML be displayed in the console:

:::image type="content" source="./media/2-6-run-two-aspnetcore-applications-same-time/curl-localhost-command.png" alt-text="Screenshot of curl localhost command." border="true":::

The application can't be tested from the client yet because it is listening on port 5001 and this port is not allowed in firewall settings. It's not expose the port to the Internet, you can configure Nginx to listen on port 80 and route the traffic to BuggyAmb when the incoming HTTP requests are made with a certain hostname, for example: `http://buggyamb` or `http://buggyweb` - you can use any other hostname you wish.

For now, the goal of having the second ASP.NET Core application running side by side with the first demo application is met. In the next chapter, we will continue with configuring Nginx as described above.

## Next steps

[Part 2.7 - Configure a second web site with hostname in Nginx](2-7-configure-second-nginx-site-hostname.md)
