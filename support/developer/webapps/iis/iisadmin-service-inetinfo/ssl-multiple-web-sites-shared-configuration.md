---
title: Set up SSL on multiple web sites
description: This article talks about setting multiple site bindings and SSL in shared configuration in IIS 7.0 and IIS 7.5.
ms.date: 04/16/2020
ms.custom: sap:IISAdmin service and Inetinfo process operation
ms.topic: how-to
ms.subservice: iisadmin-service-inetinfo
---
# Set up SSL on multiple web sites in IIS with shared configuration

This article describes that how to set up Secure Sockets Layer (SSL) on multiple web sites in Microsoft Internet Information Services (IIS) with shared configuration.

_Original product version:_ &nbsp; Internet Information Services 7.0, 7.5  
_Original KB number:_ &nbsp; 2548832

## Summary

Assume that you want to set up shared configuration for two IIS servers. For the purpose of this example, they are named *Server A* and *Server B*. You are going to have two different web sites, here named *Site1* and *Site2*. Both of these websites are going to use their own dedicated IP addresses as shown below:

*Server A* --> Site1 --> 10.10.10.1  
*Server A* --> Site2 --> 10.10.10.2

*Server B* --> Site1 --> 10.10.10.3  
*Server B* --> Site2 --> 10.10.10.4  

Now, you configure *Server A* & *B* for shared configuration, however you run into a unique situation when it comes to the web site bindings. Web site bindings configuration typically looks like the example below in an *applicationHost.config* file:

```xml
<site name="Site1" id="1">
    <application path="/" applicationPool="Site1">  
        <virtualDirectory path="/" physicalPath="C:\inetpub\wwwroot" />
    </application>
    <bindings>  
        <binding protocol="http" bindingInformation="10.10.10.1:www.contoso.com" />
        <binding protocol="https" bindingInformation="10.10.10.1:443:" />
    </bindings>
</site>
```

As you can see there's nothing that identifies the web server by its name (for example *Server A*). So when you bind *Site1* to 10.10.10.1 on *server A*, these settings are also replicated for *Server B*. But *Server B*"s NIC card doesn't recognize the 10.10.10.1 IP address. You in fact want to bind 10.10.10.3 to the *Site1* on port 443 and 80 for *Server B*.

To overcome this situation, you need to manually add extra bindings for each website. For example, you'll need to add additional bindings for IP 10.10.10.3 and port 443 on *Server A*, even though *Server A* doesn't understand 10.10.10.3. This is fine, since IIS on *Server A* will ignore that IP when starting up, as it can't find it. You can use the following appcmd.exe command to add this binding:

```console
appcmd.exe set site /site.name:Site1 /+bindings.[protocol="https",bindingInformation="10.10.10.3:443:"]
```

> [!NOTE]
> The IIS Manager user interface will not let you do this for https; you must use the appcmd.exe tool.

Once you add this binding using appcmd.exe, your new configuration in the *applicationHost.config* file will look like the following:

```xml
<site name="Site1" id="1">  
    <application path="/" applicationPool="Site1">
        <virtualDirectory path="/" physicalPath="C:\inetpub\wwwroot" />
    </application>  
    <bindings>
        <binding protocol="http" bindingInformation="10.10.10.1:www.contoso.com" />
        <binding protocol="https" bindingInformation="10.10.10.1:443:" />
        <binding protocol="https" bindingInformation="10.10.10.3:443:" />
    </bindings>
</site>
```

Remember, you haven't yet assigned an actual certificate to this site. You have just added the IP bindings for port 443. You can now assign an existing certificate using the IIS manager UI. For more information about how to do, see [How to Set Up SSL on IIS 7](/iis/manage/configuring-security/how-to-set-up-ssl-on-iis).

Once you have assigned a certificate, the entries will be configured in http.sys and you'll be able to view them using the following NETSH command from a command prompt:

```console
netsh http show sslcert  
```

Similarly, follow the above steps and logic to add the rest of your sites and certificates to the remaining server(s). SSL certificate information is never stored in the *applicationHost.config* file. It is local to the machine and it is the responsibility of the *Server A* administrator to make sure to export and import the correct certificates on all of the servers in the farm that are using shared configuration.

## More information

You can learn more about managing shared configuration in [Shared Configuration](/iis/manage/managing-your-configuration-settings/shared-configuration_264).
