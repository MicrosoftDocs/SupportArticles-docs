---
title: Set up peer cache for Configuration Manager clients
description: Describes and illustrates through log file examples how to configure peer cache for Configuration Manager clients.
ms.reviewer: kaushika, vinpa,brianhun
ms.date: 12/05/2023
---
# Configure peer cache for Configuration Manager clients

*Applies to*: Microsoft Endpoint Configuration Manager (current branch)

Peer cache is a built-in solution for Microsoft Endpoint Configuration Manager that enables clients to share content with other clients directly from their local cache. It extends traditional content deployment solutions, such as distribution points. Use peer cache to help manage deployment of content to clients in remote locations. For more information, see [Peer cache for Configuration Manager clients](/mem/configmgr/core/plan-design/hierarchy/client-peer-cache).

## Configure peer cache client settings

To enable clients to be peer cache sources, follow these steps:

1. In the Configuration Manager console, create a device collection. Determine which clients you want to enable as peer cache sources, and add them to the collection.
1. Go to the **Administration** workspace, and then select the **Client Settings** node.
1. Select **Create Custom Client Device Settings**, specify a name and description, and then select the **Client Cache Settings** group.

   :::image type="content" source="media/configure-peer-cache/select-client-cache-settings.png" alt-text="Screenshot highlights the Client Cache Settings in Create Custom Client Device Settings window.":::
1. In the navigation pane, select **Client Cache Settings**, set **Enable as peer cache source** to **Yes**, and then specify the ports.

   :::image type="content" source="media/configure-peer-cache/specify-client-cache-settings.png" alt-text="Screenshot shows details of the Client Cache Settings.":::
1. Select **OK** to save the settings.
1. Deploy this custom client setting to the device collection that you created in step 1.

You don't have to enable peer cache clients. When you enable clients to be peer cache sources, the management point includes them in the list of content location sources.

### Changes on clients that act as peer cache sources

When the client cache setting is deployed to the device collection, you'll see the following changes on the peer cache sources:

- In the WMI class instance `CCM_SuperPeerClientConfig.SiteSettingsKey=1` under `ROOT\ccm\Policy\Machine\ActualConfig`:

  The value of the **CanBeSuperPeer** property is changed to **True**.
- The following entries are logged in CcmExec.log:

  ```output
  Notifying endpoint 'SuperPeerController' of 1 settings change(s).
  Notifying endpoint 'SuperPeerController' of __InstanceModificationEvent settings change on object CCM_SuperPeerClientConfig.SiteSettingsKey=1 for user 'SID'.
  ```

- The following entries are logged in CAS.log:

  ```output
  SuperPeerController main thread has started.
  SuperPeerController has started
  ```

- A state message of topic type 7201 is generated. The following entries are logged in StateMessage.log:

  ```output
  Adding message with TopicType 7201 and TopicId Super Peer is now active to WMI
  State message(State ID : 2) with TopicType 7201 and TopicId Super Peer is now active has been recorded for SYSTEM
  ```

### Change on the management point

The state message is formatted as XML, and then sent to the management point (MP_RelayEndpoint) through CCMMessaging.

You'll see the following entry in the MP_Relay.log file:

```output
Message Body :
<?xml version="1.0" encoding="UTF-16"?>
<Report><ReportHeader><Identification><Machine><ClientInstalled>1</ClientInstalled><ClientType>1</ClientType><ClientID>GUID:xxxx</ClientID><ClientVersion>5.00.9040.1015</ClientVersion><NetBIOSName>TestClient</NetBIOSName><CodePage>437</CodePage><SystemDefaultLCID>1033</SystemDefaultLCID><Priority>1</Priority></Machine></Identification></ReportDetails></ReportHeader><ReportBody><Topic ID="Super Peer is now active" Type="7201" IDType="0" User="" UserSID=""/><State ID="2"Criticality="0"/><StateDetails Type="1"><![CDATA[<ContentList><Content id="CAS00015" version="1" Flag="0"/></ContentList>]]></StateDetails><UserParameters Flags="0" Count="1"><Param>8003</Param></UserParameters></StateMessage></ReportBody></Report>
```

When the site server receives the state message, it calls the `spUpdateSuperPeerStatus` stored procedure to update the following tables:

- SuperPeers
- SuperPeerContentMap

## Configure boundary group options for peer downloads

1. In the Configuration Manager console, go to the **Administration** workspace, and then select **Hierarchy Configuration** > **Boundary Groups**.
1. Locate the boundary group that contains the peer cache clients and peer cache sources.
1. Right-click the boundary group, and then select **Properties**.
1. Select the **Options** tab, and then enable the **Allow peer downloads in this boundary group** setting.

   :::image type="content" source="media/configure-peer-cache/boundary-group-option.png" alt-text="Screenshot of the Allow peer downloads in this boundary group setting under Options tab.":::

## Example scenario

The following example is used to show how peer cache works during content deployment.

### Deploy an application to the peer cache source

When an application is deployed and installed on the peer cache source, the Content Access service generates a state message of topic type 7200. The following entry is logged in StateMessage.log:

```output
State message(State ID : 1) with TopicType 7200 and TopicId Cache add CAS00015.1 has been recorded for SYSTEM
```

The state message is sent to the management point through CCMMessaging.

When the site server receives this state message, the SuperPeerContentMap table is updated.

### Deploy an application to the peer cache client

The client downloads the policy for the application. For a **Required** deployment, the client sends request to the management point for content locations.

The following entries are logged in LocationServices.log:

```output
ContentLocationRequest : <ContentLocationRequest SchemaVersion="1.00" BGRVersion="1" ClientInOperation="PT0M" ExcludeFileList=""><Package ID="CAS00015" Version="1"
DeploymentFlags="9223372036855313105"/><AssignedSite SiteCode="P01"/><ClientLocationInfo LocationType="SMSPackage" DistributeOnDemand="0" UseAzure="1" AllowWUMU="0" UseInternetDP="0" AllowHTTP="1" AllowSMB="1" AllowMulticast="1" AllowSuperPeer="1" DPTokenAuth="1"><ADSite Name="Default-First-Site-Name"/><Forest Name="Contoso.Com"/><Domain Name="Contoso.Com"/><IPAddresses><IPAddress SubnetAddress="192.X.X.X" Address="192.X.X.X"/></IPAddresses><Adapters><Adapter Name="Ethernet" IfType="6" PhysicalAddressExists="1" DnsSuffix="abc.com" Description="Network Adapter"/></Adapters><BoundaryGroups BoundaryGroupListRetrieveTime="2021-04-03T14:03:16.603" IsOnVPN="0"><BoundaryGroup GroupID="5" GroupGUID="xxxx" GroupFlag="0"/><DOINCServers><DOINCServer DOINCServer="P01.Contoso.Com"/></DOINCServers></BoundaryGroups></ClientLocationInfo></ContentLocationRequest> LocationServices
```
> [!NOTE]
> Because the **Allow peer downloads in this boundary group** option is enabled in the boundary group, **AllowSuperPeer** is set to **1** in the request. Otherwise, **AllowSuperPeer** is set to **0** in the request.
>
> To use the peer cache source for content download, enable the **Allow peer downloads in this boundary group** option for each boundary group that contains the client.

The management point replies by returning the list of content locations. You can also find the list in LocationServices.log:

```output
Calling back with the following distribution points 
Distribution Point='https://TestClient.Contoso.Com:8003/SCCM_BranchCache$/CAS00015', Locality='SUBNETPEER', Version='9040', Capabilities='<Capabilities SchemaVersion="1.0"><Property Name="SSLState" Value="63"/></Capabilities>', Signature='', ForestTrust='TRUE', BlockInfo='0'        
Distribution Point='http://P01.Contoso.com/SMS_DP_SMSPKG$/CAS00015', Locality='SUBNET', Version='9040', Capabilities='<Capabilities SchemaVersion="1.0"><Property Name="SSLState" Value="0"/></Capabilities>', Signature='http://P01.Contoso.Com/SMS_DP_SMSSIG$/CAS00015', ForestTrust='TRUE', BlockInfo='0'        
Distribution Point='https://P01.Contoso.Com/CCMTOKENAUTH_SMS_DP_SMSPKG$/CAS00015', Locality='SUBNET', Version='9040', Capabilities='<Capabilities SchemaVersion="1.0"><Property Name="SSLState" Value="0"/><Property Name="AuthMethod" Value="1024"/></Capabilities>', Signature='https://P01.Contoso.Com/CCMTOKENAUTH_SMS_DP_SMSSIG$/CAS00015', ForestTrust='TRUE', BlockInfo='0'
```

ContentTransferManager.log also shows the content locations that include the peer cache source and distribution points:

```output
ContentTransferManager    4324 (0x10e4)    Persisted locations for CTM job {139431E9-B106-49DC-B7A8-543D55110DE6}:
(SUBNETPEER) https://TestClient.Contoso.Com:8003/SCCM_BranchCache$/CAS00015
(SUBNET) http://P01.Contoso.Com/SMS_DP_SMSPKG$/CAS00015
(SUBNET) https://P01.Contoso.Com/CCMTOKENAUTH_SMS_DP_SMSPKG$/CAS00015
```

Peer cache clients prioritize peer cache sources to download content. This precedence is shown in the following entry in DataTransferService.log:

```output
 DTSJob {0C3B06F6-E85D-4C54-9B4F-0B316B33AA5B} created to download from 'https://TestClient.Contoso.Com:8003/SCCM_BranchCache$/CAS00015' to 'C:\windows\ccmcache\1'.
```

> [!NOTE]
>
> - Clients can download content from only the peer cache sources that are in their current boundary group.
> - If the client falls back to a neighbor boundary group for content, the management point doesn't add the peer cache sources from the neighbor boundary group to the list of potential content source locations.
> - If a client is in more than one boundary group, enable the **Allow peer download in this boundary group** option in each boundary group. If this option is disabled in any boundary group, the client won't use the peer cache optimization.
