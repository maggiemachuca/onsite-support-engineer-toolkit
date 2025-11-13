# 📝 Ticket 003 – VPN Not Connecting (Credential & Tunnel Failure)
*An anonymized recreation based on the types of VPN/user access issues I handled during my internship.*

---

## 🆔 **Ticket Summary**

**Issue:** User unable to connect to VPN from home; receiving “Unable to establish the VPN connection.”  
**User Impact:** Cannot access internal resources remotely.  
**Priority:** P2 – User blocked from remote work.  
**SLA:** Response within 1 hour, resolution within 8 hours.

---

## 👤 **User Information**

- **User:** M.S.  
- **Department:** HR  
- **Device:** Laptop-HR-021  
- **VPN Client:** GlobalProtect  
- **Location:** Remote (home network)  

---

## 📅 **Timeline**

| Time | Action |
|------|--------|
| 07:48 | Ticket received |
| 07:52 | Called user and confirmed symptoms |
| 07:56 | Reviewed logs via remote support |
| 08:04 | Reset stale credentials + refreshed VPN client |
| 08:12 | User connected successfully |
| 08:20 | Ticket updated & closed |

---

## 🔍 **Initial Triage Questions**

- “Has VPN worked before on this device?”  
  ➡️ *Yes, used it last week.*

- “Did anything change recently (password, home router, updates)?”  
  ➡️ *Password changed yesterday.*

- “Does Wi-Fi work normally?”  
  ➡️ *Yes.*

- “Are you receiving a certificate warning or just a connection failure?”  
  ➡️ *Connection failure.*

Based on answers + timing, **stale cached credentials** or **post-password-change token mismatch** was the likely cause.

---

## 🛠️ **Troubleshooting Steps**

### **1. Verified Basic Connectivity**
- Confirmed user had internet  
- Pinged google.com successfully  
- Confirmed `ipconfig` showed valid local IP  

No home network issues detected.

---

### **2. Checked VPN Client Logs**
Located in:  
`C:\Program Files\Palo Alto Networks\GlobalProtect\PanGPS.log`

Observed:  
```
failed to get configuration
authentication failed for user
cached credential mismatch
```

This aligned with the password having been changed the previous day.

---

### **3. Cleared Stale Credentials**
Performed remote steps:

- Opened Windows Credential Manager  
- Removed all entries referencing:  
  - `GlobalProtect`  
  - `vpn.companydomain.com`  
  - Cached AD tokens  

---

### **4. Forced VPN Client Reset**
- Right-clicked system tray icon → “Disconnect”  
- Restarted GlobalProtect service:  
  ```
  services.msc → GlobalProtect Service → Restart
  ```
- Cleared client cache by deleting:  
  ```
  C:\Users\<user>\AppData\Local\Palo Alto Networks\GlobalProtect
  ```

---

### **5. Performed Login With Updated Password**
- User entered newly updated AD password  
- Authentication succeeded  
- Tunnel established on first attempt  

---

## ✔ **Issue Resolved**

**Cause:**  
Cached credentials and stale authentication token after password change.

**Fix:**  
Cleared credential manager entries, reset GlobalProtect client, restarted service, and authenticated with correct password.

---

## 🔎 **Verification Steps**

- VPN connected successfully  
- Verified internal resource access (HR shared drive)  
- Confirmed Outlook connected to internal mailbox  
- Checked Teams sign-in  
- Tunnel remained stable for 10+ minutes  

---

## 🔁 **Escalation (If Needed)**

Not required.

Potential escalation paths would include:

- Checking user certificate in AD  
- Reviewing RADIUS/NPS logs  
- Verifying VPN gateway health  
- Checking MFA integration  

---

## 🧾 **User Communication**

**Initial response:**  
> “Hi M.S., I see you're having trouble with the VPN. I’ll walk you through a few quick steps to get you connected again.”

**During fix:**  
> “It looks like the VPN cached your old password. I’m clearing those entries now and we’ll try connecting again.”

**Completion:**  
> “Your VPN is now connecting normally and you should have full access to internal resources. Please let me know if anything disconnects or behaves unusually.”

---

## 📚 **Technician Notes**

- Issue triggered by AD password change  
- Cached credentials caused authentication mismatch  
- GlobalProtect reset resolved the issue  
- Updated documentation on VPN password-change troubleshooting  
- User confirmed ongoing remote connectivity  

---

# 🟢 **Status: Closed**
