---
title: Troubleshoot references to WCF or WCF Data Services
description: Review common issues that may occur when you're working with Windows Communication Foundation (WCF) or WCF Data Services references in Visual Studio.
ms.date: 11/04/2016
f1_keywords:
- msvse_wcf.Err.ReferenceGroup_NamespaceConflictsOther
- msvse_wcf.Err.AddSvcRefDlg_NothingSelectedOnGo
- msvse_wcf.Err.ErrorOnOK
- msvse_wcf.cfg.ConfigurationErrorsException
author: HaiyingYu
ms.author: haiyingyu
ms.reviewer: ghogen
ms.custom: sap:Integrated Development Environment (IDE)\Other
---
# Troubleshoot Windows Communication Foundation (WCF) or WCF Data Services references in Visual Studio

_Applies to:_&nbsp;Visual Studio

This article lists solutions to common issues that may occur when you're working with references to [Windows Communication Foundation (WCF) or WCF Data Services in Visual Studio](/visualstudio/data-tools/windows-communication-foundation-services-and-wcf-data-services-in-visual-studio).

If you want to update or remove a service reference, see [Add, update, or remove a WCF data service reference](/visualstudio/data-tools/how-to-add-update-or-remove-a-wcf-data-service-reference).

## Error when no service address is provided

When you select the **Go** button with no address, you may see an error message that says "Please enter the address for a service." To resolve this issue, identify the service's address and enter it.

- If it's a service in your solution, you can use the **Discover** button to find and select it, and then try the **Go** button again.
- If it's a service hosted somewhere on the internet, add it by following the instructions at [Add a WCF service reference](/visualstudio/data-tools/how-to-add-update-or-remove-a-wcf-data-service-reference#add-a-wcf-service-reference).

## Error returning data from a service

When you return a `DataSet` or `DataTable` from a service, you may receive a "The maximum size quota for incoming messages has been exceeded" exception. By default, the `MaxReceivedMessageSize` property for some bindings is set to a relatively small value to limit exposure to denial-of-service attacks. You can increase this value to prevent the exception. For more information, see <xref:System.ServiceModel.HttpBindingBase.MaxReceivedMessageSize%2A>.

To fix this error:

1. In **Solution Explorer**, double-click the _app.config_ file to open it.
2. Locate the `MaxReceivedMessageSize` property and change it to a larger value.

## Can't find a service in my solution

When you select the **Discover** button in the **Add Service References** dialog box, one or more WCF Service Library projects in the solution don't appear in the services list. This issue can occur if a Service Library has been added to the solution but hasn't yet been compiled.

To fix this error:

1. In **Solution Explorer**, right-click the WCF Service Library project.
1. Select **Build**.

## Error accessing a service over a remote desktop

When a user accesses a Web-hosted WCF service over a remote desktop connection and the user doesn't have administrative permissions, NTLM authentication is used. If the user doesn't have administrative permissions, the user may receive the following error message: "The HTTP request is unauthorized with client authentication scheme 'Anonymous'. The authentication header received from the server was 'NTLM'."

To fix this error:

1. In the website project, open the **Properties** pages.
2. On the **Start Options** tab, clear the **NTLM Authentication** check box.

> [!NOTE]
> You should turn off NTLM authentication only for websites that exclusively contain WCF services. Security for WCF services is managed through the configuration in the *web.config* file. This makes NTLM authentication unnecessary.

## Access level for generated classes setting has no effect

Setting the **Access level for generated classes** option in the **Configure Service References** dialog box to **Internal** or **Friend** may not always work. Even though the option appears to be set in the dialog box, the resulting support classes are generated with an access level of `Public`. This is a known limitation of certain types, such as those serialized using the <xref:System.Xml.Serialization.XmlSerializer>.

## Error debugging service code

When you step into the code for a WCF service from client code, you may receive an error related to missing symbols. It can occur when a service that was part of your solution was moved or removed from the solution.

When you first add a reference to a WCF service that is part of the current solution, an explicit build dependency is added between the service project and the service client project. This guarantees that the client always accesses up-to-date service binaries, which is especially important for debugging scenarios such as stepping from client code into service code.

If the service project is removed from the solution, this explicit build dependency is invalidated. Visual Studio can no longer guarantee that the service project is rebuilt as necessary.

To fix this error, manually rebuild the service project:

1. On the **Tools** menu, select **Options**.
2. In the **Options** dialog box, expand **Projects and Solutions**, and then select **General**.
3. Make sure that the **Show advanced build configurations** check box is selected, and then select **OK**.
4. Load the WCF service project.
5. In the **Configuration Manager** dialog box, set the **Active solution configuration** to **Debug**. For more information, see [How to: Create and edit configurations](/visualstudio/ide/how-to-create-and-edit-configurations).
6. In **Solution Explorer**, select the WCF service project.
7. On the **Build** menu, select **Rebuild** to rebuild the WCF service project.

## WCF Data Services don't display in the browser

When it attempts to view an XML representation of data in a WCF Data Service, Internet Explorer may misinterpret the data as an RSS feed. Make sure that the option to display RSS feeds is disabled.

To fix this error, disable RSS feeds:

1. In Internet Explorer, on the **Tools** menu, select **Internet Options**.
2. On the **Content** tab, in the **Feeds** section, select **Settings**.
3. In the **Feed Settings** dialog box, clear the **Turn on feed reading view** check box, and then select **OK**.
4. Select **OK** to close the **Internet Options** dialog box.
