---
title: InfoPath Forms Services differences between SharePoint Online On-Premises
description: This article describes some differences between SharePoint Online (DvNext/MT) and SharePoint On-Premises in how InfoPath Forms Services works
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: CSSTroubleshoot
appliesto: 
  - SharePoint Online
  - SharePoint Server
ms.date: 12/17/2023
---

# InfoPath Forms Services differences between SharePoint Online (DvNext/MT) and SharePoint On-Premises

This article describes some differences between SharePoint Online (DvNext/MT) and SharePoint On-Premises in how InfoPath Forms Services works.

## Central Administration options

InfoPath Forms Services is a farm-level feature. The displayed options in On-Premises Central Administration can't be changed in the DvNext/MT environment on a per-tenant basis. This is because modifications to these settings could affect other tenants in the farm. 

The only available InfoPath Forms Services configurations in the DvNext/MT environment are the options that are shown in the following screen shots, specifically in the "DvNext/MT" screen shot.

**SharePoint On-Premises**

:::image type="content" source="media/infopath-forms-services/sharepoint-on-premises.png" alt-text="Screenshot of the InfoPath Forms Services configurations in SharePoint On-Premises." border="false":::

**SharePoint Online (DvNext/MT)**

:::image type="content" source="media/infopath-forms-services/sharepoint-online.png" alt-text="Screenshot of the InfoPath Forms Services configurations in SharePoint Online." border="false":::

## Full -Trust browser forms

If a browser-compatible InfoPath form template (.xsn file) is developed in a way that requires the Full Trust security level, the form template can't be published for use in the browser in the DvNext/MT environment.

> [!NOTE]
> If you want to use a Full Trust InfoPath form template in the browser, the template must be uploaded to Central Administration and enabled in the site collections. As the DvNext/MT screen shot shows, this option is unavailable.

## Accessing built-in SharePoint Web Services and REST endpoints from a browser-compatible InfoPath form template

For a list of the only SharePoint Web Services that can be successfully run from an InfoPath browser form, go to the following Knowledge Base article:

[2674193](https://support.microsoft.com/help/2674193) Error message when you connect an InfoPath form to a SharePoint Online web service: "An error occurred while connecting to a Web Service"

> [!NOTE]
> Built-in SharePoint Web Services and REST endpoints must be called from the same site collection to which the .xsn file is published. There are no other built-in SharePoint services that can be successfully called from an InfoPath browser form in the DvNext/MT environment. Any call to a service that's hosted on a SharePoint server will fail, except for the 10 web service calls that are listed in KB 2674193.

## Accessing built-in SharePoint REST endpoints from InfoPath client

SharePoint REST services can't be called from the InfoPath client because the authentication is incompatible. Calling the built-in SharePoint REST endpoints is unsupported in the DvNext/MT environment.

## Custom code and Sandbox Code Service

Running managed code from an InfoPath form template is unsupported in the DvNext/MT environment.

> [!NOTE]
> This isn't specific to InfoPath. Support for the Sandbox Code Service is removed from the DvNext/MT environment.

## Publishing complex form templates

When you publish a browser-compatible InfoPath form from a template, the part of the publishing process that converts the .xsn file to run in the browser must finish within 30 seconds. Large or very complex form templates may take longer to finish, and they aren't published.

In this situation, the form template typically still finishes publishing and opens in the InfoPath client. However, it won't open in a browser because the conversion process times out.

## Running complex form templates

When you run an InfoPath form in the browser, you may receive the following error message:

**The form could not be displayed because default values or rules are taking too long to evaluate. To correct this, simplify the expressions or reduce the size of the data sets that they depend on.**

Typically, this occurs because the form is loading large amounts of data without filtering it. This requires too many resources. The recommended resolution is to use the SharePoint List data connections. These let you apply a filter when you query SharePoint.

## Attachments to InfoPath form templates published to a forms library can't exceed 5 MB

When you add an attachment to a browser instance of an InfoPath form template that was published to a forms library, the attachment is embedded in the InfoPath XML file. Therefore, adding a file that exceeds 5 MB as an attachment can adversely affect the performance of the form. 

This limitation does not apply to SharePoint lists that are customized to use an InfoPath form. In this situation, the file attachments aren't embedded in XML, and they are added to the standard Attachments folder in a SharePoint list.

## UDCX data connections (SSA connections to SharePoint web services or SQL Azure)

When you use an InfoPath form in the browser through Microsoft 365, UDCX connections that contain explicit credentials or Secure Store Application details fail. This is because of the following InfoPath Forms Services options that aren't enabled in the cloud:

- Allow embedded SQL authentication

- Allow user form templates to user authentication information that's contained in data connection files

## Difference in account encoding

If a form is migrated from an on-premises SharePoint environment, it may contain hard-coded references to on-premises accounts in the form of the **i:0#.w|domain\user** or **domain\user accounts**. These accounts notations no longer work in the DvNext/MT environment. They should be replaced by using the **i:0#.f|membership|user@domain** notation.

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
