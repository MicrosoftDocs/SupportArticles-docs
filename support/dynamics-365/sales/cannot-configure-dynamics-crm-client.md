---
title: Can't configure Dynamics CRM client
description: Discusses the issue that you can't configure the Microsoft Dynamics CRM Client for Outlook because of time zone settings.
ms.reviewer: debrau, chanson
ms.topic: troubleshooting
ms.date: 
---
# Problem communicating with the Microsoft Dynamics CRM Server error message when you configure the Dynamics CRM Client for Outlook

This article provides a solution to an issue that you can't configure the Microsoft Dynamics CRM Client for Outlook because of time zone settings.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2502671

## Symptoms

When a user tries to configure Microsoft Dynamics CRM Client for Outlook by using the Configuration Wizard, the user receives the following error message:

> There is a problem communicating with the Microsoft Dynamics CRM Server. The server might be unavailable. Try again later. If the problem persists, contact your administrator.

## Cause

This issue may occur for any of the following causes:

1. The operating system date on the client computer isn't set to the correct date.
2. The operating system time on the client computer isn't set to the correct time.
3. The operating system time zone on the client computer isn't set to the correct time zone.
4. There are multiple HTTP bindings on the Microsoft Dynamics CRM website in Internet Information Services (IIS).

## Resolution

For Causes 1, 2, and 3:

1. Exit the CRM Configuration Wizard.
2. Change the operating system date and time. To do it, use one of the following methods.

### Method 1: Manually change the operating system time  

> [!NOTE]
> The following steps are for Windows 7 or Windows Server 2008 operating systems. To change the date and time in Windows XP manually, please refer to the Windows XP Help manual.

1. Select **Start**, select **Control Panel**, select **Clock, Language, and Region**, and then select **Date and Time**.
2. In the **Date and Time** dialog box, select **Change date and time** to change the date and time settings. For example, select a date such as February 1, 2011 from the calendar, and change the time.
3. Select **OK**.
4. Select **Change time zone**, and then select your time zone.
5. Select **OK**.

### Method 2: Configure the operating system time to synchronize with an Internet time server

1. Select **Start**, select **Control Panel**, select **Clock, Language, and Region**, and then select **Date and Time**.
2. In the **Date and Time** dialog box, select the **Internet Time** tab, and then select **Change Settings**.
3. Select the **Synchronize with an Internet Time Server** check box, select a time server, select **Update Now**, and then select **OK**.

### Method 3: Use a command to sync time with the domain if the computer is a member of a domain

1. Select **Start**, select **All Programs**, select **Accessories**, right-click **Command Prompt**, and then select **Run as Administrator**.
2. At the command prompt, type the following text, and then press **Enter**:

    ```cmd
    net time [{\\ComputerName | /domain[:DomainName] | /rtsdomain[:DomainName]}] [/set]
    ```

    If you don't know the **ComputerName** or the **Domain Name**, try the following command:  

      ```cmd
      net time /set
      ```

    Then, type **Y** to finish the change:

    :::image type="content" source="./media/cannot-configure-dynamics-crm-client/screenshot-how-do-this-method.png" alt-text="A screenshot to do this step.":::

    For more information about the net time command, visit [Net Time](/previous-versions/windows/it-pro/windows-xp/bb490716(v=technet.10)).

### Method 4: Force a synchronization of the Network Time Protocol (NTP) client if the computer uses an NTP client to sync with an NTP server  

For Cause 4:

On the Microsoft Dynamics CRM 2011 web server, open IIS Manager, and limit the CRM Website to one http binding or one https binding, or both. To do it, follow these steps:

1. Select **Start**, select **Run**, and type **inetmgr** in the **Open** box.
2. Expand **Sites**, and then select the Microsoft Dynamics CRM website.
3. In the **Actions Pane**, select **Bindings**.
4. In the **Site Bindings** window, make that you only have one http binding type or only one https binding type, or both. If you have multiple http bindings or multiple https bindings, or both, the multiple bindings must be removed.

> [!NOTE]
>
> - The binding that should remain is the binding that is defined in the Deployment Manager. To check for the correct URLs, open the Deployment Manager, right-click **Microsoft Dynamics CRM**, select **Properties**, and then select the **Web Address** tab.
> - If Internet Facing Deployment (IFD) is used, the certificate that matches your IFD settings should be retained.

## More information

Outlook configuration trace (On Error) for Cause 1, 2, and 3 Exception rethrown at [0]:

  > at System.Runtime.Remoting.Proxies.RealProxy.HandleReturnMessage(IMessage reqMsg, IMessage retMsg)  
    at System.Runtime.Remoting.Proxies.RealProxy.PrivateInvoke(MessageData& msgData, Int32 type)  
    at Microsoft.Xrm.Sdk.Discovery.IDiscoveryService.Execute(DiscoveryRequest request)  
    at Microsoft.Xrm.Sdk.Client.DiscoveryServiceProxy.Execute(DiscoveryRequest request)  
    at Microsoft.Crm.Application.Outlook.Config.DeploymentsInfo.DeploymentInfo.LoadOrganizations(AuthUIMode uiMode)  
    at Microsoft.Crm.Application.Outlook.Config.DeploymentsInfo.LoadOrganizations(AuthUIMode uiMode)  
    02:45:29| Error| Error connecting to URL: <https://dev.crm5.dynamics.com/XRMServices/2011/Discovery.svc>
    >
    > Exception: System.ServiceModel.Security.MessageSecurityException: An unsecured or incorrectly secured fault was received from the other party . See the inner FaultException for the fault code and detail. ---> System.ServiceModel.FaultException: An error occurred when verifying security for the message.  
    --- End of inner exception stack trace

Microsoft CRM Server platform trace (On Error) for Cause 4 Error:

  > The service '/XRMServices/2011/Discovery.svc' cannot be activated due to an exception during compilation. The exception message is: This collection already contains an address with scheme http. There can be at most one address per scheme in this collection . If your service is being hosted in IIS you can fix the problem by setting 'system.serviceModel/serviceHostingEnvironment/multipleSiteBindingsEnabled' to true or specifying 'system.serviceModel/serviceHostingEnvironment/baseAddressPrefixFilters'.
  Parameter name: item.
