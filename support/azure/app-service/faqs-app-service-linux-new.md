---
title: FAQ - Azure App Service on Linux
description: Explore answers to frequently asked questions about built-in and custom containers in Azure App Service on Linux, including deployment, storage, and ports.
keywords: azure app service, web app, faq, linux, oss, web app for containers, multi-container, multicontainer
author: kaushika-msft
ms.author: kaushika
ms.reviewer: kaushika
manager: dcscontentpm
ms.topic: troubleshooting
ms.service: azure-app-service
ms.date: 08/18/2026
ms.custom: sap:Application Code Deployment  
---

# Frequently asked questions (FAQ) - Azure App Service on Linux 

## Summary

This article answers common questions about App Service on Linux.

## Built-in images

### What are the expected values for the Startup File section when I configure the runtime stack?

The following table lists the expected values for each stack:

| Stack | Expected value |
|-------|----------------|
| Java Platform, Standard Edition (Java SE) | The command to start your JAR app (for example, `java -jar /home/site/wwwroot/app.jar --server.port=80`) |
| Tomcat | The location of a script to perform necessary configurations (for example, `/home/site/deployments/tools/startup_script.sh`) |
| Node.js | The Process Manager 2 (PM2) configuration file or your script file |
| .NET Core | The compiled DLL name as `dotnet <myapp>.dll` |
| PHP | Optional custom startup |
| Python | Optional startup script |
| Ruby | The Ruby script that initializes your app |

These commands or scripts run after the built-in Docker container starts, but before your application code starts.

## Management

### What happens when I select the restart button in the Azure portal?

This action is the same as a Docker restart.

### Can I use Secure Shell (SSH) protocol to connect to the app container virtual machine (VM)?

Yes, you can connect through the Azure source control management (SCM) site.

> [!NOTE]
> You can also connect to the app container from your local machine by using SSH, Secure File Transfer Protocol (SFTP), or Visual Studio (VS) Code.

### How can I create a Linux App Service plan through an SDK or Azure Resource Manager (ARM) template?

Set the `reserved` field of the App Service to `true`.

## Continuous integration and deployment

### My web app still uses an old Docker container image after I updated it on Docker Hub. Do you support continuous integration and deployment (CI/CD) of custom containers?

Yes, CI/CD is supported. For more information, see [Continuous Deployment with Web App for Containers](/azure/app-service/deploy-ci-cd-custom-container).

### Do you support staging environments?

Yes.

### Can I use WebDeploy/MSDeploy?

Yes, set the `WEBSITE_WEBDEPLOY_USE_SCM` setting to `false`.

### Git deployment fails using Linux web apps. How can I work around the issue?

Use one of the following options:

- Use Azure Continuous Delivery with Azure DevOps or GitHub.
- Use the `zipdeploy` API and run the following command from your local machine:

```bash
curl -X POST -u <user> --data-binary @<zipfile> https://{your-sitename}.scm.azurewebsites.net/api/zipdeploy
```

## Language support

### I want to use web sockets in my Node.js application. Are there any special settings or configurations to set?

Yes, disable `perMessageDeflate` in your server-side Node.js code. For example, if you're using `socket.io`, use the following code:

```javascript
const io = require('socket.io')(server,{
  perMessageDeflate: false
});
```

### Do you support uncompiled .NET Core apps?

Yes.

### Do you support Composer as a dependency manager for PHP apps?

Yes. During a Git deployment, Kudu should detect that you're deploying a PHP application (due to the presence of a `composer.lock` file). Kudu then triggers a composer install.

## Custom containers

### Can I use managed identities when pulling images from Azure Container Registry?

Yes. Use Azure CLI (not Azure portal). You can use [system-assigned](https://github.com/Azure/app-service-linux-docs/blob/master/HowTo/use_system-assigned_managed_identities.md) or [user-assigned](https://github.com/Azure/app-service-linux-docs/blob/master/HowTo/use_user-assigned_managed_identities.md) identities.

### I'm using my own custom container. I want the platform to mount a Server Message Block (SMB) share to the `/home/` directory. Is this doable?

If the `WEBSITES_ENABLE_APP_SERVICE_STORAGE` setting is either unspecified or set to **false**, the `/home/` directory won't be shared across scale instances, and files written won't persist across restarts. Explicitly setting `WEBSITES_ENABLE_APP_SERVICE_STORAGE` to **true** enables the mount. Once this is set to **true**, to disable the mount, you need to explicitly set `WEBSITES_ENABLE_APP_SERVICE_STORAGE` to **false**.

### My container fails to start with a "no space left on device" message. What does this error mean?

App Service on Linux uses two different types of storage:
          
- File system storage: The file system storage is included in the App Service plan quota. It's used when files are saved to the persistent storage that's rooted in the `/home` directory. 
- Host disk space: The host disk space is used to store container images. It's managed by the platform through the Docker storage driver.

The host disk space is separate from the file system storage quota. It's not expandable and there is a 15 GB limit for each instance. It's used to store any custom images on the worker. You might be able to use larger than 15 GBs depending on the exact availability of host disk space, but this isn't guaranteed. 

If the container's writable layer saves data outside of the `/home` directory or a [mounted Azure Storage path](/azure/app-service/configure-connect-to-azure-storage?tabs=portal&pivots=container-linux), the host disk space is also consumed. The platform routinely cleans the host disk space to remove unused containers. If the container writes a large quantity of data outside of the `/home` directory or uses bring your own storage (BYOS), it results in startup failures or runtime exceptions once the host disk space limit is exceeded. Keep your container images as small as possible and write data to the persistent storage or BYOS when running on App Service for Linux. If this isn't possible, split the App Service plan because the host disk space is fixed and shared between all containers in the App Service plan.

### My custom container takes a long time to start, and the platform restarts the container before it finishes starting up. How do I fix it?

You can configure the amount of time the platform waits before restarting the container. To do so, set the `WEBSITES_CONTAINER_START_TIME_LIMIT` app setting to the value you want. The default minimum value is 230 seconds and the maximum value is 1800 seconds.

### What's the format for the private registry server URL?

Provide the full registry URL including `https://`.

### What is the format for the image name in the private registry option?

Add the full image name, including the private registry URL (for example, `myacr.azurecr.io/dotnet:latest`). Image names that use a custom port [can't be entered through the portal](https://feedback.azure.com/d365community/). To set `docker-custom-image-name`, use the [`az` command-line tool](/cli/azure/webapp/config/container#az_webapp_config_container_set).

### Can I expose more than one port on my custom container image?

This isn't supported.

### Can I bring my own storage (BYOS)?

Yes. [BYOS](/azure/app-service/configure-connect-to-azure-storage) is currently in preview.

### Why can't I browse my custom container's file system or running processes from the SCM site?

The SCM site runs in a separate container. You can't check the file system or running processes of the app container.

### Do I need to implement HTTPS in my custom container?

No. The platform handles HTTPS termination at the shared front ends.

### Do I need to use `WEBSITES_PORT` for custom containers?

Yes. This setting is required for custom containers. To manually configure a custom port, use the `EXPOSE` instruction in the Dockerfile and the app setting `WEBSITES_PORT` with a port value to bind on the container.

### Can I use `ASPNETCORE_URLS` in the Docker image?

Yes. Be sure to overwrite the environmental variable before the .NET core app starts. For example, in the `init.sh` script, use: `export ASPNETCORE_URLS={Your value}`.

## Multi-container with Docker Compose

### How do I configure Azure Container Registry to use with multi-container?

To use Azure Container Registry with multi-container, host all container images on the same Azure Container Registry registry server. When the images are on the same registry server, create application settings and update the Docker Compose configuration file to include the Azure Container Registry image name.
          
Create the following application settings:
          
- `DOCKER_REGISTRY_SERVER_USERNAME`
- `DOCKER_REGISTRY_SERVER_URL` (Use a full URL. For example: `https://<server-name>.azurecr.io`.)
- `DOCKER_REGISTRY_SERVER_PASSWORD` (Enable admin access in Azure Container Registry settings.)
          
Within the configuration file, reference your Azure Container Registry image like the following example:
          
```yaml
image: <server-name>.azurecr.io/<image-name>:<tag>
```

### How do I know which container is internet accessible?

- You can open only one container for access.
- Only ports 80 and 8080 are accessible (exposed ports).
          
Here are the rules for determining which container is accessible (in the order of precedence):
          
- Application setting `WEBSITES_WEB_CONTAINER_NAME` set to the container name.
- The first container to define port 80 or 8080.
- If neither of the preceding rules is true, the first container defined in the file is accessible (exposed).

### How do I use `depends_on`?

App Service doesn't support the `depends_on` option and ignores it. Like the [control startup and shutdown recommendation from Docker](https://docs.docker.com/compose/startup-order/), App Service multi-container apps should check dependencies through application code, both at startup and disconnection.

The following example code shows a Python app checking to see if a Redis container is running:

```python
          import time
          import redis
          from flask import Flask
          app = Flask(__name__)
          cache = redis.Redis(host='redis', port=6379)
          def get_hit_count():
              retries = 5
              while True:
                  try:
                      return cache.incr('hits')
                  except redis.exceptions.ConnectionError as exc:
                      if retries == 0:
                          raise exc
                      retries -= 1
                      time.sleep(0.5)
          @app.route('/')
          def hello():
              count = get_hit_count()
              return 'Hello from Azure App Service team! I have been seen {} times.\n'.format(count)
          if __name__ == "__main__":
              app.run(host="0.0.0.0", port=80, debug=True)
```

### Are WebSockets supported?
          
WebSockets are supported on Linux apps. The `webSocketsEnabled` ARM setting doesn't apply to Linux apps since WebSockets are always enabled for Linux.
          
> [!IMPORTANT]
> WebSockets are now supported for Linux apps on Free App Service plans. You can have up to five WebSocket connections. Exceeding this limit results in an **HTTP 429 (Too Many Requests)** error.

## Pricing and service license agreement (SLA)

### What is the pricing now that the service is generally available?

Pricing varies by SKU and region. See more details at our pricing page: [App Service Pricing](https://azure.microsoft.com/pricing/details/app-service/linux/).

## Other questions

### How does the container warmup request work?

When App Service starts your container, the warmup request sends an HTTP request to the [/robots933456.txt](/azure/app-service/configure-custom-container?pivots=container-linux#robots933456-in-logs) endpoint of your application. This endpoint is a placeholder, but your application must reply by returning any status code (including 5*xx*). If your application logic doesn't reply by sending an HTTP status code to nonexistent endpoints, the warmup request can't receive a response. Therefore, it perpetually restarts your container. 

To change this default behavior, customize the warmup endpoint path and status codes that consider the site to be warmed up. Set the [WEBSITE_WARMUP_PATH](/azure/app-service/reference-app-settings?tabs=kudu%2Cdotnet#app-environment) and [WEBSITE_WARMUP_STATUSES](/azure/app-service/reference-app-settings?tabs=kudu%2Cdotnet#app-environment) application settings.

The warmup request also might fail because of port misconfiguration.

### Is it possible to increase the container warmup request time-out?

The warmup request by default fails after waiting 240 seconds for a reply from the container. You can increase the container warmup request time-out by adding the application setting `WEBSITES_CONTAINER_START_TIME_LIMIT` with a value between 240 and 1800 seconds.

### How do I specify the port in my Linux container?

The following table describes how to specify the port in your Linux container:

| Container type | Description | How to set or use the port |
|----------------|-------------|---------------------|
| Built-in containers | If you select a language/framework version for a Linux app, a predefined container is selected for you. | To point your app code to the right port, use the `PORT` environment variable. |
| Custom containers | You have full control over the container. | App Service has no control about which port your container listens on. What it does need is to know which port to forward requests to. If your container listens to port 80 or 8080, App Service is able to automatically detect it. If it listens to any other port, you need to set the `WEBSITES_PORT` app setting to the port number, and App Service forwards requests to that port in the container. The `WEBSITES_PORT` app setting doesn't have any effect within the container, and you can't access it as an environment variable within the container. |

### Can I use a file based database (like SQLite) with my Linux web app?

The file system of your application is a mounted network share. This enables scale out scenarios where your code needs to be run across multiple hosts. However, this blocks the use of file-based database providers like SQLite since it's not possible to acquire exclusive locks on the database file. Use a managed database service like [Azure SQL](https://azure.microsoft.com/products/azure-sql/), [Azure Database for MySQL](https://azure.microsoft.com/services/mysql/), or [Azure Database for PostgreSQL](https://azure.microsoft.com/services/postgresql/).

### What are the supported characters in application settings names?

You can use only letters (A-Z, a-z), numbers (0-9), and the underscore character (_) for application settings.

### Where can I request new features?

You can submit your idea at the [Web Apps feedback forum](https://aka.ms/webapps-uservoice). Add "[Linux]" to the title of your idea.

## References
  
- [What is Azure App Service on Linux?](/azure/app-service/overview#app-service-on-linux)
- [Set up staging environments in Azure App Service](/azure/app-service/deploy-staging-slots)
- [Continuous Deployment with Web App for Containers](/azure/app-service/deploy-ci-cd-custom-container)
- [Things You Should Know: Web Apps and Linux](https://techcommunity.microsoft.com/t5/apps-on-azure/things-you-should-know-web-apps-and-linux/ba-p/392472)
- [Environment variables and app settings reference](/azure/app-service/reference-app-settings)
