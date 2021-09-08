---
title: Configure a second web site with hostname in Nginx 
description: This article describes how to configure a second web site in Nginx with hostname and how to test the configuration.
ms.date: 09/03/2021
ms.prod: aspnet-core
ms.reviewer: ramakoni
---
# Part 2.7 - Configure a second web site with hostname in Nginx

_Applies to:_ &nbsp; .NET Core 2.1, .NET Core 3.1, .NET 5  

This article introduces how to configure a second web site in Nginx with hostname and how to test the configuration.

## Prerequisites

You should have following setup for this part:

- Nginx running automatically and listening for requests sent on port 80.
- Nginx configured as reverse proxy and routing all the incoming HTTP requests to the first ASP.NET Core application which is listening on port 5000. You can use any ASP.NET Core application as a backend application running on this port.
- That ASP.NET Core application should be configured to always run. If the process stops or crashes, or the server is rebooted, the ASP.NET Core application should start automatically.
- The Linux local firewall should be enabled and configured to allow SSH and HTTP inbound traffic.
- A second ASP.NET Core application configured to listen on port 5001. This ASP.NET Core application should also be configured to always run. The BuggyAmb sample ASP.NET Core application should be configured as a second as the second application of the setup.

## Goal of this part

At the moment there is one site configured in Nginx and any request that arrives on port 80 to Nginx is routed to that site. The hostname does not matter in this setup: use either IP address or any hostname that resolves to the IP address, all requests will be routed to the default web site. And that default web site acts as a reverse proxy and routes to requests to our first ASP.NET Core application listening on port 5000.

You will create a second web site in Nginx in this part of the tutorial. That web site will also act as a reverse proxy and any request with a specific hostname will be routed to the second ASP.NET Core application listening on port 5001.

You will also configure the web site to listen to a specific hostname. At the end there will be two sites accessible with these hostnames:

- First web site: `http://myfirstwebsite` will be directing traffic to the first ASP.NET Core demo application.
- Second web site: `http://buggyamb` will be directing traffic to the second ASP.NET Core sample buggy application.

Add myfirstwebsite and buggyamb in both your client Windows machine's and Linux machines' hosts file so you can use these URLs to test the new configuration.

The host names above are just for demonstration purposes, feel free to use any other host names you prefer just as long as you are consistent and use the same host names throughout the exercises in this part.

## Configure a second web site with a hostname in Nginx

If you remember, one of the directories where Nginx loads the site configurations is */etc/nginx/sites-enabled/*. There is currently one default configuration file and it looks like this:

:::image type="content" source="./media/2-7-configure-second-nginx-site-hostname/cat-command.png" alt-text="Screenshot of cat command." border="true":::

> [!NOTE]
> The highlighted parts, since you are going to have to modify these:
>
> - `server_name`: You can set the desired hostname here. At the moment this is configured to the value `_` which means any hostname.
> - `proxy_pass`: This is actual ASP.NET Core application running and listening on a given URL. Requests are routed to this URL.

First, configure the first web site to listen on host header `http://myfirstwebsite`. To achieve this, change the `server_name` in */etc/nginx/sites-enabled/default* configuration file as shown below. As a reminder, you will need to use the `sudo vi /etc/nginx/sites-enabled/default` command to edit this file:

:::image type="content" source="./media/2-7-configure-second-nginx-site-hostname/cat-default-command.png" alt-text="Screenshot of cat default command." border="true":::

Create a second Nginx configuration file for the second web site. Use the same file as a template and create a copy of this file in the same configuration directory and name it as *buggyamb.config*:

```bash
sudo cp /etc/nginx/sites-enabled/default /etc/nginx/sites-enabled/buggyamb.config
```

Then edit the configuration file with the `sudo vi /etc/nginx/sites-enabled/buggyamb.config` command. Here is the final version of */etc/nginx/sites-enabled/buggyamb.config* file:

:::image type="content" source="./media/2-7-configure-second-nginx-site-hostname/sudo-command.png" alt-text="Screenshot of sudo command." border="true":::

The resulting setup should have two configuration files in Nginx site configuration directory: *buggyamb.config* and default. You will need Nginx to reload the configuration changes but first you will want to test the new configuration to make sure that no configuration errors have been created when editing the files. Run the `sudo nginx -t` and confirm that the configuration is correct and then run the `sudo nginx -s reload` to reload the configuration and read in the new changes:

:::image type="content" source="./media/2-7-configure-second-nginx-site-hostname/sudo-nginx-command.png" alt-text="Screenshot of sudo nginx command." border="true":::

## Testing the new configuration

You will need `myfirstwebsite` and buggyamb hostnames to resolve the correct IP addresses. When accessing the sites from the Linux machine, these hostnames should resolve 127.0.0.1 and for the external clients, such as the client Windows machine, those hostnames should resolve your Linux virtual machine's public IP address, which you can retrieve from the Azure Portal.

> [!NOTE]
> The Hosts mappings are stored in the */etc/hosts* file in Linux and *C:\WINDOWS\System32\drivers\etc\hosts* file in Windows.

This is the content of the Linux hosts file:

:::image type="content" source="./media/2-7-configure-second-nginx-site-hostname/cat-host-command.png" alt-text="Screenshot of cat host command." border="true":::

You can run the `curl myfirstwebsite` and `curl buggyamb` commands to make requests to each of the two sites.

Here is the `curl myfirstwebsite` output. The response seems to be correctly displaying the HTML content from the home page of the demonstration ASP.NET core application which had been initially deployed and is listening on port 5000:

:::image type="content" source="./media/2-7-configure-second-nginx-site-hostname/curl-first-web-command.png" alt-text="Screenshot of curl first web command." border="true":::

And here is the `curl buggyamb` output. This displays the HTML content from the home page of the BuggyAmb sample application running on port 5001:

:::image type="content" source="./media/2-7-configure-second-nginx-site-hostname/curl-buggyamb-command.png" alt-text="Screenshot of curl buggyamb command." border="true":::

If you were browse the same URLs from the client machine with a browser, that should also work if we configure the hosts file correctly. This is what is displayed when browsing to `http://buggaymb` from a browser running in a Windows machine:

:::image type="content" source="./media/2-7-configure-second-nginx-site-hostname/welcome-page.png" alt-text="Screenshot of welcome page." border="true":::

Up to this point, you have this set up the following:

- Nginx hosting two web sites:

  - First web site listens for requests with the `myfirstwebsite` host header and routes the requests to our demo ASP.NET Core application which listens on port 5000.
  - Second web site listens incoming http traffic with host header values of `buggyamb` and routes the requests to the second ASP.NET Core sample buggy application which listens on port 5001.

- Both ASP.NET Core applications are running as services which restart automatically when the server is rebooted, or the applications stops or crashes.
- Linux local firewall is enabled and configured to allow SSH and HTTP traffics.

## Some Troubleshooting Tips

You may get **HTTP 502 - Bad Gateway error** when browsing a site. HTTP 502 - Bad Gateway means that the Nginx was not able to communicate with the backend ASP.NET Core application. This happens if the backend application is not running.

In this case:

- Make sure that both ASP.NET Core applications listen on different ports. One should listen on port 5000 while the other one should listen on port 5001.
- Make sure that both ASP.NET Core applications are configured to start automatically.
- Check the status of the ASP.NET Core application services using the `systemctl status` commands. If one is not running, troubleshoot it by looking at the system logs with `journalctl` command. Use `syslogIdentifier` to filter the logs.
- Makes sure that both .NET Core 3.1 and .NET Core 5.0 are installed. One site uses .NET Core 3.1, the other uses .NET Core 5.0.

## Next steps

[Part 3.1 - Get ready for troubleshooting](3-1-get-ready-troubleshooting.md)
