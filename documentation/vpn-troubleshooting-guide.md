# 🌐 VPN Troubleshooting Guide  
*IT Glue–style documentation for resolving VPN client connection failures.*

---

## 📌 Purpose
Provide a standardized procedure for diagnosing and resolving VPN connectivity issues, including authentication failures, tunnel errors, MFA mismatches, and network-related problems.

This guide applies to GlobalProtect, FortiClient, AnyConnect, and other common MSP-managed VPN clients.

---

## 📍 Applies To
- Remote users  
- Windows 10 / 11  
- GlobalProtect, FortiClient, AnyConnect  
- Environments using Azure AD, on-prem AD, or hybrid identity  
- MFA-protected VPN authentication  

---

## 🧩 Prerequisites
Technician should have:

- Access to ADUC (Active Directory Users & Computers)  
- Access to Azure AD portal if hybrid/MFA is used  
- RMM access to endpoint  
- Permissions to restart VPN services  
- User available for testing  

---

# 🛠️ Step-by-Step Troubleshooting

---

## **1. Gather Initial Information**

Ask the user:

- “Has VPN worked before on this device?”  
- “Did you recently change your password?”  
- “Are you receiving an authentication error or a connection error?”  
- “Are you on home Wi-Fi, public Wi-Fi, or hotspot?”  
- “Do you see an MFA prompt?”  

Document the answers.

Most issues fall under:

- Cached credentials  
- Password mismatch  
- MFA not syncing  
- Bad home network  
- VPN client corruption  

---

# **2. Verify Basic Internet Connectivity**

Have the user test:

```
ping google.com
```

If this fails → Wi-Fi/home router issue, not VPN.  
If success → Continue.

Also verify:

- Can user browse the web?  
- Is there packet loss?  
- Is there captive portal (hotel Wi-Fi) blocking VPN traffic?  

---

# **3. Check Authentication Issues (Most Common)**

### Ask user:
“Did you recently change your password?”

If **yes**, cached credentials may be conflicting.

### Clear credentials:
1. Open **Credential Manager**  
2. Remove entries for:
   - `vpn.companydomain.com`  
   - `GlobalProtect` / `FortiClient` / `AnyConnect`  
   - Cached domain credentials  

Reboot.

---

# **4. Force Password Sync (Hybrid Environments)**

In AD / Azure:

- Verify user account is not locked  
- Reset password manually  
- Confirm password hash sync timestamp (Azure AD Connect)  
- Verify MFA methods are correct and active  

Re-test VPN login.

---

# **5. Restart VPN Services**

### Common commands:

GlobalProtect:
```
services.msc → GlobalProtect Service → Restart
```

FortiClient:
```
services.msc → FortiClient Service Scheduler → Restart
```

AnyConnect:
```
services.msc → Cisco AnyConnect Secure Mobility Agent → Restart
```

Restarting the tunnel service fixes ~40% of cases.

---

# **6. Clear VPN Client Cache**

### GlobalProtect example:

Delete:

```
C:\Users\<user>\AppData\Local\Palo Alto Networks\GlobalProtect
```

Delete logs:

```
C:\ProgramData\Palo Alto Networks\GlobalProtect
```

Then restart the client.

---

# **7. Check Home Network Issues**

Common issues:

- ISP modem blocking IPsec  
- Double NAT (router + modem both routing)  
- User on guest Wi-Fi  
- User behind restrictive hotel Wi-Fi  
- DNS failing (fix by using 8.8.8.8 temporarily)

Commands:

```
ipconfig /flushdns
ipconfig /renew
```

If DNS fails → the VPN authentication page may not load.

---

# **8. Verify MFA Prompt Behavior**

Examples:

- User receives *no* MFA prompt → stale token  
- User receives MFA prompt endlessly → token mismatch  
- User receives MFA for wrong account → browser profile conflict  

Fix:

- Have user sign out of **ALL** Microsoft apps  
- Clear browser cookies  
- Re-login with correct account  

---

# **9. Reinstall VPN Client (Last Resort)**

Steps:

1. Uninstall VPN client  
2. Restart workstation  
3. Delete remaining folders from:
   ```
   C:\Program Files
   C:\Program Files (x86)
   C:\ProgramData
   C:\Users\<user>\AppData
   ```
4. Reinstall clean VPN package from company portal  

Re-test login.

---

# 🧠 Common Causes & Quick Fixes

### **1. Password recently changed**  
→ Clear Credential Manager + force sync

### **2. Home network issues**  
→ Restart router + test on hotspot

### **3. MFA mismatch**  
→ Remove stale browser sessions

### **4. VPN service hung**  
→ Restart service

### **5. Corrupt VPN cache**  
→ Delete local VPN config folders

### **6. DNS issues**  
→ Use 8.8.8.8 temporarily

---

# 🧾 Escalation Path

Escalate if:

- User cannot authenticate after password reset  
- MFA enrollment appears corrupted  
- VPN gateway unreachable from multiple users  
- Certificate issues appear in Event Viewer  
- Firewall blocking VPN ports  
- ISP blocking tunnel traffic  

Escalate to:

- Networking Team  
- Security Team (if MFA/identity issue)  
- ISP (if home connection issue)  

---

# 📚 Notes / Best Practices

- Always verify if the issue occurred **after password change**.  
- Ask user if they’re on **public Wi-Fi** (Starbucks, hotel).  
- Avoid reinstalling the VPN client unless truly necessary.  
- Record the exact error message — VPN clients have similar names but different causes.  
- Document root cause clearly for future reference.  

---

# ✔ Status: Published (Ready for Use)
