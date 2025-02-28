---
title: Information associated with IIS site isn't deleted
description: This article provides resolutions for the problem where information associated with IIS site isn't deleted during programmatic site deletion.
ms.date: 12/18/2024
ms.custom: sap:WWW Administration and Management\Legacy IIS administration scripts
ms.reviewer: paulboc, zixie
---
# Information associated with IIS site isn't deleted during programmatic site deletion

This article helps you resolve the problem where information associated with IIS site isn't deleted during programmatic site deletion.

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 3202096

## Symptoms

Consider the following scenario:

- You delete a site by using calls to `appcmd` or to the managed APIs that are exposed by `Microsoft.Web.Administration` binary.
- You create a new site in Internet Information Services (IIS).
- The new site still uses the legacy metadata of the deleted site.

In this scenario, unexpected behavior occurs when you try to access the newly created site. For example, you might receive an **HTTP 503 - Service Unavailable** error message in your web browser.

## Cause

The problem occurs when a delete operation for an existing website in IIS is performed programmatically by using `appcmd` or `Microsoft.Web.Administration` APIs and if the site has legacy properties defined in the `<CustomMetaData>` configuration element of the ApplicationHost.config file of the IIS server. The information in the `<CustomMetaData>` tag that's relevant to the site isn't deleted in this scenario. If a new site with the same ID is created after the delete operation, this new site is associated with the legacy properties of the old site.

## Resolution

You can use the IIS Administration Console to delete the website instead of making calls to `appcmd` or `Microsoft.Web.Administration`. This method makes sure that if there are any custom legacy properties associated with the website you're trying to delete, they are also deleted from the IIS configuration file (**ApplicationHost.config**). This behavior prevents these properties from being unexpectedly associated with a new website that you create on the same server that reuses the ID of the old deleted site.

If you must delete the site programmatically for any reason and can't use the IIS Manager Console, you can add either of the two workarounds to make sure that the information on the legacy properties that's associated with the site through the `<CustomMetaData>` element is also deleted.

### Workaround 1: Use appcmd commands

If you use `appcmd` to delete the site, you can then run the following command to remove any legacy properties that the site might have in the IIS configuration:

```console
Appcmd clear config -section:customMetadata -[path='LM/W3SVC/<SiteID>']
```

> [!NOTE]
> Replace the `<SiteID>` parameter with the identifier of the site you have just deleted by using `appcmd` commands.

### Workaround 2: Use calls to Microsoft.Web.Administration

If you use managed API calls to `Microsoft.Web.Administration` to delete the website, you can add the following code after the website is deleted to also clear the legacy properties contained in the `<CustomMetaData>` element of the IIS configuration:

```csharp
string path = "LM/W3SVC/" + site.Id.ToString(CultureInfo.InvariantCulture);
string pathWithSlash = path + "/";
for (int i = customMetadata.Count - 1; i >= 0; i--) {
    ConfigurationElement metadata = customMetadata[i];
    string key = (string)metadata["path"];
    if (key != null &&
    (
        key.Equals(path, StringComparison.OrdinalIgnoreCase) || 
        key.StartsWith(pathWithSlash, StringComparison.OrdinalIgnoreCase))
    ) 
    {
        customMetadata.RemoveAt(i);
    }
}
```

> [!NOTE]
> The variable `site` represents the website that you have just deleted by using the `Microsoft.Web.Administration` APIs.

## Steps to reproduce

On a Windows Server:

1. Install the IIS 6 metabase compatibility feature.
1. In the IIS manager, create a second website: call this *WebTest* and make it run on any application pool desired.
1. Open a command line prompt and navigate to: `C:\inetpub\AdminScripts`.
1. Type in the command `adsutil.vbs SET w3svc/2/ServerSize "23"` to add the following section to the W3SVC tag in the **ApplicationHost.config** file:

    ```xml
    <customMetadata>
    ....
    <key path="LM/W3SVC/2">
    <property id="1018" dataType="DWord" userType="1" attributes="Inherit" value="23" />
    </key>
    ....
    </customMetadata>
    ```

1. Navigate to the `C:\windows\system32\inetsrv\` inside the command prompt.
1. Run the command: `appcmd delete site WebTest`.
1. After the site is deleted, the section of the configuration is still in **ApplicationHost.config**.
