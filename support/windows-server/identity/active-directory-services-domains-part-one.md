---
title: Active Directory services and domains (Part 1)
description: Explains the Active Directory Services and Windows 2000 or Windows Server 2003 domains.
ms.date: 09/14/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Active Directory topology (sites, subnets, and connection objects)
ms.technology: ActiveDirectory
---
# Active Directory services and domains (Part 1)

This article explains the Active Directory Services and Windows 2000 or Windows Server 2003 domains.

_Original product version:_ &nbsp;Windows 10 – all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp;310996

## Summary

The information covered in this article is provided in part by: [Microsoft Press](https://www.microsoftpressstore.com/).

This article is part 1 of a series of two articles that explain Active Directory Services and Windows 2000 or Windows Server 2003 domains. To view part 2, see [Active Directory Services and Windows 2000 or Windows Server 2003 Domains (Part 2)](https://support.microsoft.com/topic/active-directory-services-and-windows-2000-or-windows-server-2003-domains-part-2-50f2edb5-75db-3ce8-8a71-20b7b4278d3a).
The following topics are covered in part 1:

- The Domain Hierarchy

  - Windows 2000 and Windows Server 2003 Domains
    - Domains
    - Trees
    - Forests

- Trust Relationships

  - Transitive Trusts
  - One-way Trusts
  - Cross-link Trusts

The following topics are covered in part 2:

- Administrative Boundaries

  - Domains
  - Organizational Units

- Active Directory Interaction

  - Emulating the Domain Hierarchy
  - Cataloging the Domain (the Directory Partition)
  - Partitioning the Directory
  - Getting Information About Objects in Another Domain
    - Distributing the Directory
    - Replicating the Directory
  - Cataloging the Enterprise (the Global Catalog)

- Conclusions

This information is an excerpt from the *Active Directory Services for Microsoft Windows 2000 Technical Reference* book, Chapter 3: Active Directory Services and Windows 2000 Domains.

## More information

The Windows 2000 or Windows Server 2003 domain structure and its associated objects are changed significantly from their Windows NT 4 incarnations, reflecting Active Directory service's central role in Windows 2000 or Windows Server 2003 and the design requirements that make it a scalable, enterprise-ready directory service. Some of these changes are obvious, such as the movement to a transitive trust relationship model, while others are subtler, such as the introduction of organizational units. Whether the issues are obvious or subtle, explaining them is central to understanding the interaction and dependencies between Windows 2000 or Windows Server 2003 domains and Active Directory services. Active Directory emulates the Windows 2000 and Windows Server 2003 domain model--or vice versa, if you'd like to look at it that way. Either way, Windows 2000 or Windows Server 2003 domains and Active Directory are dependent on one another and even defined by each other's characteristics. The close and indivisible relationship between Windows 2000 or Windows Server 2003 domains and Active Directory services requires an explanation of the Windows 2000 or Windows Server 2003 domain model and how it interacts with Active Directory services. Therefore, this chapter begins with an explanation of the Windows 2000 and Windows Server 2003 domain model and examines why that model is so different from the Windows NT domain model.

### Windows 2000 and Windows Server 2003 Domains

Windows NT 4 domain models didn't scale well. There are other ways of stating this fact that would sugarcoat the truth, but the simple fact of the matter is that the Windows NT 4 domain model--with its one-way nontransitive trusts--required lots of administrative overhead in large-enterprise implementations. This is no longer the case with Windows 2000 or Windows Server 2003 and their domain models, largely because of the new approach to trusts, but also because the entire domain concept has been revamped to align with industry standards such as Lightweight Directory Access Protocol (LDAP) and Domain Name Service (DNS).

#### The Domain Hierarchy

In Windows 2000 and Windows Server 2003 networks, domains are organized in a hierarchy. With this new hierarchical approach to domains, the concepts of forests and trees were created. These new concepts, along with the existing concept of domains, help organizations more effectively manage the Windows 2000 and Windows Server 2003 network structure.

##### Domains

The atomic unit of the Windows 2000 and Windows Server 2003 domain model hasn't changed; it's still the domain. A domain is an administrative boundary, and in Windows 2000 and Windows Server 2003, a domain represents a namespace (which is discussed in Chapter 4) that corresponds to a DNS domain. For more information about how Active Directory Services and DNS interact, see Chapter 6, "Active Directory Services and DNS."

The first domain created in a Windows 2000 or Windows Server 2003 deployment is called the root domain, and as its name suggests, it's the root of all other domains that are created in the domain tree. (Domain trees are explained in the next section.) Since Windows 2000 and Windows Server 2003 domain structures are married to DNS domain hierarchies, the structure of Windows 2000 and Windows Server 2003 domains is similar to the familiar structure of DNS domain hierarchies. Root domains are domains such as `microsoft.com` or `contoso.com`; they're the roots of their DNS hierarchies and the roots of the Windows 2000 and Windows Server 2003 domain structure.

Domains subsequently created in a given Windows 2000 and Windows Server 2003 domain hierarchy become child domains of the root domain. For example, if msdn is a child domain of `microsoft.com`, the msdn domain becomes `msdn.microsoft.com`.

As you can see, Windows 2000 and Windows Server 2003 require that domains be either a root domain or a child domain in a domain hierarchy. Windows 2000 and Windows Server 2003 also require that domain names be unique within a given parent domain; for example, you can't have two domains called msdn that are direct child domains of the root domain `microsoft.com`. However, you can have two domains called msdn in the overall domain hierarchy. For example, you could have `msdn.microsoft.com` as well as `msdn.devprods.microsoft.com`; the `microsoft.com` namespace has only one child domain called msdn, and the `devprods.microsoft.com` namespace also has only one child domain called msdn.

The idea behind domains is one of logical partitioning. Most organizations large enough to require more than one Windows 2000 or Windows Server 2003 domain have a logical structure that divides responsibilities or work focus. By dividing an organization into multiple units (sometimes called divisions in corporate America), the management of the organization is made easier. In effect, the organization is being partitioned to provide a more logical structure and perhaps to divide work among different sections of the organization. To look at this another way, when logical business units (divisions) are gathered collectively under the umbrella of one larger entity (perhaps a corporation), these logically different divisions create a larger entity. Although work within the different divisions might be separate and very different, the divisions collectively form a larger but logically complete entity. This concept also applies to the collection of Windows 2000 and Windows Server 2003 domains into one larger, contiguous namespace entity known as a tree.

##### Trees

Trees--sometimes called domain trees--are collections of Windows 2000 and Windows Server 2003 domains that form a contiguous namespace. A domain tree is formed as soon as a child domain is created and associated with a given root domain. For a technical definition, a tree is a contiguous DNS naming hierarchy; for a conceptual figure, a domain tree looks like an inverted tree (with the root domain at the top), with the branches (child domains) sprouting out below.

The creation of a domain tree enables organizations to create a logical structure of domains within their organization and to have that structure comply with and mirror the DNS namespace. For example, Claude Kayitare and Company could have a DNS domain called `micromingers.contoso.com` and could have various logical divisions within the company, such as sales, accounting, manufacturing, and so on. In such a situation, the domain tree might look like the domain tree in Figure 3-1.

:::image type="content" source="./media/active-directory-services-domains-part-one/mspresspilot-micromingers.jpg" alt-text="Picture of the domain tree for micromcontos.contoso.com.":::

Figure 3-1. The domain tree for `micromingers.contoso.com`

> [!NOTE]
> By now you've noticed that `contoso.com` is being used all over the place. This isn't vanity on the author's part; it's a legal consideration the publisher insists upon. "No domains that are potentially contentious please," they said. "Only author-owned domains or really, really dull ones." The author has an in at `www.contoso.com` so that domain name has to be used everywhere in this book. I had more inventive names, but alas, we must please the lawyers.

This organization of logical divisions within the company works great for companies that have one DNS domain, but the issue of companies that might have more than one "company" in their larger enterprise must be addressed. That issue is addressed through the use of Windows 2000 and Windows Server 2003 forests.

##### Forests

Some organizations might have multiple root domains, such as `contoso.com` and `microsoft.com`, yet the organization itself is a single entity (such as the fictional David contoso and Company in this example). In such cases, these multiple domain trees can form a noncontiguous namespace called a forest. A forest is one or more contiguous domain tree hierarchies that form a given enterprise. Logically, this also means that an organization that has only a single domain in its domain tree is also considered a forest. This distinction becomes more important later in this chapter when we discuss the way that Active Directory interacts with Windows 2000 or Windows Server 2003 domains and forests.

The forest model enables organizations that don't form a contiguous namespace to maintain organization-wide continuity in their aggregated domain structure. For example, if David contoso and Company--`contoso.com`--were able to scrape together enough pennies to purchase another company called Microsoft that had its own directory structure, the domain structures of the two entities could be combined into a forest. There are three main advantages of having a single forest. First, trust relationships are more easily managed (enabling users in one domain tree to gain access to resources in the other tree). Second, the Global Catalog incorporates object information for the entire forest, which makes searches of the entire enterprise possible. Third, the Active Directory schema applies to the entire forest. (See Chapter 10 for technical information about the schema.) Figure 3-2 illustrates the combining of the `contoso.com` and Microsoft domain structures, with a line between their root domains indicating the Kerberos trust that exists between them and establishes the forest. (The Kerberos protocol is explained in detail in Chapter 8.)

Although a forest can comprise multiple domain trees, it represents one enterprise. The creation of the forest enables all member domains to share information (through the availability of the Global Catalog). You might be wondering how domain trees within a forest establish relationships that enable the entire enterprise (represented by the forest) to function as a unit. Good question; the answer is best provided by an explanation of trust relationships.

#### Trust Relationships

Perhaps the most important difference between Windows NT 4 domains and Windows 2000 or Windows Server 2003 domains is the application and configuration of trust relationships between domains in the same organization. Rather than establishing a mesh of one-way trusts (as in Windows NT 4), Windows 2000, and Windows Server 2003 implement transitive trusts that flow up and down the (new) domain tree structure. This model simplifies Windows network administration, as I'll demonstrate by providing a numerical example. The following two equations (bear with me--the equations are more for illustration than pain-inducing memorization) exemplify the management overhead introduced with each approach; the equations represent the number of trust relationships required by each domain trust approach, where *n* represents the number of domains:

- Windows NT 4 domains--(n * (*n* -1))
- Windows 2000 or Windows Server 2003 domains--(*n* -1)

Just for illustration purposes, let's consider a network that has a handful of domains and see how the approaches to domain models compare. (Assuming that five domains fit in a given hand, *n* = 5 in the following formulas.)

Windows NT 4 domains: (5 * (5-1)) = 20 trust relationships  
Windows 2000 or Windows Server 2003 domains: (5 - 1) = 4 trust relationships  

:::image type="content" source="./media/active-directory-services-domains-part-one/mspresspilot-combined-iserminger-microsoft.jpg" alt-text="Picture of the combining of domain trees for contoso.com and Microsoft.":::

Figure 3-2. The combining of domain trees for `contoso.com` and Microsoft

That's a significant difference in the number of trust relationships that must be managed, but that reduction isn't even the most compelling strength of the new approach to domains. With Windows 2000 and Windows Server 2003 domains, the trusts are created and implemented by default. If the administrator does nothing but install the domain controllers, trusts are already in place. This automatic creation of trust relationships is tied to the fact that Windows 2000 and Windows Server 2003 domains (unlike Windows NT 4 domains) are hierarchically created; that is, there's a root domain and child domains within a given domain tree, and nothing else. That enables Windows 2000 and Windows Server 2003 to automatically know which domains are included in a given domain tree, and when trust relationships are established between root domains, to automatically know which domain trees are included in the forest.

In contrast, administrators had to create (and subsequently manage) trust relationships between Windows NT domains, and they had to remember which way the trust relationships flowed (and how that affected user rights in either domain). The difference is significant, the management overhead is sliced to a fraction, and the implementation of such trusts is more intuitive--all because of the new trust model and the hierarchical approach to domains and domain trees.

In Windows 2000 and Windows Server 2003, there are three types of trust relationships, each of which fills a certain need within the domain structure. The trust relationships available to Windows 2000 and Windows Server 2003 domains are the following:

- Transitive trusts
- One-way trusts
- Cross-link trusts

##### Transitive trusts

Transitive trusts establish a trust relationship between two domains that is able to flow through to other domains, such that if domain A trusts domain B, and domain B trusts domain C, domain A inherently trusts domain C and vice versa, as Figure 3-3 illustrates.

:::image type="content" source="./media/active-directory-services-domains-part-one/mspresspilot-transitive-trust-3-domains.jpg" alt-text="Picture of transitive trust among three domains.":::

Figure 3-3. Transitive trust among three domains

Transitive trusts greatly reduce the administrative overhead associated with the maintenance of trust relationships between domains because there's no longer a mesh of one-way nontransitive trusts to manage. In Windows 2000 and Windows Server 2003, transitive trust relationships between parent and child domains are automatically established whenever new domains are created in the domain tree. Transitive trusts are limited to Windows 2000 or Windows Server 2003 domains and to domains within the same domain tree or forest; you can't create a transitive trust relationship with down-level (Windows NT 4 and earlier) domains, and you can't create a transitive trust between two Windows 2000 or two Windows Server 2003 domains that reside in different forests.

##### One-way trusts

One-way trusts aren't transitive, so they define a trust relationship between only the involved domains, and they aren't bidirectional. You can, however, create two separate one-way trust relationships (one in either direction) to create a two-way trust relationship, just as you would in a purely Windows NT 4 environment. Note, however, that even such reciprocating one-way trusts do not equate to a transitive trust; the trust relationship in one-way trusts is valid between only the two domains involved. One-way trusts in Windows 2000 and Windows Server 2003 are just the same as one-way trusts in Windows NT 4--and are used in Windows 2000 or Windows Server 2003 in a handful of situations. A couple of the most common situations are described below.

First, one-way trusts are often used when new trust relationships must be established with down-level domains, such as Windows NT 4 domains. Since down-level domains can't participate in Windows 2000 and Windows Server 2003 transitive trust environments (such as trees or forests), one-way trusts must be established to enable trust relationships to occur between a Windows 2000 or a Windows Server 2003 domain and a down-level Windows NT domain.

> [!NOTE]
> This one-way trust situation doesn't apply to the migration process (such as an upgrade of an existing Windows NT 4 domain model to the Windows 2000 or Windows Server 2003 domain/tree/forest model). Throughout the course of a migration from Windows NT 4 to Windows 2000 or Windows Server 2003, trust relationships that you have established are honored as the migration process moves toward completion, until the time when all domains are Windows 2000 or Windows Server 2003 and the transitive trust environment is established. There's a whole lot more detail devoted to the migration process in Chapter 11, "Migrating to Active Directory Services."

Second, one-way trusts can be used if a trust relationship must be established between domains that aren't in the same Windows 2000 or Windows Server 2003 forest. You can use one-way trust relationships between domains in different Windows 2000 or Windows Server 2003 forests to isolate the trust relationship to the domain with which the relationship is created and maintained, rather than creating a trust relationship that affects the entire forest. Let me clarify with an example.

Imagine your organization has a manufacturing division and a sales division. The manufacturing division wants to share some of its process information (stored on servers that reside in its Windows 2000 or Windows Server 2003 domain) with a standards body. The sales division, however, wants to keep the sensitive sales and marketing information that it stores on servers in its domain private from the standards body. (Perhaps its sales are so good that the standards body wants to thwart them by crying, "Monopoly!") Using a one-way trust keeps the sales information safe. To provide the necessary access to the standards body, you establish a one-way trust between the manufacturing domain and the standards body's domain, and since one-way trusts aren't transitive, the trust relationship is established only between the two participating domains. Also, since the trusting domain is the manufacturing domain, none of the resources in the standards body's domain would be available to users in the manufacturing domain.

Of course, in either of the one-way trust scenarios outlined here, you could create a two-way trust out of two separate one-way trust relationships.

##### Cross-link trusts

Cross-link trusts are used to increase performance. With cross-link trusts, a virtual trust-verification bridge is created within the tree or forest hierarchy, enabling faster trust relationship confirmations (or denials) to be achieved. That's good for a short version of the explanation, but to really understand how and why cross-link trusts are used, you first need to understand how interdomain authentications are handled in Windows 2000 and Windows Server 2003.

When a Windows 2000 or Windows Server 2003 domain needs to authenticate a user (or otherwise verify an authentication request) to a resource that doesn't reside in its own domain, it does so in a similar fashion to DNS queries. Windows 2000 and Windows Server 2003 first determine whether the resource is located in the domain in which the request is being made. If the resource isn't located in the local domain, the domain controller (specifically, the Key Distribution Service [KDC] on the domain controller) passes the client a referral to a domain controller in the next domain in the hierarchy (up or down, as appropriate). The next domain controller continues with this "local resource" check until the domain in which the resource resides is reached. (This referral process is explained in detail in Chapter 8.)

While this "walking of the domain tree" functions just fine, that virtual walking up through the domain hierarchy takes time, and taking time impacts query response performance. To put this into terms that are perhaps more readily understandable, consider the following crisis:

You're at an airport whose two terminal wings form a V. Terminal A inhabits the left side of the V, and Terminal B inhabits the right. The gates are numbered sequentially, such that both Terminal A's and Terminal B's Gate 1s are near the base of the V (where the two terminals are connected) and both Gate 15s are at the far end of the V. All gates connect to the inside of the V. You've hurried to catch your flight, and arrive at Terminal A Gate 15 (at the far end of the V) only to realize that your flight is actually leaving from Terminal B. You look out the window and can see your airplane at Terminal B Gate 15, but in order for you to get to that gate, you must walk (OK, run) all the way back-up Terminal A to the base of the V and then jog (by now, you're tired) all the way down Terminal B to get to its Gate 15--just in time to watch your flight leave without you. As you sit in the waiting area, biding your time for the two hours until the next flight becomes available and staring across the V to Terminal A, from which you thought your flight was departing, you come up with a great idea: build a sky bridge between the ends of the terminals so that passengers such as yourself can quickly get from Terminal A Gate 15 to Terminal B Gate 15. Does this make sense? It makes sense only if there's lots of traffic going between the terminals' Gate 15s.

Similarly, cross-link trusts can serve as an authentication bridge between domains that are logically distant from each other in a forest or tree hierarchy and have a significant amount of authentication traffic. What amounts to lots of authentication traffic? Consider two branches of a Windows 2000 or Windows Server 2003 domain tree. The first branch is made up of domains A, B, C, and D. A is the parent of B, B is the parent of C, and C is the parent of D. The second branch is made up of domains A, M, N, and P. A is the parent of M, M is the parent of N, and N is the parent of P. That's a bit convoluted, so check out Figure 3-4 for an illustrated representation of this structure.

:::image type="content" source="./media/active-directory-services-domains-part-one/mspresspilot-domain-hierarchy.jpg" alt-text="Picture of a sample domain hierarchy.":::

Figure 3-4. A sample domain hierarchy

Now imagine that you have users in domain D who regularly use resources that, for whatever reason, reside in domain P. When a user in domain D wants to use resources in domain P, Windows 2000 and Windows Server 2003 resolve the request by walking a referral path that climbs back to the root of the tree (domain A in this case), and then walk back down the appropriate branch of the domain tree until they reach domain P. If these authentications are ongoing, this approach creates a significant amount of traffic. A better approach is to create a cross-link trust between domains D and P, which enables authentications between the domains to occur without having to walk the domain tree back to the root (or the base domain at which the tree branches split). The result is better performance in terms of authentication.

## References

The information in this article is an excerpt from the *Active Directory Services for Microsoft Windows 2000 Technical Reference* book, published by Microsoft Press.

:::image type="content" source="./media/active-directory-services-domains-part-one/mspresspilot-ads-2000-reference-book.jpg" alt-text="Picture of Active Directory Services for Microsoft Windows 2000 Technical Reference book.":::

For more information about this publication and other Microsoft Press titles, see [Microsoft Press Store](https://www.microsoftpressstore.com/).
