---
title: Object doesn't match target type
description: Provides a workaround for an issue that triggers an error when you use the Exchange Management Console in Exchange Server 2010 to view the properties of an Exchange Online mailbox.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: rayfong, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# Object doesn't match target type when using the Exchange 2010 Management Console to view Exchange Online mailbox properties

_Original KB number:_ &nbsp; 3142004

## Problem

When you try to use the Exchange Management Console in an on-premises Exchange Server 2010 installation to view the properties of an Exchange Online mailbox, you receive an error message that resembles the following:

> Object does not match target type.  
> Additional information:
>
> at System.Reflection.RuntimeMethodInfo.CheckConsistency(Object target)  
> at System.Reflection.RuntimeMethodInfo.Invoke(Object obj, BindingFlags invokeAttr, Binder binder, Object[] parameters, CultureInfo culture, Boolean skipVisibilityChecks)  
> at System.Reflection.RuntimeMethodInfo.Invoke(Object obj, BindingFlags invokeAttr, Binder binder, Object[] parameters, CultureInfo culture)  
> at System.Reflection.RuntimePropertyInfo.GetValue(Object obj, Object[] index)  
> at Microsoft.Exchange.Management.SystemManager.WinForms.DataObjectStore.GetValue(String name, String propertyName)  
> at Microsoft.Exchange.Management.SystemManager.WinForms.AutomatedDataHandlerBase.UpdateTable(DataRow row, String targetConfigObject, Boolean isOnReading)  
> at Microsoft.Exchange.Management.SystemManager.WinForms.AutomatedDataHandler.OnReadData(CommandInteractionHandler interactionHandler, String pageName)  
> at Microsoft.Exchange.Management.SystemManager.WinForms.DataHandler.Read(CommandInteractionHandler interactionHandler, String pageName)  
> at Microsoft.Exchange.Management.SystemManager.WinForms.DataContext.ReadData(CommandInteractionHandler interactionHandler, String pageName)  
> at Microsoft.Exchange.Management.SystemManager.WinForms.ExchangePage.\<OnSetActive>b__0(Object sender, DoWorkEventArgs e)  
> at System.ComponentModel.BackgroundWorker.WorkerThreadStart(Object argument)

This is a known issue in Exchange Server 2010. Mainstream support for Exchange Server 2010 ended on January 13, 2015. For more information, see [Microsoft Support Lifecycle](https://support.microsoft.com/lifecycle/search/?p1=13965).

## Workaround

To view the recipient properties for mailboxes in an environment that has directory synchronization enabled, use the Exchange admin center in Exchange Online, or use Exchange Online PowerShell.

> [!NOTE]
> You can still use the on-premises Exchange Management Console to create and manage mailboxes in Exchange Online.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](https://social.technet.microsoft.com/forums/exchange/home?category=exchange2010%2cexchangeserver).
