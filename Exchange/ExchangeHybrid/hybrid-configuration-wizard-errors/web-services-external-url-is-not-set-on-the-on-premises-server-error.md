---
title: Web Services External Url not set on On-Premises error
description: Describes a problem that occurs when the external URL is not set up for Exchange Web Services. Provides a solution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: timothyh, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# (The Web Services External Url is not set on the On-Premises server) error when running Hybrid Configuration wizard

_Original KB number:_ &nbsp; 3058294

## Symptoms

When you run the Hybrid Configuration wizard, you receive the following error message:

> ERROR:Updating hybrid configuration failed with error 'Subtask CheckPrereqs execution failed: Check Prerequisites Microsoft.Exchange.Data.Common.LocalizedException: The Web Services External Url is not set on the On-Premises server  
The Web Services External Url is not set on the On-Premises server  
at Microsoft.Exchange.Management.Hybrid.Engine.ExecuteTask(TaskBase taskBase, TaskContext taskContext)

## Cause

The external URL is not set up for Exchange Web Services.

## Resolution

Configure the Exchange Web Services external URL for the Autodiscover service. For more information about how to do this, see the following resources:

- [Configure Exchange Services for the Autodiscover Service](/previous-versions/office/exchange-server-2010/bb201695(v=exchg.141))
- [Set-WebServicesVirtualDirectory](/powershell/module/exchange/set-webservicesvirtualdirectory?view=exchange-ps&preserve-view=true)

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
