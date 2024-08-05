---
title: Troubleshoot ADBA clients
description: Walks through a troubleshooting process for a Windows activation issue.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-tappelgate, v-lianna
ms.custom: sap:Windows Activation\Windows activation issues, csstroubleshoot
---
# Troubleshoot Active Directory Based Activation (ADBA) clients that don't activate

> [!NOTE]
> This article was originally published as a TechNet blog on March 26, 2018.

I recently helped a customer with deploying Windows Server 2016 in their environment. We took this opportunity to also migrate their activation methodology from a KMS Server to [Active Directory Based Activation](/previous-versions/windows/hh852637(v=win.10)).

As proper procedure for making all changes, we started the migration in the customer's test environment. We began the deployment by following the instructions in [Active Directory-Based Activation vs. Key Management Services](https://techcommunity.microsoft.com/t5/Core-Infrastructure-and-Security/Active-Directory-Based-Activation-vs-Key-Management-Services/ba-p/256016). The domain controllers in the test environment were all running Windows Server 2012 R2, so we didn't need to prep the forest. We installed the role on a Windows Server 2012 R2 Domain Controller and chose Active Directory Based Activation as the volume activation method. We installed the KMS key and gave it a name of "KMS AD Activation (\*\* LAB)." We followed the blog post step by step.

We started by building four virtual machines, two Windows 2016 Server Standard and two Windows 2016 Server Datacenter. At this point everything was great. We built a physical server running Windows 2016 Server Standard, and the machine activated properly.

Truthfully, the set up and configuration were super easy, so that part was simple and straight forward. However, all the virtual machines I had built the week prior showed that they weren't activated. I went back to the physical machine and it was fine. I went to the customer to discuss what had happened. The first question was "What changed over the weekend?" And as usual the answer was "nothing." This time, nothing really had been changed, and we had to figure out what was going on.

I went to one of the problem servers, opened a command prompt, and checked the output from the `slmgr /ao-list` command. The `/ao-list` switch displays all activation objects in Active Directory.

:::image type="content" source="media/troubleshoot-adba-clients-not-activate/slmgr-ao-list.png" alt-text="Screenshot showing the slmgr command.":::

:::image type="content" source="media/troubleshoot-adba-clients-not-activate/activation-objects-active-directory.png" alt-text="Screenshot showing the results of the slmgr command.":::

The results show that we have two activation objects: one for Windows Server 2012 R2, and the newly created KMS AD Activation (\*\* LAB) which is the Windows Server 2016 license. This confirms the Active Directory is correctly configured to activate Windows KMS clients.

Knowing that the `slmgr` command is for license activation, I continued with different options. I tried the `/dlv` switch, which will display detailed license information. This looked fine, I was running the Standard version of Windows Server 2016, there's an Activation ID, an Installation ID, a validation URL, even a partial Product Key.

:::image type="content" source="media/troubleshoot-adba-clients-not-activate/slmgr-dlv.png" alt-text="Screenshot showing the results of slmgr /dlv command.":::

Does anyone see what I missed at this point? We'll come back to it after my other troubleshooting steps but suffice it to say the answer is in this screenshot.

My thinking now is that for some reason, the key is broken, so I use the `/upk` switch, which uninstalls the current key. While this was effective in removing the key, it's generally not the best way to do it. Should the server get rebooted before getting a new key it may leave the server in a bad state? I found that using the `/ipk` switch (which I do later in my troubleshooting) overwrites the existing key and is a safer route to take.

:::image type="content" source="media/troubleshoot-adba-clients-not-activate/slmgr-upk.png" alt-text="Screenshot showing the slmgr /upk command and its result.":::

I ran the `/dlv` switch again, to see the detailed license information. Unfortunately, that didn't give me any helpful information, just a product key not found error. Because there's no key since I just uninstalled it.

:::image type="content" source="media/troubleshoot-adba-clients-not-activate/product-key-not-found.png" alt-text="Screenshot of the Command Prompt window showing the slmgr /dlv command and the resulting Product Key Not Found error message.":::

I figured it was a long shot, but I tried the `/ato` switch, which should activate Windows against the known KMS servers (or Active Directory as the case may be). Again, just a product not found error.

:::image type="content" source="media/troubleshoot-adba-clients-not-activate/product-not-found.png" alt-text="Screenshot of the Command Prompt window showing the slmgr /ato command and the resulting Product Not Found error message.":::

The next thought was that sometimes stopping and starting a service does the trick, so I tried that next. I need to stop and start the Microsoft Software Protection Platform Service (SPPSvc service). From an administrative command prompt, I use the trusty `net stop` and `net start` commands. I notice at first that the service isn't running, so I think this must be it.

:::image type="content" source="media/troubleshoot-adba-clients-not-activate/net-stop-start.png" alt-text="Screenshot showing the results of the net stop and net start commands.":::

However, after starting the service and attempting to activate Windows again, I still get the product not found error.

I then looked at the Application Event Log on one of the trouble servers. I find an error related to License Activation, Event ID 8198, that has a code of 0x8007007B.

:::image type="content" source="media/troubleshoot-adba-clients-not-activate/event-id-8198.png" alt-text="Screenshot showing the details of event ID 8198.":::

While looking up this code, I found an article that says the error code means that the file name, directory name, or volume label syntax is incorrect. Reading through the methods described in the article, it didn't seem that any of them fit the situation. When I ran the `nslookup -type=all _vlmcs._tcp` command, I found the existing KMS server (still lots of Windows 7 and Server 2008 machines in the environment, so it was necessary to keep it around), but also the five domain controllers as well. This indicated that it wasn't a DNS problem and the issues were elsewhere.

:::image type="content" source="media/troubleshoot-adba-clients-not-activate/nslookup-results.png" alt-text="Screenshot showing the results of the nslookup command.":::

So I know DNS is fine. Active Directory is properly configured as a KMS activation source. The physical server has been activated properly. Could this be an issue with just VMs? As an interesting side note at this point, my customer informs me that someone in a different department has decided to build more than a dozen virtual Windows Server 2016 machines as well. So now I assume I've got another dozen servers to deal with that won't be activating. However, those servers activated just fine.

Well, I headed back to the `slmgr` command to figure out how to get these monsters activated. This time I'm going to use the `/ipk` switch, which will allow me to install a product key. I went to [Appendix A: KMS Client Setup Keys](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/jj612867(v=ws.11)) to get the appropriate keys for the Standard version of Windows Server 2016. Some servers are Datacenter, but I need to fix this one first.

:::image type="content" source="media/troubleshoot-adba-clients-not-activate/kms-client-setup-keys.png" alt-text="Screenshot showing the list of KMS client setup keys.":::

I used the `/ipk` switch to install a product key, choosing the Windows Server 2016 Standard key.

:::image type="content" source="media/troubleshoot-adba-clients-not-activate/slmgr-ipk.png" alt-text="Screenshot showing the slmgr /ipk command and its results.":::

From here on out I only captured results from my Datacenter experiences, but they were the same. I used the `/ato` switch to force the activation. We get the awesome message that the product has been activated successfully.

:::image type="content" source="media/troubleshoot-adba-clients-not-activate/product-activated-successfully.png" alt-text="Screenshot of the Command Prompt window showing the slmgr /ato command and the resulting Product Activated Successfully message.":::

Using the `/dlv` switch again, we can see that now we have been activated by Active Directory.

:::image type="content" source="media/troubleshoot-adba-clients-not-activate/activated-active-directory.png" alt-text="Screenshot of the Command Prompt window showing the slmgr /dlv command and the resulting message indicating that the user is activated by Active Directory.":::

Now, what had gone wrong? Why did I have to remove the installed key and add those generic keys to get these machines to activate properly? Why did the other dozen or so machines activate with no issues? As I said earlier, I missed something key in the initial stages of looking at the issue. I was thoroughly confused, so reached out to the poster from the initial blog. The poster saw the problem right away and helped me understand what I had missed early on.

When I ran the first `/dlv` switch, in the description was the key. The description was Windows&reg; Operating System, RETAIL Channel. I had looked at that and thought that RETAIL Channel meant that it had been purchased and was a valid key.

:::image type="content" source="media/troubleshoot-adba-clients-not-activate/retail-channel.png" alt-text="Screenshot of showing the results of the slmgr /dlv command with the RETAIL channel information highlighted.":::

When we look at the output of the `/dlv` switch from a properly activated server, notice the description now states the VOLUME_KMSCLIENT channel. This lets us know that it's indeed a volume license.

:::image type="content" source="media/troubleshoot-adba-clients-not-activate/volume-kmsclient-channel.png" alt-text="Screenshot showing the results of the slmgr /dlv command with the VOLUME_KMSCLIENT channel information highlighted.":::

So what does that RETAIL channel mean then? Well, it means the media that was used to install the operating system was an MSDN ISO. I went back to my customer and asked if, by some chance, there was a second Windows Server 2016 ISO floating around the network. Turns out that yes, there was another ISO on the network, and it had been used to create the other dozen machines. They compared the two ISOs and sure enough the one that was given to me to build the virtual servers was, in fact, an MSDN ISO. They removed that MSDN ISO from their network and now we have all existing servers activated and no more worries about the activation failing on future builds.
