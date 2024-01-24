---
title: Configure Many-to-One client mappings
description: This article introduces about using the Configuration Editor feature of IIS to configure Many-to-One client certificate mappings.
ms.date: 04/02/2020
ms.custom: sap:WWW authentication and authorization
ms.topic: how-to
ms.technology: www-authentication-authorization
---
# Configuring Many-to-One client certificate mappings for IIS 7.0 and 7.5

This article introduces how to use the Configuration Editor feature in Microsoft Internet Information Services (IIS) to configure Many-to-One client certificate mappings.

_Original product version:_ &nbsp; Internet Information Services 7.0, 7.5  
_Original KB number:_ &nbsp; 2026113

## Introduction

Many-to-One Client Certificate mapping is used by IIS to associate an end user to a Windows account when the client certificate is used for user authentication. The user's session is executed under the context of this mapped Windows account by IIS. To work as expected, you need to ensure the certificate-to-account mapping is configured correctly in IIS.

In IIS 6.0, users had the option to configure Many-to-One client certificate mapping through the IIS Manager User Interface. In IIS 7.0 and 7.5, that interface doesn't exist for either One-to-One or Many-to-One mappings. This article talks about using the Configuration Editor feature of IIS to configure Many-to-One client certificate mappings.

> [!NOTE]
> For information about using the Configuration Editor to configure One-to-One client certificate mappings, see [Configuring One-to-One Client Certificate Mappings](/iis/manage/configuring-security/configuring-one-to-one-client-certificate-mappings).

## IIS 7.0/7.5 schema

This is the schema for the IIS Client Certificate Mapping authentication feature in IIS 7.0 and IIS 7.5:

```xml
<sectionSchema name="system.webServer/security/authentication/iisClientCertificateMappingAuthentication">
   <attribute name="enabled" type="bool" defaultValue="false" />
   <attribute name="manyToOneCertificateMappingsEnabled" type="bool" defaultValue="true" />
   ...
   <element name="manyToOneMappings">
     <collection addElement="add" clearElement="clear">
       <attribute name="name" type="string" required="true" isUniqueKey="true"
       validationType="nonEmptyString" />
       <attribute name="description" type="string" />
       <attribute name="enabled" type="bool" defaultValue="true"/>
       <attribute name="permissionMode" type="enum" defaultValue="Allow">
         <enum name="Allow" value="1"/>
         <enum name="Deny" value="2" />
       </attribute>
       <element name="rules">
         <collection addElement="add" clearElement="clear">
           <attribute name="certificateField" type="enum" required="true" isCombinedKey="true">
             <enum name="Subject" value="1" />
             <enum name="Issuer" value="2" />
           </attribute>
           <attribute name="certificateSubField" type="string" caseSensitive="true"
           required="true" isCombinedKey="true" />
           <attribute name="matchCriteria" type="string" caseSensitive="true"
           required="true" isCombinedKey="true" />
           <attribute name="compareCaseSensitive" type="bool" isCombinedKey="true" defaultValue="true" />
         </collection>
       </element>
       <attribute name="userName" type="string" validationType="nonEmptyString" />
       <attribute name="password" type="string" caseSensitive="true" encrypted="true"
       defaultValue="[enc:AesProvider::enc]" />
     </collection>
   </element>
   ...
</sectionSchema>
```

## Prerequisites

Here are the prerequisites needed for this walk-through:

1. You have installed the IIS Client Certificate Mapping module on the IIS server.
2. A web site is configured with a Hypertext Transfer Protocol Secure (HTTPS) binding that can accept Secure Sockets Layer (SSL) connections.
3. You have a client certificate installed on the client.
4. The [IIS 7 Administration Pack](https://www.iis.net/downloads/microsoft/administration-pack) is installed on the IIS 7.0 server.

    > [!NOTE]
    > Configuration Editor is shipped by default on IIS 7.5.

## Configure certificate mapping by Configuration Editor

1. Launch the IIS manager and select the web site to be configured for client certificate authentication.
2. In the **Features View**, select **Configuration Editor** under the **Management** section.

    :::image type="content" source="media/configure-many-to-one-client-mappings/open-features-view.png" alt-text="Select the Configuration Editor under Management in Features View.":::

3. Go to `system.webServer/security/authentication/iisClientCertificateMappingAuthentication` in the drop-down box as shown below:

    :::image type="content" source="media/configure-many-to-one-client-mappings/iisclientcertificatemappingauthentication.png" alt-text="Select iisClientCertificateMappingAuthentication under authentication.":::

    You will see a window to configure Many-to-One or One-to-One certificate mappings here. This is the UI provided through Configuration Editor from where you can set up all of the mapping configurations.

    :::image type="content" source="media/configure-many-to-one-client-mappings/setup-configure-mapping.png" alt-text="Screenshot of the window that's used to set up all mapping configurations.":::

4. Modify the properties through this graphical user interface (GUI).

    - Set **enabled** to **True**.
    - Set **manyToOneCertificateMappingsEnabled** to **True**.
    - Select **manyToOneMappings** and select on the ellipsis button to launch a new window for configuring mappings.

5. Under this new window, select to add a new item. You can modify the properties from within the window as shown below:

    :::image type="content" source="media/configure-many-to-one-client-mappings/modify-properties.png" alt-text="Screenshot of the window that's used to modify properties for a new item.":::

6. Select on the ellipsis button for **rules**, which will give you the option to add multiple patterns for matching based on the certificate properties.

    :::image type="content" source="media/configure-many-to-one-client-mappings/add-multiple-patterns-example-1.png" alt-text="Screenshot 1 for adding multiple patterns.":::

    :::image type="content" source="media/configure-many-to-one-client-mappings/add-multiple-patterns-example-2.png" alt-text="Screenshot 2 for adding multiple patterns.":::

    :::image type="content" source="media/configure-many-to-one-client-mappings/add-multiple-patterns-example-3.png" alt-text="Screenshot 3 for adding multiple patterns.":::

In these example images, there are two entries for rules for mapping the certificate.

First, there are the **Subject** and **Issuer** fields in the certificate.  Second, there is the **matchcriteria** property to map the certificate to the account **mydomain\testuser**.  

In the image below, the final mapping for a specific windows account is illustrated. As you can see, there are two entries for **rules** for this account.

:::image type="content" source="media/configure-many-to-one-client-mappings/entry-for-rules.png" alt-text="Screenshot of an item that has two entries for rules.":::

Similarly, you can have other mappings for the accounts based on the fields **Issuer** and **Subject** in the certificate.

## Configure certificate mapping by APPCMD.exe

So far what has been illustrated is achieved using the Configuration Editor, which provides a graphical interface to easily set the configuration. You can achieve the same thing using `APPCMD.exe` commands, and in fact the Configuration Editor does the same thing in the background and adds these settings into the *ApplicationHost.config* file.

Configuration Editor also gives you an option to run these commands manually, and it generates the scripts to achieve it from inside the UI itself:

:::image type="content" source="media/configure-many-to-one-client-mappings/generate-script.png" alt-text="Select the Generate Script option to run commands.":::

:::image type="content" source="media/configure-many-to-one-client-mappings/script-dialog.png" alt-text="Run commands manually in the Script Dialog window.":::

These are the code snippets to perform the same steps as above to configure the certificate mapping. They were generated using Configuration Editor's Script Generation feature.

### AppCmd commands

```console
appcmd.exe set config "Default Web Site" -section:system.webServer/security/authentication/iisClientCertificateMappingAuthentication /enabled:"True" /manyToOneCertificateMappingsEnabled:"True"  /commit:apphost
appcmd.exe set config "Default Web Site" -section:system.webServer/security/authentication/iisClientCertificateMappingAuthentication /+"manyToOneMappings.[name='My 1st  Mapping',description='1st User Mapping',userName='mydomain\testuser',password='abcdef']" /commit:apphost
appcmd.exe set config "Default Web Site" -section:system.webServer/security/authentication/iisClientCertificateMappingAuthentication /+"manyToOneMappings.[name='My 1st  Mapping',description='1st User Mapping',userName='mydomain\testuser',password='abcdef'].rules.[certificateField='Subject',certificateSubField='CN',matchCriteria='Test User']" /commit:apphost
```

### C# code

```csharp
using System.Text;
using Microsoft.Web.Administration;
internal static class Sample {
    private static void Main() {
        using(ServerManager serverManager = new ServerManager())
        {
            Configuration config = serverManager.GetApplicationHostConfiguration();
            ConfigurationSection iisClientCertificateMappingAuthenticationSection =
            config.GetSection("system.webServer/security/authentication/iisClientCertificateMappingAuthentication", "Default Web Site");
            iisClientCertificateMappingAuthenticationSection["enabled"] = true;
            iisClientCertificateMappingAuthenticationSection["manyToOneCertificateMappingsEnabled"] = true;
            ConfigurationElementCollection manyToOneMappingsCollection = iisClientCertificateMappingAuthenticationSection.GetCollection("manyToOneMappings");
            ConfigurationElement addElement = manyToOneMappingsCollection.CreateElement("add");
            addElement["name"] = @"My 1st  Mapping";
            addElement["description"] = @"1st User Mapping";
            addElement["userName"] = @"mydomain\testuser";
            addElement["password"] = @"abcdef";
            ConfigurationElementCollection rulesCollection = addElement.GetCollection("rules");
            ConfigurationElement addElement1 = rulesCollection.CreateElement("add");
            addElement1["certificateField"] = @"Subject";
            addElement1["certificateSubField"] = @"CN";
            addElement1["matchCriteria"] = @"Test User";
            rulesCollection.Add(addElement1);
            manyToOneMappingsCollection.Add(addElement);
            serverManager.CommitChanges();
        }
    }
}
```

### Scripting (JavaScript)

```javascript
var adminManager = new ActiveXObject('Microsoft.ApplicationHost.WritableAdminManager');
adminManager.CommitPath = "MACHINE/WEBROOT/APPHOST";
var iisClientCertificateMappingAuthenticationSection = adminManager.GetAdminSection("system.webServer/security/authentication/iisClientCertificateMappingAuthentication", "MACHINE/WEBROOT/APPHOST/Default Web Site");
iisClientCertificateMappingAuthenticationSection.Properties.Item("enabled").Value = true;
iisClientCertificateMappingAuthenticationSection.Properties.Item("manyToOneCertificateMappingsEnabled").Value = true;
var manyToOneMappingsCollection = iisClientCertificateMappingAuthenticationSection.ChildElements.Item("manyToOneMappings").Collection;
var addElement = manyToOneMappingsCollection.CreateNewElement("add");
addElement.Properties.Item("name").Value = "My 1st  Mapping";
addElement.Properties.Item("description").Value = "1st User Mapping";
addElement.Properties.Item("userName").Value = "mydomain\\testuser";
addElement.Properties.Item("password").Value = "abcdef";
var rulesCollection = addElement.ChildElements.Item("rules").Collection;
var addElement1 = rulesCollection.CreateNewElement("add");
addElement1.Properties.Item("certificateField").Value = "Subject";
addElement1.Properties.Item("certificateSubField").Value = "CN";
addElement1.Properties.Item("matchCriteria").Value = "Test User";
rulesCollection.AddElement(addElement1);
manyToOneMappingsCollection.AddElement(addElement);
adminManager.CommitChanges();
```
