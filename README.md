# 🚀 EVPN-Fabric: BGP + VXLAN Data Center Topology (Containerlab)

# BEFORE ALL THE A.I SLOP READ THIS FIRST
!!! UPDATE THERE'S A FOLDER WITH FULL BGP-EVPN FUNCTIONALITY NOT MUCH ELSE TO SAY I'LL TRY TO UPLOAD THE TOPOLOGY
Lab would probably not run as it should when you deploy. some interfaces might be misconfigured or routes that need to be added. just make sure each NODE can reach EVERY single address network it needs to.
That's the only issue, I've added daemons and edited to say xxx=yes when needed. If its your first time using Containerlab be patient, your issue is probabaly much smaller than you think (well sometimes). The Vxlan-setup.sh is a shell script that was meant to be deployed after deploying the lab itself but my current setup has the vxlan already setup in the main .yaml, could come in handy.

AND finally try to add your own spin to it, it's really satifying to see your pings get replies after 3 days of troubleshooting



This project demonstrates a **working BGP+VXLAN fabric** using [Containerlab](https://containerlab.dev/), with a three-node topology consisting of a spine and two leaf switches.
It reflects a simplified **data center fabric**, showcasing real-world routing and tunneling technologies — with plans to evolve into a full **EVPN with Kubernetes cluster overlay**.

---

##📂 Folder Structure
.
├── configs/
│   ├── spine1/
│   ├── leaf1/
│   └── leaf2/
├── evpn_fabric.clab.yml
├── evpn_fabric.dot
├── evpn_fabric.png
└── README.md

## 📘 Lab Topology

![Topology Diagram](evpn_fabric.png)

- Spine (FRR v8.5, AS 65001)
- Leaf1 (FRR v8.5, AS 65011)
- Leaf2 (FRR v8.5, AS 65012)
- VXLAN tunnel between leaves
- eBGP sessions from each leaf to the spine
- Underlay: 172.20.x.x | Overlay: 10.100.0.x (VXLAN 100)

---

## 🔧 How to Deploy

1. Clone this repo.
2. Install [Containerlab v0.68.0+](https://containerlab.dev/install/)
3. Run:

```bash
containerlab deploy -t evpn_fabric.clab.yml
