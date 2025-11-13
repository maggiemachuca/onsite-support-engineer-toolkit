# 🌐 DNS Resolution Case Study  
*A troubleshooting walkthrough showing how DNS issues impact connectivity.*

---

## 📌 Purpose
Show how DNS problems can cause application failures, login issues, and unreachable servers — and how to diagnose them using `nslookup`, `ipconfig`, and fallback testing.

---

## 📍 Applies To
- Windows 10 / 11  
- Internal domain DNS  
- Hybrid or onsite networks  
- Server/drive/printer name resolution  

---

# 🛠️ Scenario Overview

**User Report:**  
> “I can’t access the shared drive or our internal website, but my internet works.”

Classic DNS red flag.

---

# 📝 Step-by-Step Troubleshooting

---

## **1. Confirm User Symptoms**

Ask:

- “Can you browse the internet?”  
- “Is this happening for others?”  
- “Can you access anything by IP address?”  

User can access google.com → DNS, not connectivity.

---

## **2. Test DNS Resolution with nslookup**

```
nslookup fileserver.company.local
```

Typical failure output:

```
*** companydns01.company.local can't find fileserver.company.local: Non-existent domain
```

Interpretation:
- DNS server reachable  
- Record not resolving  

---

## **3. Test Connectivity by IP**

```
ping 192.168.10.50
```

If this works but hostname fails → 100% DNS issue.

---

## **4. Check DNS Server Assignment**

```
ipconfig /all
```

Look for:

- Wrong DNS server (e.g., 8.8.8.8 instead of internal DNS)  
- APIPA address (169.x.x.x)  
- Stale DHCP lease  

---

## **5. Flush and Renew DHCP**

```
ipconfig /flushdns
ipconfig /release
ipconfig /renew
```

Re-test nslookup.

---

## **6. Check Hosts File (Rare Issue)**

```
C:\Windows\System32\drivers\etc\hosts
```

Incorrect static entries can override DNS.

---

## **7. Re-Test Resolution**

```
nslookup fileserver.company.local
```

Expected result:

```
Name: fileserver.company.local
Address: 192.168.10.50
```

---

# 🧠 Root Cause Summary

Root cause in this example:

> User laptop was assigned external DNS (8.8.8.8) due to connecting on guest Wi-Fi before docking.

This prevented internal hostname resolution.

Fix:

- Renew DHCP  
- Reapply correct DNS server  
- Flush DNS  

---

# ✔ Status: Published (Ready for Use)
