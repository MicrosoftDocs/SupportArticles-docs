---
title: Set up your small business network
description: Explains how to set up the network for your small business.
ms.date: 12/26/2023
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Network Connectivity and File Sharing\TCP/IP Connectivity (TCP Protocol, NLA, WinHTTP), csstroubleshoot
---
# Set up your small business network

This article walks you through the steps of evaluating, preparing, and setting up your small business network. The article is for IT Pros who help set up your small business network.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 10064

## Evaluate network types

Many small businesses use a network to share access to the Internet, printers, and files from one computer to another. While having a network almost surely benefits your business, you need to decide which kind of network is the best option for your business depending on its unique and specific needs. The choices you have are wired, wireless, and hybrid networks.
When you select a network for your business, you should consider two main points - the location of your devices and how fast you want your network to be. Although costs are similar between the different types, prices will vary according to the network speed that you select.

The following sections describe the different network options available.

### Wired networks

Wired or Ethernet networks can transfer data from 10 Mbps to 1000 Mbps, depending on the type of cables you use. Gigabit Ethernet provides the fastest transfer rate at up to 1 gigabit per second (1000 Mbps).

#### Advantages

- Ethernet networks are highly secure and fast.
- Ethernet networks are safer than wireless networks because they're fully contained.
- Ethernet networks aren't affected by interference of objects or walls.

#### Drawbacks

- You must run Ethernet cables between each device and a hub, switch, or router. It can be time-consuming and difficult when devices are in different rooms.
- The hardware is more expensive.

#### Hardware requirements

|Hardware|How many|
|---|---|
|Ethernet network adapter<br/>An adapter connects devices to a network so that they can communicate. You can connect a network adapter to a USB port with either Ethernet cables or USB cables, depending on the type of adapter. You can also install a network adapter inside a device.|One for each device on your network. Desktop computers usually have these adapters built in.|
|Ethernet hub or switch<br/>A hub passes data from one device to another. Because the hub can't identify the data source as coming from the Internet or another device, it sends the information to all connected devices, including the one that sent it. A switch works similar to a hub. But a switch can also identify the intended destination of the information so that only the intended devices receive it. A switch costs a bit more than a hub, but has faster speed.|One. A 10/100/1000 hub or switch is best and should have enough ports to accommodate all the devices on your network.|
|Ethernet router (only needed if you want to connect more than two devices that share an Internet connection)<br/>A router helps you share a single Internet connection among several devices. You don't require a router to set up a wired network, but you should use one if you want multiple devices to share an Internet connection.|One. You might need an extra hub or switch if your router doesn't have enough ports for all of your devices.|
|Modem<br/>Devices use modems to send and receive information over telephone or cable lines. You need a modem if you want to connect to the Internet.|One.|
|Ethernet cables<br/>Network cables connect devices to one another and to other related hardware, such as hubs, routers, and external network adapters.|One for each device that needs to connect to the network hub or switch. 10/100/1000 Cat 6 cables are best, but not required.|
  
### Wireless networks

Wireless networks can transfer data anywhere from 10-600 megabytes per second (Mbps) depending on the type of wireless standard that your modem uses.

#### Advantages

- You can easily move devices because there are no cables.
- Wireless networks are cheaper to install than wired networks.
- You can often improve the wireless signal by using a wireless repeater. Wireless repeaters pick up a signal, and if the signal has degraded, the repeater can rebroadcast it again at full strength.

#### Drawbacks

- Wireless technology is often slower than wired technologies.
- Wireless technology can be affected by interference from walls, large metal objects, and pipes. Also, many cordless phones and microwave ovens can interfere with wireless networks when in use.
- Wireless networks are frequently about half as fast as their rated speed.

#### Hardware requirements

|Hardware|How many|
|---|---|
|Wireless network adapter<br/>An adapter connects devices to a network so that they can communicate.|One for each device on your network. Portable devices usually have them built in.|
|Wireless router<br/>A router helps you share a single Internet connection among several devices. You don't require a router to set up a wired network, but you should use one if you want multiple devices to share an Internet connection.|One.|
  
If your device has built-in wireless capabilities, then you don't need a wireless network adapter.

### Hybrid networks

Hybrid networks use a combination of wireless and wired networks and offer the best of both network types so that you can use faster wired desktops and portable wireless mobile devices, such as laptops, tablets and smartphones. A hybrid network relies on special hybrid routers, hubs, switches, and Ethernet cables to connect wired and wireless devices. A hybrid router does two things - broadcasts a wireless signal and provides wired access ports. It's most commonly referred to as a wireless or Wi-Fi router with Ethernet ports or "LAN ports".

A hybrid wired/wireless network seems to offer the best of both worlds in speed, mobility, affordability and security. If users need maximum Internet and file-sharing speed, they can plug into the network with an Ethernet cable. If they need to share a streaming video in the office hallway, they can access the network wirelessly. With the right planning, an organization can save money on CAT5/CAT6 cables and routers by maximizing the reach of the wireless network. With the right encryption and password management in place, the wireless portion of the network can be as secure as the wired.

|Hardware|How many|
|---|---|
|Network adapter<br/>An adapter connects devices to a network so that they can communicate.|One for each device on your network. Both desktops and portable devices usually have these adapters built in.|
|hybrid router<br/>A router helps you share a single Internet connection among several devices. You don't require a router to set up a wired network, but you should use one if you want multiple devices to share an Internet connection.|At least one. If you need to connect more than four wired devices, add an extra wired router.|
|Ethernet cables<br/>Network cables connect devices to one another and to other related hardware, such as hubs, routers, and external network adapters.|One for each device connected to the network hub or switch. 10/100/1000 Cat 6 cables are best, but not required.|
  
## Install a wired network

Wired networks are faster, more secure, and reliable than wireless networks. They also reduce the chance of outside interference. At the same time, they require a bit more work to set up and the hardware is more expensive.

> [!Note]
> If your small business has lots of floor space, such as a manufacturing facility, you may experience signal degradation if there are very long cables between devices. You can often improve the signal by using an Ethernet repeater to strengthen the signal. To begin, follow the procedure for the version of Windows running on the device that you want to connect to your network. All of your devices don't need to run the same version of Windows to be a part of your business network.

### Connect the cables

To begin, run an Ethernet cable from the router or hub to each device that you want to connect to the network.

#### Install the network adapters

Windows can automatically detect and install the correct network adapter software for you.

To check whether your device has a network adapter, follow the instructions.

1. Swipe in from the right edge of the screen (if using a mouse, point to the upper-right corner of the screen and move the mouse pointer down).
2. Tap or click **Search**.
3. Type _device manager_ in the Search box.
4. Tap or click **Settings**.
5. Tap or click **Device Manager** on the left side of your screen.
6. To see a list of installed network adapters, expand Network adapter(s).

#### Set up your router

If your router displays the Windows logo or the phrase Compatible with Windows, you can set it up automatically using the latest version of Windows Connect Now (WCN). Otherwise, most routers come with instructions and a setup CD that will help you set them up.

If you have a combined modem and router, follow these instructions:

1. Plug the modem into an electrical outlet.
2. Plug one end of a phone cord or cable into the wide area network (WAN) port of the device and then plug the other end into the wall jack. The WAN port should be labeled "WAN." (DSL users shouldn't use a DSL filter on the phone line.)
3. Plug one end of an Ethernet cable into the local area network (LAN) port on the device and the other end into the networking port of the device that you want to connect to the Internet. The LAN port should be labeled "LAN."
4. Start (or restart) the device.

#### Connect your router to the Internet

To connect your router to the Internet, follow the instructions.

1. Swipe in from the right edge of the screen (if using a mouse, point to the upper-right corner of the screen and move the mouse pointer down).
2. Tap or click **Search**.
3. Tap or click the down arrow next to **Everywhere** above the Search box, and tap or click **Settings**.
4. Type _network and sharing center_ in the Search box.
5. Tap or click **Network and Sharing Center** from the search result.
6. Tap or click Set up a new **connection or network**.
7. Tap or click **Connect to the Internet**.
8. Tap or click **Next**.

If your home or office is wired for Ethernet, set up the devices in rooms that have Ethernet jacks, and then plug them directly into the Ethernet jacks.

### Set up a separate modem to attach to a router

If you purchased a separate modem and router, follow these instructions:

1. Plug the modem into an electrical outlet.
2. Plug one end of a phone cord or cable into the modem and the other end into the wall jack. (DSL users shouldn't use a DSL filter on the phone line.)
3. Plug one end of an Ethernet cable into the modem and the other end into the wide area network (WAN) port on the router.
4. Plug the router into an electrical outlet.
5. Plug one end of an Ethernet cable into the local area network (LAN) port on the router and the other end into the networking port on the device that you want to connect to the Internet.
6. Start or restart the device.

### Connect the modem to the Internet

Follow the instructions to Connect the modem to the Internet.

1. Swipe in from the right edge of the screen (if using a mouse, point to the upper-right corner of the screen and move the mouse pointer down).
2. Tap or click **Search**.
3. Tap or click the down arrow next to **Everywhere** above the Search box, and tap or click **Settings**.
4. Type _network and sharing center_ in the Search box.
5. Tap or click **Network and Sharing Center** from the search result.
6. Tap or click **Set up a new connection or network**.
7. Tap or click **Connect to the Internet**.
8. Tap or click **Next**.

### Set up a firewall

A firewall is hardware or software that helps control the spread of malicious software on your network and helps to protect your devices when you use the Internet.

Don't turn off Windows Firewall unless you have another firewall turned on. Turning off Windows Firewall might make your device and network vulnerable to damage from hackers.
To set up a firewall, follow the instructions:

1. Swipe in from the right edge of the screen (if using a mouse, point to the upper-right corner of the screen and move the mouse pointer down).
2. Tap or click **Search**.
3. Type _firewall_ in the Search box.
4. Tap or click **Settings**.
5. Tap or click **Windows Firewall** on the left side of your screen.
6. In the left pane, tap or click **Turn Windows Firewall on or off**.
7. Tap or click **Turn on Windows Firewall** under each type of network that you want to help protect, and then tap or click **OK**.
   > [!Note]
   > You might be asked for an administrator password or to confirm your choice.

#### Enable file and printer sharing with a firewall

Windows Firewall automatically opens the correct ports for file and printer sharing when you share content or turn on network discovery. If you're using another firewall, you must open these ports yourself so that your device can find other devices that have files or printers that you want to share.

To find other devices running Windows 8, Windows 7, or Windows Vista, open these ports:

- UDP 3702
- UDP 5355
- TCP 5357
- TCP 5358

To find other devices running earlier versions of Windows, and to use file and printer sharing on any version of Windows, open these ports:

- UDP 137
- UDP 138
- TCP 139
- TCP 445
- UDP 5355

To find network devices, open these ports:

- UDP 1900
- TCP 2869
- UDP 3702
- UDP 5355
- TCP 5357
- TCP 5358

### Connect devices to the network

If the devices running Windows 7 are connected to either a hub or a switch using a cable, then they're already on the network, and ready to use.

If you had to change the workgroup name, you're prompted to restart your device. Restart the device, and then continue with the following steps.

1. Click **Start**.
2. Click **My Network Places**.
3. In the left pane, under **Network Tasks**, click **View workgroup computers**.
4. Select the device from the list that appears and click **Connect**.

### Connect the cables

To begin, run an Ethernet cable from the router or hub to each device that you want to connect to the network.

#### Install the network adapters

Windows can automatically detect and install the correct network adapter software for you. To check whether your device has a network adapter, follow the instructions.

1. Right-click **Computer**.
2. Click **Properties**.
3. Click **Device Manager** on the left pane.
4. To see a list of installed network adapters, expand Network adapter(s).

#### Set up your router

If your router displays the Windows logo or the phrase Compatible with Windows, you can set it up automatically using the latest version of Windows Connect Now (WCN). Otherwise, most routers come with instructions and a setup CD that will help you set them up.

If you have a combined modem and router, follow these instructions:

1. Plug the modem into an electrical outlet.
2. Plug one end of a phone cord or cable into the wide area network (WAN) port of the device and then plug the other end into the wall jack. The WAN port should be labeled "WAN." (DSL users shouldn't use a DSL filter on the phone line.)
3. Plug one end of an Ethernet cable into the local area network (LAN) port on the device and the other end into the networking port of the device that you want to connect to the Internet. The LAN port should be labeled "LAN."
4. Start (or restart) the device.

#### Connect your router to the Internet

To connect your router to the Internet, follow the instructions.

1. Click **Start**.
2. Click **Control Panel**.
3. Click **Network and Internet**.
4. Click **Network and Sharing Center**.
5. Click **Set up a connection or network**.
6. Click **Connect to the Internet**.
7. Follow the instructions in the wizard.

If your home or office is wired for Ethernet, set up the devices in rooms that have Ethernet jacks, and then plug them directly into the Ethernet jacks.

### Set up a separate modem to attach to a router

If you purchased a separate modem and router, follow these instructions:

1. Plug the modem into an electrical outlet.
2. Plug one end of a phone cord or cable into the modem and the other end into the wall jack. (DSL users shouldn't use a DSL filter on the phone line.)
3. Plug one end of an Ethernet cable into the modem and the other end into the wide area network (WAN) port on the router.
4. Plug the router into an electrical outlet.
5. Plug one end of an Ethernet cable into the local area network (LAN) port on the router and the other end into the networking port on the device that you want to connect to the Internet.
6. Start or restart the device.

### Connect the modem to the Internet

Follow the instructions to connect the modem to the Internet.

1. Click **Start**.
2. Click **Control Panel**.
3. Click **Network and Internet**.
4. Click **Network and Sharing Center**.
5. Click **Set up a connection or network**.
6. Click **Connect to the Internet**.
7. Follow the instructions in the wizard.

### Set up a firewall

A firewall is hardware or software that helps control the spread of malicious software on your network and helps to protect your devices when you use the Internet.

Don't turn off Windows Firewall unless you have another firewall turned on. Turning off Windows Firewall might make your device and network vulnerable to damage from hackers.

To set up a firewall, follow the instructions:

1. Click **Start**.
2. Click **Control Panel**.
3. Type firewall in the **Search** box.
4. Click **Windows Firewall**.
5. In the left pane, click **Turn Windows Firewall on or off**.
6. Tap or click **Turn on Windows Firewall** under each type of network that you want to help protect, and then tap or click **OK**.

   > [!Note]
   > You might be asked for an administrator password or to confirm your choice.

#### Enable file and printer sharing with a firewall

Windows Firewall automatically opens the correct ports for file and printer sharing when you share content or turn on network discovery. If you're using another firewall, you must open these ports yourself so that your device can find other devices that have files or printers that you want to share.  

To find other devices running Windows 8, Windows 7, or Windows Vista, open these ports:

- UDP 3702
- UDP 5355
- TCP 5357
- TCP 5358

To find other devices running earlier versions of Windows, and to use file and printer sharing on any version of Windows, open these ports:

- UDP 137
- UDP 138
- TCP 139
- TCP 445
- UDP 5355

To find network devices, open these ports:

- UDP 1900
- TCP 2869
- UDP 3702
- UDP 5355
- TCP 5357
- TCP 5358

To make HomeGroup work between devices running Windows 7, open these ports:

- UDP 137
- UDP 138
- TCP 139
- T CP 445
- UDP 1900
- TCP 2869
- UDP 3540
- TCP 3587
- UDP 3702
- UDP 5355
- TCP 5357
- TCP 5358

### Connect devices to the network

If the devices running Windows Vista are connected to either a hub or a switch using a cable, then they're already on the network, and ready to use.

If you had to change the workgroup name, you're prompted to restart your device. Restart the device, and then continue with the following steps.

1. Click **Start**.
2. Click **My Network Places**.
3. In the left pane, under **Network Tasks**, click **View workgroup computers**.
4. Select the device from the list that appears and click **Connect**.

### Connect the cables

To begin, run an Ethernet cable from the router or hub to each device that you want to connect to the network.

#### Install the network adapters

Windows can automatically detect and install the correct network adapter software for you. To check whether your device has a network adapter, follow the instructions.

1. Right-click **Computer**.
2. Click **Properties**.
3. Click **Device Manager** on the left pane.
4. To see a list of installed network adapters, expand Network adapter(s).

#### Set up your router

If your router displays the Windows logo or the phrase Compatible with Windows, you can set it up automatically using the latest version of Windows Connect Now (WCN). Otherwise, most routers come with instructions and a setup CD that will help you set them up.

If you have a combined modem and router, follow these instructions:

1. Plug the modem into an electrical outlet.
2. Plug one end of a phone cord or cable into the wide area network (WAN) port of the device and then plug the other end into the wall jack. The WAN port should be labeled "WAN." (DSL users shouldn't use a DSL filter on the phone line.)
3. Plug one end of an Ethernet cable into the local area network (LAN) port on the device and the other end into the networking port of the device that you want to connect to the Internet. The LAN port should be labeled "LAN."
4. Start (or restart) the device.

#### Connect your router to the Internet

To connect your router to the Internet, follow the instructions.

1. Click **Start**.
2. Click **Control Panel**.
3. Click **Network and Internet**.
4. Click **Network and Sharing Center**.
5. Click **Set up a connection or network**.
6. Click **Connect to the Internet**.
7. Follow the instructions in the wizard.

If your home or office is wired for Ethernet, set up the devices in rooms that have Ethernet jacks, and then plug them directly into the Ethernet jacks.

### Set up a separate modem to attach to a router

If you purchased a separate modem and router, follow these instructions:

1. Plug the modem into an electrical outlet.
2. Plug one end of a phone cord or cable into the modem and the other end into the wall jack. (DSL users shouldn't use a DSL filter on the phone line.)
3. Plug one end of an Ethernet cable into the modem and the other end into the wide area network (WAN) port on the router.
4. Plug the router into an electrical outlet.
5. Plug one end of an Ethernet cable into the local area network (LAN) port on the router and the other end into the networking port on the device that you want to connect to the Internet.
6. Start or restart the device.

### Connect the modem to the Internet

Follow the instructions to connect the modem to the Internet.

1. Click **Start**.
2. Click **Control Panel**.
3. Click **Network and Internet**.
4. Click **Network and Sharing Center**.
5. Click **Set up a connection or network**.
6. Click **Connect to the Internet**.
7. Follow the instructions in the wizard.

### Set up a firewall

A firewall is hardware or software that helps control the spread of malicious software on your network and helps to protect your devices when you use the Internet.

Don't turn off Windows Firewall unless you have another firewall turned on. Turning off Windows Firewall might make your device and network vulnerable to damage from hackers.

To set up a firewall, follow the instructions:

1. Click **Start**.
2. Click **Control Panel**.
3. Click **Security**.
4. Click **Windows Firewall**.
5. Click **Turn Windows Firewall on or off**.
6. Click **On** (recommended), and then click **OK**.
   > [!Note]
   > You might be asked for an administrator password or to confirm your choice.

#### Enable file and printer sharing with a firewall

Windows Firewall automatically opens the correct ports for file and printer sharing when you share content or turn on network discovery. If you're using another firewall, you must open these ports yourself so that your device can find other devices that have files or printers that you want to share.  

To find other devices running Windows 8, Windows 7, or Windows Vista, open these ports:

- UDP 3702
- UDP 5355
- TCP 5357
- TCP 5358

To find other devices running earlier versions of Windows, and to use file and printer sharing on any version of Windows, open these ports:

- UDP 137
- UDP 138
- TCP 139
- TCP 445
- UDP 5355

To find network devices, open these ports:

- UDP 1900
- TCP 2869
- UDP 3702
- UDP 5355
- TCP 5357
- TCP 5358

### Connect devices to the network

If the devices running Windows Vista are connected to either a hub or a switch using a cable, then they're already on the network, and ready to use.

If you had to change the workgroup name, you're prompted to restart your device. Restart the device, and then continue with the following steps.

1. Click **Start**.
2. Click **My Network Places**.
3. In the left pane, under **Network Tasks**, click **View workgroup computers**.
4. Select the device from the list that appears and click **Connect**.

### Connect the cables

To begin, run an Ethernet cable from the router or hub to each device that you want to connect to the network.

#### Install the network adapters

Windows can automatically detect and install the correct network adapter software for you.

To check whether your device has a network adapter, follow the instructions.

1. Click **Start**.
2. Right-click **My Computer**.
3. Click **Properties**.
4. Under **Hardware** tab, click **Device Manager**.
5. To see a list of installed network adapters, expand Network adapter(s).

#### Set up your router

If your router displays the Windows logo or the phrase Compatible with Windows, you can set it up automatically using the latest version of Windows Connect Now (WCN). Otherwise, most routers come with instructions and a setup CD that will help you set them up.

If you have a combined modem and router, follow these instructions:

1. Plug the modem into an electrical outlet.
2. Plug one end of a phone cord or cable into the wide area network (WAN) port of the device and then plug the other end into the wall jack. The WAN port should be labeled "WAN." (DSL users shouldn't use a DSL filter on the phone line.)
3. Plug one end of an Ethernet cable into the local area network (LAN) port on the device and the other end into the networking port of the device that you want to connect to the Internet. The LAN port should be labeled "LAN."
4. Start (or restart) the device.

#### Connect your router to the Internet

To connect your router to the Internet, follow the instructions.

1. Click **Start**.
2. Click **Control Panel**.
3. Click **Network and Internet Connections**.
4. Click **Set up or change your Internet connection**.
5. Click **Setup**.
6. Follow the instructions in the **New Connection Wizard** to connect to the Internet.

#### Building already wired for Ethernet

If your home or office is wired for Ethernet, set up the devices in rooms that have Ethernet jacks, and then plug them directly into the Ethernet jacks.

### Set up a separate modem to attach to a router

If you purchased a separate modem and router, follow these instructions:

1. Plug the modem into an electrical outlet.
2. Plug one end of a phone cord or cable into the modem and the other end into the wall jack. (DSL users shouldn't use a DSL filter on the phone line.)
3. Plug one end of an Ethernet cable into the modem and the other end into the wide area network (WAN) port on the router.
4. Plug the router into an electrical outlet.
5. Plug one end of an Ethernet cable into the local area network (LAN) port on the router and the other end into the networking port on the device that you want to connect to the Internet.
6. Start or restart the device.

### Connect the modem to the Internet

Follow the instructions to connect the modem to the Internet.

1. Click **Start**.
2. Click **Control Panel**.
3. Click **Network and Internet Connections**.
4. Click **Set up or change your Internet connection**.
5. Click **Setup**.
6. Follow the instructions in the **New Connection Wizard** to connect to the Internet.

### Set up a firewall

A firewall is hardware or software that helps control the spread of malicious software on your network and helps to protect your devices when you use the Internet.

Don't turn off Windows Firewall unless you have another firewall turned on. Turning off Windows Firewall might make your device and network vulnerable to damage from hackers.

To Set up a firewall, follow the instructions:

1. Click **Start**.
2. Click **Run**.
3. Type **Firewall.cpl**, and click **OK**.
4. On the General tab, click **On** (recommended).
5. Click **OK**.

#### Enable file and printer sharing with a firewall

Windows Firewall automatically opens the correct ports for file and printer sharing when you share content or turn on network discovery. If you're using another firewall, you must open these ports yourself so that your device can find other devices that have files or printers that you want to share.

 To find other devices running Windows XP or earlier versions of Windows, and to use file and printer sharing on any version of Windows, open these ports:

- UDP 137
- UDP 138
- TCP 139
- TCP 445
- UDP 5355

To find network devices, open these ports:

- UDP 1900
- TCP 2869
- UDP 3702
- UDP 5355
- TCP 5357
- TCP 5358

### Connect devices to the network

If you have devices running Windows XP, you may need to do a little more work to add those devices.

To add a wired (Ethernet) device that is running Windows XP

1. Plug the device into a hub, switch, or router and turn it on. If your home has Ethernet wiring and you have a jack in the room where the device is, you can plug the device into the Ethernet jack instead.
2. Log on to the device as an administrator.
3. Click **Start**, right-click **My Computer**, and then click **Properties**.
4. Click the **Computer Name** tab and then click **Change**.
5. If the workgroup name isn't WORKGROUP, change the name to WORKGROUP and click **OK**.

If you had to change the workgroup name, you're prompted to restart your device. Restart the device, and then continue with the following steps.

1. Click **Start**.
2. Click **My Network Places**.
3. In the left pane, under **Network Tasks**, click **View workgroup computers**.
4. Select the device from the list that appears and click **Connect**.

## Install a wireless network

Now that you've decided to invest in a wireless network for your business, you have to select a network standard and set up your network. Wireless networks (WLANs) don't require much in the way of network infrastructure. Many small business owners select wireless networking because it's flexible, inexpensive, and easy to install and maintain. You can use a wireless network to share Internet access, files, printers, file servers, and other devices in your office. Once you have the network set up, you can enable sharing, set permissions, and add printers and other devices.

To begin, follow the procedure for the version of Windows running on the device that you want to connect to your network. All of your devices don't need to run the same version of Windows to be a part of your business network.

### Select a wireless network standard

The most common wireless network standards are 802.11b, 802.11g, 802.11a, and 802.11n. Prices vary for each standard as do data transfer rates. Typically the faster the data transfer rate, the more you pay. In general, data transfer rates for each standard work as follows:

1. 802.11b ―11 Megabytes per second (Mbps)
2. 802.11g ― 54 Mbps
3. 802.11a ― 54 Mbps
4. 802.11n ― 300-600 Mbps

> [!Note]
> The transfer times listed are under ideal conditions. They aren't necessarily achievable under typical circumstances because of differences in hardware, web servers, network traffic, and other factors.

### Set up your wireless router

A wireless router sends information between your network and the Internet by using radio signals instead of wires. You should use a router that supports faster wireless signals, such as 802.11g or 802.11n.

For the best results, put your wireless router, wireless modem router (a DSL or cable modem with a built-in wireless router), or wireless access point (WAP) in a central location in your office. If your router is on the first floor and your devices are on the second floor, put the router high on a shelf on the first floor.

> [!Note]
> Metal objects, walls, and floors can interfere with your router's wireless signals.

### Set up your modem and Internet connection

If your ISP didn't set up your modem, follow the instructions that came with your modem to connect it to your device and the Internet. If you're using a Digital Subscriber Line (DSL), connect your modem to a telephone jack. If you're using cable, connect your modem to a cable jack.

#### Set up a modem and router

To set up two pieces of hardware, a modem and a router, follow these instructions:

1. Plug the modem into an electrical outlet.
2. Plug one end of a phone cord or cable into the modem and the other end into the wall jack. (DSL users shouldn't use a DSL filter on the phone line.)
3. Plug one end of an Ethernet cable into the modem and the other end into the wide area network (WAN) port on the router.
4. Plug the router into an electrical outlet.
5. Start (or restart) the device.
6. Now follow the instructions in the section below to complete the modem and router setup.  
   > [!Note]
   > Protect your router by changing the default user name and password. Most router manufacturers have a default user name and password on the router in addition to a default network name. Someone could use this information to access your router without your knowledge. Check the information that was included with your device for instructions.

#### Set up a combined modem and router

If you have a combined modem and router, follow these instructions:

1. Plug the modem into an electrical outlet.
2. Plug one end of a phone cord or cable into the wide area network (WAN) port of the device and the other into the wall jack. The WAN port should be labeled WAN. (DSL users shouldn't use a DSL filter on the phone line.)
3. Once completed, restart your device.

#### Complete the modem and router setup

To complete the modem and router setup, follow the instructions to complete set up.

1. Swipe in from the right edge of the screen (if using a mouse, point to the upper-right corner of the screen and move the mouse pointer down).
2. Tap or click **Search**.
3. Type _network and sharing center_ in the Search box.
4. Tap or click **Settings**.
5. Tap or click **Network and Sharing Center** on the left side of your screen.
6. Tap or click **Set up a new connection or network**.
7. Tap or click **Connect to the Internet**.
8. Tap or click **Next**.

### A network adapter connects your device to a network

To connect to a wireless network, your device must have a wireless network adapter. Make sure that you get the same type of adapters as your wireless router. The type of adapter is marked on the package with a letter, such as G or A.

To check whether your device has a wireless network adapter, follow the instructions.

1. Swipe in from the right edge of the screen (if using a mouse, point to the upper-right corner of the screen and move the mouse pointer down).
2. Tap or click **Search**.
3. Type **Control panel** in the Search box.
4. Tap or click **Apps**.
5. Tap or click **Control Panel** on the left side of your screen.
6. Type Device Manager in the Search Control Panel box.
7. Tap or click **Device Manager**.
8. Double-tap or double-click **Network adapters**.
9. Look for a network adapter that includes "wireless" in the name.
   > [!Note]
   > You might be asked for an administrator password or to confirm your choice.

### Set up a security key for your network

Every wireless network has a network security key to help protect it from unauthorized access.

To set up a network security key, follow the instructions.

1. Swipe in from the right edge of the screen (if using a mouse, point to the upper-right corner of the screen and move the mouse pointer down).
2. Tap or click **Settings**.
3. Tap or click **Network** icon.
4. Select your wireless network from the list that appears and tap or click **Connect**.  
   > [!Note]
   > Whenever possible, you should connect to a security-enabled wireless network. If you do connect to a network that's not secure, someone with the right tools can see everything that you do, including the websites you visit, the documents you work on, and the user names and passwords that you use.
5. Select one of the following options:
   - If your router supports Windows Connect Now (WCN) or Wi-Fi Protected Setup (WPS), and there's a push button on the router, push the button and wait a few seconds while the router automatically adds the device to the network. In this instance, you don't need to enter a security key or passphrase.
   - Enter the security key or passphrase if prompted and tap or click **OK**.

### Set up a firewall

A firewall is hardware or software that helps protect your device from hackers or malicious software.

Running a firewall on each device on your network can help control the spread of malicious software on your network and help protect your devices when you use the Internet.

Don't turn off Windows Firewall unless you have another firewall turned on. Turning off Windows Firewall might make your device and network vulnerable to damage from hackers.

To set up a firewall, follow the instructions:

1. Swipe in from the right edge of the screen (if using a mouse, point to the upper-right corner of the screen and move the mouse pointer down).
2. Tap or click **Search**.
3. Type _firewall_ in the Search box.
4. Tap or click **Settings**.
5. Tap or click **Windows Firewall** on the left side of your screen.
6. In the left pane, tap or click **Turn Windows Firewall on or off**.
7. Tap or click **Turn on Windows Firewall** under each type of network that you want to help protect, and then tap or click **OK**.
   > [!Note]
   > You might be asked for an administrator password or to confirm your choice.

### Enable file and printer sharing with a firewall

Windows Firewall automatically opens the correct ports for file and printer sharing when you share content or turn on network discovery. If you're using another firewall, you must open these ports yourself so that your device can find other devices that have files or printers that you want to share.

To find other devices running Windows 8, Windows 7, or Windows Vista, open these ports:

- UDP 3702
- UDP 5355
- TCP 5357
- TCP 5358

To find other devices running earlier versions of Windows, and to use file and printer sharing on any version of Windows, open these ports:

- UDP 137
- UDP 138
- TCP 139
- TCP 445
- UDP 5355

To find network devices, open these ports:

- UDP 1900
- TCP 2869
- UDP 3702
- UDP 5355
- TCP 5357
- TCP 5358

### Save your wireless network settings to a USB flash drive

Swipe in from the right edge of the screen (if using a mouse, point to the upper-right corner of the screen and move the mouse pointer down).

1. Swipe in from the right edge of the screen (if using a mouse, point to the upper-right corner of the screen and move the mouse pointer down).
2. Tap or click **Settings**.
3. Tap or click **Network** icon.
4. Right-click the network and then click **View connection properties**.
5. Under the **Connection** tab, click **Copy this network profile to a USB flash drive**.
6. Select the USB device and click **Next**.
7. Follow the instructions in the wizard and then click **Close**.

### Use a USB flash drive to connect to the network

If you want to use a USB flash drive to copy network settings to your device instead of typing a security key or passphrase, follow these steps:

1. Log on to the device that you want to add to the network.
2. Plug the USB flash drive that contains the network settings into a USB port on the device.
For a device running Windows 8.1 and Windows 8, tap or click the notification about the USB flash drive when it displays. In the USB flash drive dialog box, tap or click **Wireless Network Setup Wizard**.

### Connect devices to the network

To connect a device to your network, follow the instructions.

1. Swipe in from the right edge of the screen (if using a mouse, point to the upper-right corner of the screen and move the mouse pointer down).
2. Tap or click **Settings**.
3. Tap or click **Network** icon.
4. Select the wireless network from the list that appears and tap or click **Connect**.
5. Enter the security key if prompted and tap or click **OK**.

### Select a wireless network standard

The most common wireless network standards are 802.11b, 802.11g, 802.11a, and 802.11n. Prices vary for each standard as do data transfer rates. Typically the faster the data transfer rate, the more you pay. In general, data transfer rates for each standard work as follows:

1. 802.11b ―11 Megabytes per second (Mbps)
2. 802.11g ― 54 Mbps
3. 802.11a ― 54 Mbps
4. 802.11n ― 300-600 Mbps

> [!Note]
> The transfer times listed are under ideal conditions. They aren't necessarily achievable under typical circumstances because of differences in hardware, web servers, network traffic, and other factors.

### Set up your wireless router

A wireless router sends information between your network and the Internet by using radio signals instead of wires. You should use a router that supports faster wireless signals, such as 802.11g or 802.11n.  

For the best results, put your wireless router, wireless modem router (a DSL or cable modem with a built-in wireless router), or wireless access point (WAP) in a central location in your office. If your router is on the first floor and your devices are on the second floor, put the router high on a shelf on the first floor.

> [!Note]
> Metal objects, walls, and floors can interfere with your router's wireless signals.

### Set up your modem and Internet connection

If your ISP didn't set up your modem, follow the instructions that came with your modem to connect it to your device and the Internet. If you're using a Digital Subscriber Line (DSL), connect your modem to a telephone jack. If you're using cable, connect your modem to a cable jack.

#### Set up a modem and router

To set up two pieces of hardware, a modem and a router, follow these instructions:

1. Plug the modem into an electrical outlet.
2. Plug one end of a phone cord or cable into the modem and the other end into the wall jack. (DSL users shouldn't use a DSL filter on the phone line.)
3. Plug one end of an Ethernet cable into the modem and the other end into the wide area network (WAN) port on the router.
4. Plug the router into an electrical outlet.
5. Start (or restart) the device.
6. Now follow the instructions in the section below to complete the modem and router setup.
   > [!Note]
   > Protect your router by changing the default user name and password. Most router manufacturers have a default user name and password on the router in addition to a default network name. Someone could use this information to access your router without your knowledge. Check the information that was included with your device for instructions.

#### Set up a combined modem and router

If you have a combined modem and router, follow these instructions:

1. Plug the modem into an electrical outlet.
2. Plug one end of a phone cord or cable into the wide area network (WAN) port of the device and the other into the wall jack. The WAN port should be labeled **WAN**. (DSL users shouldn't use a DSL filter on the phone line.)
3. Once completed, restart your device.

#### Complete the modem and router setup

To complete the modem and router setup, follow the instructions:

1. Click **Start**.
2. Click **Control Panel**.
3. Click **Network and Internet**.
4. Click **Network and Sharing Center**.
5. Click **Set up a connection or network**.
6. Click **Connect to the Internet**.
7. Follow the instructions in the wizard.

### Set up your wireless network adapters

To check whether your device has a wireless network adapter, follow the instructions.

1. Click **Start**.
2. Type network in the Search box.
3. Click **Device Manager**.
4. Next to **Network adapters**, click the plus sign (+).
5. Look for a network adapter that includes "wireless" in the name.
   > [!Note]
   > You might be asked for an administrator password or to confirm your choice.

### Set up a firewall

A firewall is hardware or software that helps control the spread of malicious software on your network and helps to protect your devices when you use the Internet.

Don't turn off Windows Firewall unless you have another firewall turned on. Turning off Windows Firewall might make your device and network vulnerable to damage from hackers.

To set up a firewall, follow the instructions:

1. Click **Start**.
2. Click **Control Panel**.
3. Type firewall in the Search box.
4. Click **Windows Firewall**.
5. In the left pane, click **Turn Windows Firewall on or off**.
6. Tap or click **Turn on Windows Firewall** under each type of network that you want to help protect and then tap or click **OK**.
   > [!Note]
   > You might be asked for an administrator password or to confirm your choice.

### Enable file and printer sharing with a firewall

Windows Firewall automatically opens the correct ports for file and printer sharing when you share content or turn on network discovery. If you're using another firewall, you must open these ports yourself so that your device can find other devices that have files or printers that you want to share.  

To find other devices running Windows 8, Windows 7, or Windows Vista, open these ports:

- UDP 3702
- UDP 5355
- TCP 5357
- TCP 5358

To find other devices running earlier versions of Windows, and to use file and printer sharing on any version of Windows, open these ports:

- UDP 137
- UDP 138
- TCP 139
- TCP 445
- UDP 5355

To find network devices, open these ports:

- UDP 1900
- TCP 2869
- UDP 3702
- UDP 5355
- TCP 5357
- TCP 5358

To make HomeGroup work between devices running Windows 7, open these ports:

- UDP 137
- UDP 138
- TCP 139
- TCP 445
- UDP 1900
- TCP 2869
- UDP 3540
- TCP 3587
- UDP 3702
- UDP 5355
- TCP 5357
- TCP 5358

### Save your wireless network settings to a USB flash drive

1. Right-click the **Network** icon and click **Open Network and sharing Center**.
2. Click **Manage wireless networks**.
3. Right-click the network and click **Properties**.
4. Click **Copy this network profile to a USB flash drive**.
5. Select the USB device and click **Next**.
6. Follow the instructions in the wizard and then click **Close**.

### Use a USB flash drive to connect to the network

If you want to use a USB flash drive to copy network settings to your device instead of typing a security key or passphrase, follow these steps:

1. Log on to the device that you want to add to the network.
2. Plug the USB flash drive that contains the network settings into a USB port on the device.
For a device running Windows 7, in the **AutoPlay** dialog box, click **Wireless Network Setup Wizard**.

### Connect devices to the network

To connect a device to your network, follow the instructions.

1. Click **Start**.
2. Click **Control Panel**.
3. Click **Network and Internet**.
4. Click **Network and Sharing Center**.
5. Click **Connect to a network**.
6. Select the wireless network from the list that appears and click **Connect**.
7. Enter the security key if prompted and click **OK**.

### Select a wireless network standard

The most common wireless network standards are 802.11b, 802.11g, 802.11a, and 802.11n. Prices vary for each standard as do data transfer rates. Typically the faster the data transfer rate, the more you pay. In general, data transfer rates for each standard work as follows:

1. 802.11b ―11 Megabytes per second (Mbps)
2. 802.11g ― 54 Mbps
3. 802.11a ― 54 Mbps
4. 802.11n ― 300-600 Mbps
   > [!Note]
   > The transfer times listed are under ideal conditions. They aren't necessarily achievable under typical circumstances because of differences in hardware, web servers, network traffic, and other factors.

### Set up your wireless router

A wireless router sends information between your network and the Internet by using radio signals instead of wires. You should use a router that supports faster wireless signals, such as 802.11g or 802.11n.  

For the best results, put your wireless router, wireless modem router (a DSL or cable modem with a built-in wireless router), or wireless access point (WAP) in a central location in your office. If your router is on the first floor and your devices are on the second floor, put the router high on a shelf on the first floor.

> [!Note]
> Metal objects, walls, and floors can interfere with your router's wireless signals.

### Set up your modem and Internet connection

If your ISP didn't set up your modem, follow the instructions that came with your modem to connect it to your device and the Internet. If you're using a Digital Subscriber Line (DSL), connect your modem to a telephone jack. If you're using cable, connect your modem to a cable jack.

#### Set up a modem and router

To set up two pieces of hardware, a modem and a router, follow these instructions:

1. Plug the modem into an electrical outlet.
2. Plug one end of a phone cord or cable into the modem and the other end into the wall jack. (DSL users shouldn't use a DSL filter on the phone line.)
3. Plug one end of an Ethernet cable into the modem and the other end into the wide area network (WAN) port on the router.
4. Plug the router into an electrical outlet.
5. Start (or restart) the device.
6. Now follow the instructions in the section below to complete the modem and router setup.
   > [!Note]
   > Protect your router by changing the default user name and password. Most router manufacturers have a default user name and password on the router in addition to a default network name. Someone could use this information to access your router without your knowledge. Check the information that was included with your device for instructions.

#### Set up a combined modem and router

If you have a combined modem and router, follow these instructions:

1. Plug the modem into an electrical outlet.
2. Plug one end of a phone cord or cable into the wide area network (WAN) port of the device and the other into the wall jack. The WAN port should be labeled WAN. (DSL users shouldn't use a DSL filter on the phone line.)
3. Once completed, restart your device.

#### Complete the modem and router setup

To complete the modem and router setup, follow the instructions to complete set up.

1. Click **Start**.
2. Click **Control Panel**.
3. Click **Network and Internet**.
4. Click **Network and Sharing Center**.
5. Click **Set up a connection or network**.
6. Click **Connect to the Internet**.
7. Follow the instructions in the wizard.

### Set up your wireless network adapters

A network adapter connects your device to a network. To connect to a wireless network, your device must have a wireless network adapter. Make sure that you get the same type of adapters as your wireless router. The type of adapter is marked on the package with a letter, such as G or A.

To check whether your device has a wireless network adapter, follow the instructions.

1. Click **Start**.
2. Type _network_ in the Search box.
3. Click **Device Manager**.
4. Next to **Network adapters**, click the plus sign (+).
5. Look for a network adapter that includes "wireless" in the name.
   > [!Note]
   > You might be asked for an administrator password or to confirm your choice.

### Set up a security key for your network

Every wireless network has a network security key to help protect it from unauthorized access.

To set up a network security key, follow the instructions.

1. Click **Start**.
2. Click **Control Panel**.
3. Click **Network and Internet**.
4. Click **Network and Sharing Center**.
5. Click **Set up a connection or network**.
6. Click **Set up a new network**.
7. Click **Next**.
The wizard will walk you through the process of creating a network name and security key. If your router supports it, the wizard will default to Wi-Fi Protected Access (WPA or WPA2) security. We recommend that you use WPA2, if possible. WPA2 offers better security than WPA or Wired Equivalent Privacy (WEP) security. With WPA2 or WPA, you can also use a passphrase.

Make sure that you write the security key and keep it in a safe place. If you have a USB flash drive, you can also save your security key to the flash drive by following the instructions in the wizard.

### Set up a firewall

A firewall is hardware or software that helps control the spread of malicious software on your network and helps to protect your devices when you use the Internet.

Don't turn off Windows Firewall unless you have another firewall turned on. Turning off Windows Firewall might make your device and network vulnerable to damage from hackers.

To set up a firewall, follow the instructions:

1. Click **Start**.
2. Click **Control Panel**.
3. Click **Security**.
4. Click **Windows Firewall**.
5. Click **Turn Windows Firewall on or off**.
6. Click **On** (recommended), and then click **OK**.
   > [!Note]
   > You might be asked for an administrator password or to confirm your choice.

### Enable file and printer sharing with a firewall

Windows Firewall automatically opens the correct ports for file and printer sharing when you share content or turn on network discovery. If you're using another firewall, you must open these ports yourself so that your device can find other devices that have files or printers that you want to share.

To find other devices running Windows 8, Windows 7, or Windows Vista, open these ports:

- UDP 3702
- UDP 5355
- TCP 5357
- TCP 5358

To find other devices running earlier versions of Windows, and to use file and printer sharing on any version of Windows, open these ports:

- UDP 137
- UDP 138
- TCP 139
- TCP 445
- UDP 5355

To find network devices, open these ports:

- UDP 1900
- TCP 2869
- UDP 3702
- UDP 5355
- TCP 5357
- TCP 5358

### Save your wireless network settings to a USB flash drive

1. Right-click the **Network** icon and click **Open Network and sharing Center**.
2. Click **Manage wireless networks**.
3. Right-click the network and click **Properties**.
4. Click **Copy this network profile to a USB flash drive**.
5. Select the USB device and click **Next**.
6. Follow the instructions in the wizard and then click **Close**.

### Use a USB flash drive to connect to the network

If you want to use a USB flash drive to copy network settings to your device instead of typing a security key or passphrase, follow these steps:

1. Log on to the device that you want to add to the network.
2. Plug the USB flash drive that contains the network settings into a USB port on the device.
For a device running Windows Vista, in the **AutoPlay** dialog box, click **Wireless Network Setup Wizard**.

### Connect devices to the network

To connect a device to your network, follow the instructions.

1. Click **Start**.
2. Click **Control Panel**.
3. Click **Network and Internet**.
4. Click **Network and Sharing Center**.
5. Click **Connect to a network**.
6. Select the wireless network from the list that appears and click **Connect**.
7. Enter the security key if prompted and click **OK**.
   > [!Note]
   > You can enter in the key or insert a USB flash drive that contains the security key into a USB port on the device.

### Select a wireless network standard

The most common wireless network standards are 802.11b, 802.11g, 802.11a, and 802.11n. Prices vary for each standard as do data transfer rates. Typically the faster the data transfer rate, the more you pay. In general, data transfer rates for each standard work as follows:

1. 802.11b ―11 Megabytes per second (Mbps)
2. 802.11g ― 54 Mbps
3. 802.11a ― 54 Mbps
4. 802.11n ― 300-600 Mbps
   > [!Note]
   > The transfer times listed are under ideal conditions. They aren't necessarily achievable under typical circumstances because of differences in hardware, web servers, network traffic, and other factors.

### Set up your wireless router

A wireless router sends information between your network and the Internet by using radio signals instead of wires. You should use a router that supports faster wireless signals, such as 802.11g or 802.11n.  

For the best results, put your wireless router, wireless modem router (a DSL or cable modem with a built-in wireless router), or wireless access point (WAP) in a central location in your office. If your router is on the first floor and your devices are on the second floor, put the router high on a shelf on the first floor.

> [!Note]
> Metal objects, walls, and floors can interfere with your router's wireless signals.

### Set up your modem and Internet connection

If your ISP didn't set up your modem, follow the instructions that came with your modem to connect it to your device and the Internet. If you're using a Digital Subscriber Line (DSL), connect your modem to a telephone jack. If you're using cable, connect your modem to a cable jack.

#### Set up a modem and router

To set up two pieces of hardware, a modem and a router, follow these instructions:

1. Plug the modem into an electrical outlet.
2. Plug one end of a phone cord or cable into the modem and the other end into the wall jack. (DSL users shouldn't use a DSL filter on the phone line.)
3. Plug one end of an Ethernet cable into the modem and the other end into the wide area network (WAN) port on the router.
4. Plug the router into an electrical outlet.
5. Start (or restart) the device.
6. Now follow the instructions in the section below to complete the modem and router setup.
   > [!Note]
   > Protect your router by changing the default user name and password. Most router manufacturers have a default user name and password on the router in addition to a default network name. Someone could use this information to access your router without your knowledge. Check the information that was included with your device for instructions.

#### Set up a combined modem and router

If you have a combined modem and router, follow these instructions:

1. Plug the modem into an electrical outlet.
2. Plug one end of a phone cord or cable into the wide area network (WAN) port of the device and the other into the wall jack. The WAN port should be labeled **WAN**. (DSL users shouldn't use a DSL filter on the phone line.)
3. Once completed, restart your device.

#### Complete the modem and router setup

To complete the modem and router setup,  follow the instructions:

1. Click **Start**.
2. Click **Control Panel**.
3. Click **Network and Internet Connections**  
4. Click **Set up or change your Internet connection** ****.
5. Click **Set up**.
6. Follow the instructions in the **New Connection Wizard** to connect to the Internet.
7. Follow the instructions in the wizard.

### Set up your wireless network adapters

A network adapter connects your device to a network. To connect to a wireless network, your device must have a wireless network adapter. Make sure that you get the same type of adapters as your wireless router. The type of adapter is marked on the package with a letter, such as G or A.

To check whether your device has a wireless network adapter, follow the instructions.

1. Click **Start**, right-click **My Computer**, and then click **Properties**.
2. Under the **Hardware** tab, click **Device Manager**.
3. Next to **Network adapters**, click the plus sign (+).
4. Look for a network adapter that includes "wireless" in the name.
   > [!Note]
   > You might be asked for an administrator password or to confirm your choice.

### Set up a security key for your network

Every wireless network has a network security key to help protect it from unauthorized access.

To set up a network security key, follow the instructions.

1. Click **Next**.
2. Click **Start**.
3. Click **All Programs**.
4. Click **Accessories**.
5. Click **Communications**.
6. Click **Wireless Network Setup Wizard**.
7. In the open window, click **Next**.
8. Check on **Set up a new wireless network** and click **Next**.
9. Input the **Network name (SSID)**, check on **Manually assign a network key**, and click **Next**.
10. Input **Network key** and **Confirm network key** and click **Next**.
11. Check on **Set up a network manually** and click **Next**.
12. Click **Finish**.

Make sure that you write the security key and keep it in a safe place. If you have a USB flash drive, you can also save your security key to the flash drive by following the instructions in the wizard.

### Set up a firewall

A firewall is hardware or software that helps control the spread of malicious software on your network and helps to protect your devices when you use the Internet.
Don't turn off Windows Firewall unless you have another firewall turned on. Turning off Windows Firewall might make your device and network vulnerable to damage from hackers.
To set up a firewall, follow the instructions:

1. Click **Start**.
2. Click **Run**.
3. Type **Firewall.cpl**, and click **OK**.
4. On the General tab, click **On** (recommended).
5. Click **OK**.

### Enable file and printer sharing with a firewall

Windows Firewall automatically opens the correct ports for file and printer sharing when you share content or turn on network discovery. If you're using another firewall, you must open these ports yourself so that your device can find other devices that have files or printers that you want to share.  

To find other devices running Windows 8, Windows 7, or Windows Vista, open these ports:

- UDP 3702
- UDP 5355
- TCP 5357
- TCP 5358

 To find other devices running earlier versions of Windows, and to use file and printer sharing on any version of Windows, open these ports:

- UDP 137
- UDP 138
- TCP 139
- TCP 445
- UDP 5355

 To find network devices, open these ports:

- UDP 1900
- TCP 2869
- UDP 3702
- UDP 5355
- TCP 5357
- TCP 5358

### Save your wireless network settings to a USB flash drive

1. Right-click the **Network** icon and click **Open Network and sharing Center**.
2. Click **Manage wireless networks**.
3. Right-click the network and click **Properties**.
4. Click **Copy this network profile to a USB flash drive**.
5. Select the USB device and click **Next**.
6. Follow the instructions in the wizard and then click **Close**.

### Use a USB flash drive to connect to the network

If you want to use a USB flash drive to copy network settings to your device instead of typing a security key or passphrase, follow these steps:

1. Log on to the device that you want to add to the network.
2. Plug the USB flash drive that contains the network settings into a USB port on the device.
For a device running Windows XP, in the **USB flash drive** dialog box, click **Wireless Network Setup Wizard**.

### Connect devices to the network

To connect a device to your network, follow the instructions.

1. Click **Start**.
2. Click **Control Panel**.
3. Click **Network Connections**.
4. Right-click **Wireless Network Connection**, and click **View Available Wireless Networks**.
5. Select the wireless network you want to connect to, and then click **Connect**.
6. Follow the steps in the wizard to configure the network.

For details on troubleshooting network connections for Windows XP devices, see [Fix Wi-Fi connection issues in Windows](https://support.microsoft.com/help/10741/windows-fix-network-connection-issues).

## Create and manage workgroups

A workgroup is a group of devices that are connected to a home or small office network and share resources, such as printers and files. When you set up a network, Windows automatically creates a workgroup and gives it a name. In a workgroup:

- All devices are peers; no device has control over another device.
- Each device has a set of user accounts. To log on to any device in the workgroup, you must have an account set up on it.
- There are typically no more than 20 devices in a workgroup.
- A workgroup isn't protected by a password.
- All devices must be on the same local network or subnet. If your network includes devices running different versions of Windows, you should put all the devices in the same workgroup so that they can find one another and easily share files and printers.

### Find the default workgroup

To find a workgroup name, follow the instructions.

1. Swipe in from the right edge of the screen (if using a mouse, point to the upper-right corner of the screen and move the mouse pointer down).
2. Tap or click **Search**.
3. Type system in the Search box.
4. Tap or click **Settings**.
5. Tap or click **System** on the left side of your screen.
6. The workgroup name appears under **Device name, domain, and workgroup settings.**

### Join or create a workgroup

To join or create a workgroup, follow the instructions.

1. Swipe in from the right edge of the screen (if using a mouse, point to the upper-right corner of the screen and move the mouse pointer down).
2. Tap or click **Search**.
3. Type system in the _Search_ box.
4. Tap or click **Settings**.
5. Tap or click **System** on the left side of your screen.
6. Under **Device name, domain, and workgroup settings**, tap or click **Change settings**.
   > [!Note]
   > You might be asked for an administrator password or to confirm your choice.
7. In **System Properties**, tap or click the **Device Name** tab and then tap or click **Change**.
8. In the **Device Name/Domain Changes** dialog box, tap or click **Workgroup** and then take one of the following actions:  
   To join an existing workgroup, enter the name of the workgroup and tap or click **OK**.  
   To create a new workgroup, enter a name for the workgroup and tap or click **OK**.
9. If your device was a member of a domain before you joined the workgroup, it will be removed from the domain and your device account on that domain will be disabled.

### Change a workgroup name

If you want to change a workgroup name, follow these instructions:

1. Swipe in from the right edge of the screen (if using a mouse, point to the upper-right corner of the screen and move the mouse pointer down).
2. Tap or click **Search**.
3. Type _System_ in the Search box.
4. Tap or click **Settings**.
5. Tap or click **System** on the left side of your screen.
6. Under **Device name, domain, and workgroup settings**, tap or click **Change settings**.
   > [!Note]
   > You might be asked for an administrator password or to confirm your choice.
7. In **System Properties**, tap or click the **Device Name** tab and then tap or click **Change**.
8. In the **Device Name/Domain Changes** dialog box, tap or click **Workgroup** and type the name of the workgroup you want to use.
9. Click **OK**.
10. Restart your device.

### Find the default workgroup

To find a workgroup name, follow the instructions.

1. Click **Start**.
2. Right-click **My Device** and then click **Properties**.
3. The workgroup name appears under **Device name, domain, and workgroup settings**.

### Join or create a workgroup

To join or create a workgroup, follow the instructions.

1. Click **Start**.
2. Right-click **My Device** and then click **Properties**.
3. Under **Device name, domain, and workgroup settings**, tap or click **Change settings**.
   > [!Note]
   > You might be asked for an administrator password or to confirm your choice.*  
4. In **System** **Properties**, tap or click the **Device Name** tab and then tap or click **Change**.
5. In the **Device Name/Domain Changes** dialog box, under **Member of,** click **Workgroup** and select one of the following:  
   To join an existing workgroup, enter the name of the workgroup and tap or click **OK**.  
   To create a new workgroup, enter a name for the workgroup and tap or click **OK**.

### Change a workgroup name

If you want to change a workgroup name, follow these instructions:

1. Click **Start**.
2. Right-click **My Device** and then click **Properties**.
3. Under **Device name, domain, and workgroup settings**, tap or click **Change settings**.
4. In **System Properties**, tap or click the Device Name tab and then tap or click **Change**.
5. In the **Device Name/Domain Changes in Workgroup**, type the name of the workgroup you want to use.
6. Click **OK**.
7. Restart your device.

### Find the default workgroup

To find a workgroup name, follow the instructions.

1. Click **Start**.
2. Right-click **My Device** and then click **Properties**.
3. In **System Properties**, click the **Device Name** tab to see the workgroup name.
4. To change the workgroup name, click **Change**, type the new name in **Device name**, and click **OK**.

### Join or create a workgroup

To join or create a workgroup, follow the instructions.

1. Click **Start**.
2. Right-click **My Device** and then click **Properties**.
3. From **System Properties**, click **Change**.
4. From the **Device Name Changes** dialog box, within the **Device Name** text box, type a device name. Within the **Workgroup** text box, enter the name of the workgroup.
   > [!Note]
   > The Device Name for each device on the network must be unique, and the workgroup for all devices on the network must be the same.  
5. Click **OK**.
6. From the **Device Name Changes** dialog box, click **OK**.
7. Restart your device.

### Change a workgroup name

If you want to change a workgroup name, follow these instructions:

1. Click **Start**.
2. Right-click **My Device** and then click **Properties**.
3. From **System Properties**, click **Change**.
4. From the **Device Name Changes** dialog box, within the **Device Name** text box, type a device name. Within the **Workgroup** text box, enter the name of the workgroup.
   > [!Note]
   > The Device Name for each device on the network must be unique, and the workgroup for all devices on the network must be the same.  
5. Click **OK**.
6. From the **Device Name Changes** dialog box, click **OK**.
7. Restart your device.

## Install a hybrid network

A hybrid network refers to any computer network that contains two or more communications standards such Ethernet (802.3) and Wi-Fi (802.11 a/b/g). A hybrid network relies on special hybrid routers, hubs, and switches to connect both wired and wireless computers and other network-enabled devices. It enables the network to maximize the benefits of both these network types.

### Central access point

In a wired computer network, all devices are connected by physical cables to a central access point. This access point can be a router, hub, or a switch. The function of this access point is to share a network connection among several devices. All the devices are plugged into the access point using individual Ethernet (CAT 5) cables. If the devices need to share an Internet connection as well, then the access point is plugged into a broadband Internet modem, either cable or DSL.

In a standard wireless network, all networked devices communicate with a central wireless access point that broadcasts a signal. The devices themselves need to contain wireless modems or cards that conform with one or more Wi-Fi standards, either 802.11 a, b or g, to receive the signal. In this network configuration, all wireless devices can share files with each other over the network. If they also want to share an Internet connection, then the wireless access point is plugged into a broadband Internet modem.

A standard hybrid network uses a hybrid access point, a networking device that broadcasts a wireless signal and contains wired access ports. The most common hybrid access point is a hybrid router. The typical hybrid router broadcasts a Wi-Fi signal using 802.11 a, b, or g and contains four Ethernet ports for connecting wired devices. The hybrid router also has a port for connecting to a cable or DSL modem via an Ethernet cable.

When shopping for a hybrid router, you might not see the word "hybrid" anywhere. You're more likely to see the router advertised as a wireless or Wi-Fi router with Ethernet ports or "LAN ports".

After you determine which of your devices you want to connect with wires and which ones wirelessly, follow the procedures that are listed in **Install a wired network**, and **Install a wireless network** respectively to set up these parts of the hybrid network.

### Network configurations

There are several different possible network configurations for a hybrid network. The most basic configuration has all the wired devices plugged into the Ethernet ports of the hybrid router, and the wireless devices connected to the router wirelessly. Then the wireless devices can communicate with the wired devices via the hybrid router.

If you want to network more than four wired devices, you can string several routers together, both wired and wireless, in a daisy chain formation. You'll need enough wired routers to handle all of the wired devices (the number of devices divided by four). And you'll need enough wireless routers in the right physical locations to broadcast a Wi-Fi signal to every corner of the network. In this way, you can connect both computers and peripherals such as printers and fax machines and place them where it will easy to access them.

A hybrid wired/Wi-Fi network offers the best of both worlds: the speed and security of a wired network and the mobility and affordability of a wireless network. When you need the maximum Internet and file-sharing speed for your work, you can plug into the network with an Ethernet cable. If you need to show a streaming video to your colleague in the office hallway, you can access the network wirelessly. With the right planning, your small business can save money on CAT 5 cables and routers by maximizing the reach of the wireless network. And with the right encryption and password management in place, the wireless portion of the network can be as secure as the wired.

## Share files and folders on your network

After you set up your network, you might want to add more sharing options for your work and devices. Some of these options are set automatically, while others can be set manually.

Sharing options for your device include:

- Finding other devices on your home network and having other devices find yours
- Sharing files and folders
- Sharing public folders

### Sharing options that turn on automatically

In Windows 8.1 and Windows 8, when you connect to a network for the first time, you're given the option to turn on sharing and set the network location based upon your selection.

#### Sharing options that need to be turned on manually

If certain sharing options don't turn on automatically, you can activate them manually. These manual activation options include:

- Network discovery
- Network sharing (formerly location)
- Printer sharing
- File sharing

### Network discovery

Network discovery is a network setting that lets your device find other devices on the network and other devices find your device. Such functionality makes it easier to share files and printers.

There are three network discovery states:

- **On:** Enables your device to see other network devices and people on other network devices to see your device.
- **Off:** Prevents your device from seeing other network devices and prevents people on other network devices from seeing your device.
- **Custom:** Enables limited network discovery. For example, if you run network discovery without meeting all required firewall conditions, the network discovery state would be shown as Custom.

To manually activate network discovery, follow the instructions.

1. Swipe in from the right edge of the screen (if using a mouse, point to the upper-right corner of the screen and move the mouse pointer down).
2. Tap or click **Search**.
3. Type _network and sharing center_ in the Search box.
4. Tap or click **Settings**.
5. Tap or click **Network and Sharing Center** on the left side of your screen.
6. Tap or click **Change Advanced sharing settings** on the left pane.
7. Tap or click the chevron button to expand your current network profile.
8. Tap or click **Turn on network discovery** and then tap or click **Save changes**.
   > [!Note]
   > You might be asked for an administrator password or to confirm your choice.

### Network sharing (formerly network location)

Network sharing automatically adjusts security and other settings based on the type of network connected to your device. To check whether network sharing is enabled, follow the instructions.

The first time you connect to a network, you'll be asked if you want to turn on sharing between devices and connect to network devices such as printers. Your answer automatically sets the appropriate firewall and security settings for the type of network. You can turn sharing on or off at any time.

##### Turn sharing on or off in Windows 8.1 and Windows 8

1. Swipe in from the right edge of the screen (if using a mouse, point to the upper-right corner of the screen and move the mouse pointer down).
2. Tap or click **Settings**.
3. Tap or click the **Network** icon.
4. Press and hold or right-click the network name.
5. Tap or click **Turn sharing on or off**.
6. Select one of the following options:  
   **Yes, turn on sharing and connect to devices.** Use this option for home or small office networks or when you know and trust the people and devices on the network.  
   **No, don't turn on sharing or connect to devices.** Use this option for networks in public places (such as coffee shops or airports), or when you don't know or trust the people and devices on the network.

> [!Note]
>
> - Network sharing is only available for Wi-Fi, Ethernet, VPN (non-domain), and dial-up (non-domain) connections. It's unavailable for domain networks. On VPN or dial-up connections, you must connect to the network first, then press and hold or right-click the network name.
> - Turning on sharing changes your firewall settings to enable some communication, which can be a security risk. If you know you won't need to share files or printers, the safest choice is **No, don't sharing or connect to devices**.
> - Choosing **No, don't turn on sharing or connect to devices** blocks the following apps and services from working:
>   1. PlayTo
>   2. File sharing
>   3. Network discovery
>   4. Automatic setup of network devices

### Printer Sharing

To manually activate printer sharing, follow the instructions.

1. Swipe in from the right edge of the screen (if using a mouse, point to the upper-right corner of the screen and move the mouse pointer down).
2. Tap or click **Search**.
3. Type **control panel** in the Search box.
4. Tap or click **Apps**.
5. Tap or click **Control Panel** on the left side of your screen.
6. Type Network and Sharing Center in the Search Control Panel box.
7. Tap or click **Network and Sharing Center**.
8. Tap or click **Change advanced sharing settings** on the left pane.
9. Check on **Turn on file and printer sharing**.
10. Tap or click **Save changes**.
    > [!Note]
    > You might be asked for an administrator password or to confirm your choice.

### Share a file or folder

To share a file or folder, follow the instructions for the version of Windows installed on your device.

1. Press and hold or right-click a file or folder.
2. Tap or click **Share with**.
3. Select the people or groups that you want to share with. You can also assign permissions so that those people can or can't change the file or folder shared.

### Password-protected sharing

With password-protected sharing, people on your network can't access shared folders on other devices, including Public folders, unless they have a user name and password on the device for shared folders.

To activate password-protected sharing, follow the instructions.

1. Swipe in from the right edge of the screen (if using a mouse, point to the upper-right corner of the screen and move the mouse pointer down).
2. Tap or click **Search**.
3. Type **control panel** in the Search box.
4. Tap or click **Apps**.
5. Tap or click **Control Panel** on the left side of your screen.
6. Type _Network and Sharing Center_ in the search Control panel box.
7. Tap or click **Network and Sharing Center**.
8. Tap or click **Change advanced sharing settings** on the left pane.
9. Tap or click the arrow to expand your **All Network** profile.
10. Under **Password protected sharing**, tap or click **Turn on password protected sharing**.
11. Tap or click **Save changes**.
    > [!Note]
    > You might be asked for an administrator password or to confirm your choice.  

### Network map

The network map is a graphical view of the devices and devices on your network. The map shows how devices are connected and includes any problem areas. It can be helpful for troubleshooting.

Windows 8.1 and Windows 8 don't have the network map feature.

### Sharing options that turn on automatically

For Windows 7, certain sharing options turn on automatically. For example, when you change your network location to Home or Work, network discovery is automatically turned on. Similarly, file sharing turns on automatically the first time you try to share a file or folder.

### Sharing options that need to be turned on manually

If certain sharing options don't turn on automatically, you can activate them manually. These manual activation options include:

- Network discovery
- Network sharing (formerly location)
- Printer sharing
- File sharing

### Network discovery

Network discovery is a network setting that lets your device find other devices on the network and other devices find your device. Such functionality makes it easier to share files and printers.
There are three network discovery states:

- **On:** Enables your device to see other network devices and people on other network devices to see your device.
- **Off:** Prevents your device from seeing other network devices and prevents people on other network devices from seeing your device.
- **Custom:** Enables limited network discovery. For example, if you run network discovery without meeting all required firewall conditions, the network discovery state would be shown as Custom.

To manually activate network discovery, follow the instructions.

1. Click **Start**.
2. Click **Control Panel**.
3. Type network in the Search box.
4. Click **Network and Sharing Center** and then in the left pane, click **Change advanced sharing settings**.
5. Click the chevron button.  
to expand your current network profile.
6. Click **Turn on network discovery**.
7. Click **Save changes**.

### Network sharing (formerly network location)

Windows 7 automatically adjusts security and other settings based on the type of network connected to your device. If you skip this step, then the first time that you connect to the network, you'll be asked to select your network location. You can change this setting later.

#### Check the network location devices

There are four network locations you can use for Windows 7 devices:

- **Home.** The network offers some protection from the Internet (such as a router and firewall) and contains known or trusted devices. Network discovery is turned on automatically.

- **Work.** The network offers some protection from the Internet (such as a router and firewall) and contains known or trusted devices. Network discovery is turned on automatically. Most small business networks fall into this category.

- **Public.** The network is available for public use. Examples of public networks are public Internet access networks, such as those found in airports, libraries, and coffee shops. This network location helps keep your device from being seen by other devices around you and helps protect your device from malicious software on the Internet. You should also select this option if you're connected directly to the Internet without using a router or if you have a mobile broadband connection.
  > [!Note]
  > This is the safest setting, but you can't share printers or files.  

- **Domain.** The device is connected to a network that contains an Active Directory domain controller. A corporate network is one example of a domain network. This network location isn't available as an option. It must be set by the domain administrator.

For your small business network, make sure that the network location type is set to Home or Work. Here's how to check:

1. Click **Start**.
2. Click **Control Panel**.
3. Type _network_ in the Search box.
4. Click **Network and Sharing Center**.
5. In the left pane, click **Work network, Home network**, or **Public network**.
6. Click the network location that you want.

### Printer Sharing

To manually activate printer sharing, follow the instructions.

1. Click **Start**.
2. Click **Devices and Printers** and then double-click your printer.
3. Click **Customize** your printer.
4. Click the **Sharing** tab and select the **Share this printer** check box.

### Password-protected sharing

With password-protected sharing, people on your network can't access shared folders on other devices, including Public folders, unless they have a user name and password on the device for shared folders.

To activate password-protected sharing, follow the instructions.

1. Click **Start**.
2. Click **Control Panel**.
3. Type network in the Search box.
4. Click **Network and Sharing Center**.
5. In the left pane, click **Change advanced sharing settings**.
6. Click the arrow to expand the Home or Work network profile.
7. Under **Password protected sharing**, click **Turn on password protected sharing**.
8. Click **Save changes**.
    > [!NOTE]
    > You might be asked for an administrator password to confirm your choice.

### Network map

The network map is a graphical view of the devices and devices on your network. The map shows how devices are connected and includes any problem areas. It can be helpful for troubleshooting.

The network map is available in the Network and Sharing Center on Windows 7.

### Sharing options that turn on automatically

For Windows Vista, certain sharing options turn on automatically. For example, when you change your network location to Home or Work, network discovery is automatically turned on. Similarly, file sharing turns on automatically the first time you try to share a file or folder.

### Sharing options that need to be turned on manually

If certain sharing options don't turn on automatically, you can activate them manually. These manual activation options include:

- Network discovery
- Network sharing (formerly location)
- Printer sharing
- File sharing

### Network discovery

Network discovery is a network setting that lets your device find other devices on the network and other devices find your device. Such functionality makes it easier to share files and printers.
There are three network discovery states:

- **On**: Enables your device to see other network devices and people on other network devices to see your device.
- **Off**: Prevents your device from seeing other network devices and prevents people on other network devices from seeing your device.
- **Custom**: Enables limited network discovery. For example, if you run network discovery without meeting all required firewall conditions, the network discovery state would be shown as Custom.

To manually activate network discovery, follow the instructions.

1. Click **Start**.
2. Click **Control Panel**.
3. Type network in the Search box.
4. Click **Network and Sharing Center** and then in the left pane, click **Change advanced sharing settings**.
5. Click the chevron button to expand your current network profile.
6. Click **Turn on network discovery**.
7. Click **Save changes**.

### Network sharing (formerly network location)

Windows 7 automatically adjusts security and other settings based on the type of network connected to your device. If you skip this step, then the first time that you connect to the network, you'll be asked to select your network location. You can change this setting later.

##### Check the network location devices

- **Private**. For home or small office networks when you know and trust the people and devices on the network. Network discovery is on by default.

- **Public**. For networks in public places (such as coffee shops or airports). This location keeps your device from being visible to other devices around you and helps protect your device from any malicious software on the Internet. Network discovery is turned off for this location.

For your small business network, make sure that the network location type is set to Home or Work. Here's how to check:

1. Click **Start**.
2. Click **Control Panel**.
3. Type network in the Search box.
4. Click **Network and Sharing Center**.
5. Click **Customize** and then click **Public or Private**.
6. Click **Next**.
7. Click **Close**.
   > [!Note]
   > You might be asked for an administrator password or to confirm your choice.

### Printer Sharing

To manually activate printer sharing, follow the instructions.

1. Click **Start**.
2. Open the **Printers** control panel and right-click your printer.
3. Click **Sharing**.
4. Click **Change sharing** options.
5. Click **Continue**.
6. Click **Share this printer** and then click **OK**.

### Share a file or folder

To share a file or folder, follow the instructions:

1. Press and hold or right-click a file or folder.
2. Tap or click **Share with**.
3. Select the people or groups that you want to share with. You can also assign permissions so that those people can or can't change the file or folder shared.

### Password-protected sharing

With password-protected sharing, people on your network can't access shared folders on other devices, including Public folders, unless they have a user name and password on the device for shared folders.

To activate password-protected sharing, follow the instructions.

1. Click **Start**.
2. Click **Control Panel**.
3. Type network in the Search box.
4. Open **Network and Sharing Center** in **Control Panel**.
5. Under **Sharing and Discovery**, click the chevron next to **Password protected sharing** to expand the section.
6. Click **Turn on password protected sharing**.
7. Click **Apply**.
   > [!Note]
   > You might be asked for an administrator password or to confirm your choice.

### Network map

The network map is a graphical view of the devices and devices on your network. The map shows how devices are connected and includes any problem areas. It can be helpful for troubleshooting.

The network map is available in the Network and Sharing Center on Windows Vista.

### Sharing options that turn on automatically

In Windows XP, password-protected file sharing is turned on by default.
> [!Note]
> Windows XP only detects and accesses devices that are in the same workgroup.

### Sharing options that need to be turned on manually

If certain sharing options don't turn on automatically, you can activate them manually. These manual activation options include:

- Network discovery
- Network sharing (formerly location)
- Printer sharing
- File sharing

### Network discovery

Network discovery is a network setting that lets your device find other devices on the network and other devices find your device. Such functionality makes it easier to share files and printers.
There are three network discovery states:

- **On**: Enables your device to see other network devices and people on other network devices to see your device.
- **Off**: Prevents your device from seeing other network devices and prevents people on other network devices from seeing your device.
- **Custom**: Enables limited network discovery. For example, if you run network discovery without meeting all required firewall conditions, the network discovery state would be shown as Custom.

To ensure that a Windows XP device displays on the network, install the Link-Layer Topology Discovery (LLTD) protocol on the device. If this operation doesn't resolve the problem, enable file and printer sharing, and NETBIOS.

1. Click **Start**.
2. Click **Control Panel**.
3. Click **Network Connections**.
4. Select the network connection for your network.
5. If the device you're on doesn't display, select the checkbox for **File and Printer Sharing for Microsoft Networks**.
6. Click **Close**.
   > [!Note]
   > Windows XP only detects and accesses devices that are in the same workgroup.

### Printer Sharing

To manually activate printer sharing, follow the instructions.

1. Open the **Printers and Faxes** control panel and right-click your printer.
2. Click **Share this printer** and then click **OK**.

> [!Note]
> If your network consists of devices that are running similar hardware and software, you can select the option to download additional printer drivers on the host system. We do not recommend this option if you have a mixed network that includes more than one combination of 32-bit and 64-bit operating systems.

### Share a file or folder

To share a file or folder, follow the instructions.

1. Click **Sharing and Security**.
2. Select the people or groups that you want to share with. You can also assign permissions so that those people can or can't change to the file or folder you shared.

> [!Note]
> If your network contains devices running different versions of Windows, put all devices in the same workgroup. This makes it possible for devices that are running different versions of Windows to detect and access one another. Remember that the default workgroup name is not the same in all versions of Windows.

### Password-protected sharing

With password-protected sharing, people on your network can't access shared folders on other devices, including Public folders, unless they have a user name and password on the device for shared folders.

With Windows XP, password protected sharing is turned on by default.

### Network map

The network map is a graphical view of the devices and devices on your network. The map shows how devices are connected and includes any problem areas. It can be helpful for troubleshooting.

If you want a device running Windows XP to appear on the network map, you might have to install the Link-Layer Topology Discovery (LLTD) protocol on that device.

If Windows XP devices still don't appear on the network map even after you install the LLTD protocol, check your Windows firewall settings and make sure that file and printer sharing is enabled. "To learn more about this issue, open **Help and Support** and search for _Enable file and printer sharing_". If you're using another firewall, see the information that was included with your firewall.
