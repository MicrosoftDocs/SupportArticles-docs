---
title: Create and configure ASP.NET Core applications in Linux
description: This article describes how to create and configure ASP.NET Core applications in Linux.
ms.date: 03/18/2021
ms.reviewer: ramakoni, ahmetmb
author: ahmetmithat
---
# Part 2.1 - Create and configure ASP.NET Core applications in Linux

_Applies to:_ &nbsp; .NET Core 2.1, .NET Core 3.1, .NET 5  

This article introduces how to create and configure ASP.NET Core applications in Linux.

## Prerequisites

To follow the exercises in this part, you must have a .NET Core SDK installed. To install the SDK, refer to the installation instructions in [Part 1](1-1-creating-vm.md), as necessary.

## Goal of this part

You'll learn how to create an ASP.NET Core web application by using .NET Core command-line interface (CLI) in Linux, and how to publish the application to the */var* directory. As you learn these concepts, you'll practice some basic tasks such as working with files and folders, and running commands as a privileged user. You'll also learn how to edit files by using the vi text editor in Linux.

## .NET CLI

According to this [.NET CLI documentation](/dotnet/core/tools/), the .NET CLI is a cross-platform toolchain for developing, building, running, and publishing .NET applications. The .NET CLI is installed together with the .NET SDK.

These trainings use the `dotnet` command frequently. This command is powerful and has two main functions:

- It provides commands for working on .NET projects. For example, `dotnet build` builds a project. Each command defines its own options and arguments. All commands support the `--help` option for printing brief explanations about how to use the command.
- It runs .NET applications.

You'll use the `dotnet new` command to create your first ASP.NET Core project in Linux. This command gets the type of the project as an argument. The project types are explained in [this document](/dotnet/core/tools/dotnet-new). You can also display a list of types by running `dotnet new` without a parameter. Web-related project types are highlighted in yellow in the following screenshot.

:::image type="content" source="./media/2-1-create-configure-aspnet-core-applications/dotnet-new-command.png" alt-text="Screenshot of dotnet new command." border="true":::

## Create a .NET Core web application using SDK

You'll use the .NET CLI to create your first web application by using the following command:

```dotnetcli
dotnet new <template_type> -n <project_name> -o <output_directory>
```

These rules apply when you use `dotnet new`:

- The command creates the project files in the output directory. If you omit the `-o <output_directory>` segment, then the project will be created in the current directory. You can always use the `-o` switch.
- If the folder doesn't exist, the command creates it.
- If you omit the `-n <project_name>` segment, then the project name will be the same as the directory name.

You're welcome to find creative names for the directory and project itself. However, keep in mind that Linux is case-sensitive. For this exercise, use the more conservative `AspNetCoreDemo` as the project name, and create it in the `firstwebapp` directory.

To create the project, run the following command:

```dotnetcli
dotnet new webapp -n AspNetCoreDemo -o firstwebapp 
```

Examine the output to see the directory and project names. The following screenshot also lists the content of the output directory. You should be familiar with the directory structure if you have created an ASP.NET Core web application on Windows before.

:::image type="content" source="./media/2-1-create-configure-aspnet-core-applications/dotnet-new-first-webapp.png" alt-text="Screenshot of dotnet new command for first webapp." border="true":::

You have created your first application. The next task will be to run it. Change the directory to the project folder, and run `dotnet run`.

:::image type="content" source="./media/2-1-create-configure-aspnet-core-applications/dotnet-run-command.png" alt-text="Screenshot of dotnet run command." border="true":::

> [!NOTE]
> The following items in this screenshot:
>
> - Your web application listens on port 5001 for HTTPS requests and listens on port 5000 for HTTP requests.
> - The content root is under the home directory.

We recommend that you don't have the application run under your home directory. You'll publish it to another directory later, but you should test it before you publish it. You can press **Ctrl+C** to stop the application. But for now, keep it running, and open a new terminal session by using your preferred method to connect to your Linux virtual machine. For this example, you'll use PowerShell again.

## Test the web site from another terminal

In your new terminal session, verify that your application is listening on ports 5000 and 5001. Linux has the same `netstat` command that Windows has. Run `netstat` together with the `-tlp` switch. You can get familiar with the `netstat` switches in [this article](https://www.binarytides.com/linux-netstat-command-examples/), or you can look at the help file by running `man netstat` or `info netstat`.

Here's the output of the `netstat -tlp` command from the second terminal session. It shows that the AspNetCoreDemo process is running by using PID 781, and is listening on ports 5000 and 5001 for both IPv4 and IPv6.

:::image type="content" source="./media/2-1-create-configure-aspnet-core-applications/info-netstat-command.png" alt-text="Screenshot of info netstat command." border="true":::

You can use [curl](https://curl.se/docs/manpage.html) and [wget](https://www.computerhope.com/unix/wget.htm) to test your website. Both commands make an HTTP call to the target side, but they behave differently:

- `Curl` is simply a command line browser tool. It makes an HTTP request to the given target, and it shows only the plain output of the HTTP response. For example, it shows the HTML source markup for a web application.
- `Wget` is an HTTP downloader. It makes an HTTP request, and it downloads the given resource. For example, wget `http://server/file.zip` downloads *file.zip* from `http://server` and save it to the current directory.

The `wget` command also shows us some more details, such as redirection and any error messages you might receive. Therefore, you can use it as a primitive version of an HTTP trace tool whenever you need that.

For more information about the difference between `curl` and `wget`, go to [StackExchange webpage](https://unix.stackexchange.com/questions/47434/what-is-the-difference-between-curl-and-wget).

In this training series, you previously used `wget` to download the *.deb* package manager file from Microsoft servers before you installed .NET Core.

If you run `curl http://localhost`, nothing occurs. This most likely means that there is no HTTP response. You can then run `wget http://localhost` to check whether more information is displayed when you try to access the site.

:::image type="content" source="./media/2-1-create-configure-aspnet-core-applications/curl-localhost-command.png" alt-text="Screenshot of curl localhost command." border="true":::

This is what occurs now:

- You make an HTTP request to `http://localhost:5000`, and you connect successfully. This means that the application is accepting the connections on port 5000.
- You receive an HTTP 307 Temporary Redirect response from the application that points to a secure HTTPS location: `https://locahost:5001`.
- Wget is smart enough to follow this redirect and make a new request to `https://localhost:5001`.
- You connect successfully again. However, `wget` doesn't trust the SSL certificate. Therefore, the connection fails.

The `wget` command recommends that you work around this issue by using the `--no-check-certificate` switch to connect insecurely. However,  this approach involves SSL certificate settings that are **out-of-scope** for this training. Instead, you can configure your ASP.NET Core application so that it won't redirect the HTTP requests to HTTPS. If you're familiar with ASP.NET Core application development (or just configuration), you may already know how to do this: Edit the *Startup.cs* file to remove the redirection configuration.

## Edit files by using vi

You can use the [vi](https://www.guru99.com/the-vi-editor.html) text editor for Linux distros to edit all kinds of plain text files. You'll use it in this training to reconfigure your application.

You must close your application before you can edit it. First close the open terminal session. Then, press **Ctrl+C** to shut down the application.

To edit *Startup.cs* file, run the following command:

```bash
vi ~/firstwebapp/Startup.cs
```

> [!NOTE]
> This command starts the vi editor, and then loads the file. The ~ (tilde) shortcut refers to your home directory where you created your project. That is, the command points to */home/\<YourName\>/firstwebapp/Startup.cs*.

Press the **I** (Insert) key to enable edit mode. You should now see -- **INSERT** -- at the bottom of the command line. Use the arrow keys to navigate within the file. Comment both the `app.UseHsTs()`; and `app.UseHttpsRedirection()`; lines by adding `//` at the start of them, as shown in the following screenshot.

:::image type="content" source="./media/2-1-create-configure-aspnet-core-applications/comment-code.png" alt-text="Screenshot of comment in code." border="true":::

Press **esc** to exit editing mode, enter [:wq!](https://www.cyberciti.biz/faq/save-file-in-vi-vim-linux-apple-macos-unix-bsd/), and then press **Enter**. Notice that the colon character (`:`) means that you're entering a command, `w` means write, `q` means quit, and `!` forces writing.

:::image type="content" source="./media/2-1-create-configure-aspnet-core-applications/wq-text-code.png" alt-text="Screenshot of wq text in code." border="true":::

After you press Enter, the changes should be saved. You can verify the changes by running `cat ~/firstwebapp/Startup.cs`. This command displays the contents of the *Startup.cs* file.

Restart your application. To do this, change the current directory to the `~/firstwebapp` directory, and run dotnet run again. Then, open another terminal session to your server, and run the `curl http://localhost:5000` command again. This time, the command should return the HTML contents of the home page.

:::image type="content" source="./media/2-1-create-configure-aspnet-core-applications/curl-localhost-5000-command.png" alt-text="Screenshot of curl localhost at 5000 port command." border="true":::

You have now successfully run your first ASP.NET Core Web App on Linux.

## Deploy the application to the /var directory

The primary goal of this exercise is to host your web application behind a reverse proxy so that connecting clients can access the application from another computer by using only the hostname without the port number. This is what you'd expect to occur in real world scenarios. You'll work with Nginx later to complete this task.  But before you do that, publish your application to the */var* directory. This is because we recommend that you don't run the application in a user's home directory.

Remember that the */var* directory is used to store content and log files by various applications such as Apache and Nginx. You'll follow that practice here by publishing the newly created web application to */var*.

Change to the project folder, and then run `dotnet publish` to create a publishing folder. Copy that folder to the /var directory.

:::image type="content" source="./media/2-1-create-configure-aspnet-core-applications/dotnet-publish.png" alt-text="Screenshot of dotnet publish command." border="true":::

The screenshot shows that the `dotnet publish` command created publishing files in the *~/firstwebapp/bin/Debug/net5.0/publish/* folder. Then, the following command was used to copy all files to */var/firstwebapp/* folder:

```bash
sudo cp -a ~/firstwebapp/bin/Debug/net5.0/publish/ /var/firstwebapp/
```

> [!NOTE]
> Note the usage of `sudo` before the copy command. You use this because standard users don't have write permission to */var* directory. Therefore, you must run the command as a superuser.

To run your application from a published folder, run the following command:

```dotnetcli
dotnet /var/firstwebapp/AspNetCoreDemo.dll
```

If you want, you can run these tests by using the same `curl` and `wget` commands. This is because the application will still listen on port 5000 for HTTP requests.

## Lifetime of the process and next steps

If the application requires constant uptime, running .NET Core application within an interactive user session isn't a good practice because of the following reasons:

- If users were to terminate their sessions, for example by closing PuTTY or the PowerShell SSH client, or exit the session, the application would shut down.
- If the process is terminated for some reason (for example, the process crashes because of an unhandled exception), it won't start automatically and must be restarted manually.
- If the server is restarted, the application won't start automatically.

## Next steps

[Part 2.2 - Install Nginx and configuring it as a reverse proxy server](2-2-install-nginx-configure-it-reverse-proxy.md)

Make sure that the web application starts automatically. Install and configure Nginx as a reverse proxy to route HTTP requests that are made to port 80 to the dotnet application instead (so that clients can connect without having to provide the port number).

[!INCLUDE [Third-party disclaimer](../../../../includes/third-party-disclaimer.md)]
