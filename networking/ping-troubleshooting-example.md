# 📡 Ping Troubleshooting Example  
*A real-world style networking case study demonstrating ICMP-based connectivity testing.*

---

## 📌 Purpose
Demonstrate the process of diagnosing basic connectivity issues using `ping`, verifying packet loss, and isolating whether the problem exists locally, on the network, or on the destination endpoint.

---

## 📍 Applies To
- Windows 10 / 11  
- Onsite users  
- Network printers  
- Servers  
- General network troubleshooting  

---

# 🛠️ Scenario Overview

**User report:**  
> “I can’t reach the shared drive and Teams keeps disconnecting.”

This indicates a potential **network connectivity issue**.

Initial suspicion:  
- Local NIC issue  
- Switch port problem  
- Gateway unreachable  
- DNS issues (secondary)  

---

# 📝 Step-by-Step Troubleshooting

---

## **1. Verify Local NIC Status**

Check if the workstation has network connectivity:

```
ipconfig
```

Expected:

- Valid IPv4 address  
- Correct subnet  
- Correct gateway  
- DNS servers assigned  

If IP begins with **169.254.x.x** → DHCP failure.  
Document this immediately.

---

## **2. Ping Loopback to Confirm TCP/IP Stack**

```
ping 127.0.0.1
```

Results:

- ✔ Successful → TCP/IP stack ok  
- ❌ Failure → NIC driver/corruption  

---

## **3. Ping Local Gateway**

```
ping <default-gateway-ip>
```

Results:

- ✔ Success → LAN path works  
- ❌ Failure → VLAN/switchport issue  

This is the **most important test** for LAN connectivity.

---

## **4. Ping Internal Resource**

Examples:

```
ping fileserver.company.local
ping 192.168.10.50
```

If DNS name fails but IP works → DNS problem.  
If both fail → LAN or server offline.

---

## **5. Ping External Site**

```
ping google.com
```

If this fails but gateway works → DNS issue.  
If this succeeds → internal-only problem.

---

# 🧪 Example Output (Realistic)

Ping to gateway:

```
Pinging 192.168.1.1 with 32 bytes of data:
Reply from 192.168.1.1: bytes=32 time<1ms TTL=64
Reply from 192.168.1.1: bytes=32 time<1ms TTL=64
Reply from 192.168.1.1: bytes=32 time<1ms TTL=64
Reply from 192.168.1.1: bytes=32 time<1ms TTL=64

Ping statistics:
    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss)
```

Ping to fileserver (failing):

```
Pinging fileserver.company.local [192.168.1.40] with 32 bytes of data:
Request timed out.
Request timed out.
Request timed out.
Request timed out.

Ping statistics:
    Packets: Sent = 4, Received = 0, Lost = 4 (100% loss)
```

---

# 🧠 Root Cause Summary

Identified root cause:

> Server `fileserver.company.local` was offline due to a pending update and had not rebooted fully.

Confirmed by:

- Successful gateway ping  
- Successful external ping  
- Failed server ping  

This narrowed the issue to a **specific internal resource**, not a workstation or network-wide problem.

---

# ✔ Status: Published (Ready for Use)
