# 📝 Ticket 002 – Printer Offline (Network Printer Not Responding)
*An anonymized recreation based on the types of printer/network tickets I handled during my internship.*

---

## 🆔 **Ticket Summary**

**Issue:** User unable to print; printer shows “Offline” in Windows.  
**User Impact:** Cannot print invoices needed for daily operations.  
**Priority:** P2 – High impact for a single user/team.  
**SLA:** Response within 1 hour, resolution within 8 hours.

---

## 👤 **User Information**

- **User:** L.T.
- **Department:** Shipping
- **Printer:** SHIP-PRT-02 (HP LaserJet M404dn)
- **Connection:** Network printer (static IP)
- **Location:** Building C, Warehouse floor

---

## 📅 **Timeline**

| Time | Action |
|------|--------|
| 10:04 | Ticket received |
| 10:07 | Contacted user; confirmed issue |
| 10:10 | Checked printer status via web interface |
| 10:15 | Resolved IP conflict + refreshed DHCP entry |
| 10:22 | User able to print successfully |
| 10:31 | Ticket updated & closed |

---

## 🔍 **Initial Triage Questions**

- “Is the printer showing any errors on the display panel?”  
  ➡️ *No — screen shows Ready.*

- “Has anything changed recently? Cable moved? Printer replaced?”  
  ➡️ *No known changes.*

- “Is this affecting all users or just you?”  
  ➡️ *Just me (initially).*

- “Can you see other network drives or resources?”  
  ➡️ *Yes.*

These answers indicated the workstation could see the network, but the **printer itself wasn’t responding**.

---

## 🛠️ **Troubleshooting Steps**

### **1. Verified Printer Availability**
- Pinged printer IP (example: `10.1.24.56`) → **No response**
- Web interface unreachable → Printer not on network

### **2. Physically Checked Printer (Onsite)**
- Printer powered on
- Network cable connected
- NIC lights blinking
- Display panel showed *Ready*, no warnings

### **3. Checked Network Switch Port**
- Located switch port via label: **Port C12**
- Port status showed intermittent connectivity
- Swapped to nearby known-good port **C14**
- Link became stable

### **4. Verified Printer IP Assignment**
- Printer was using static IP `10.1.24.56`
- Found duplicate IP conflict via switch ARP table
- Assigned new static IP: `10.1.24.73`
- Updated DHCP reservation & DNS entry

### **5. Reinstalled Printer on User’s PC**
- Removed stale print queue
- Cleared spooler:  
  `net stop spooler`  
  (deleted spool folder contents)  
  `net start spooler`
- Re-added printer using updated IP
- Test page successful

---

## ✔ **Issue Resolved**

**Cause:**  
Static IP conflict on the warehouse subnet caused the printer to drop offline.

**Fix:**  
Assigned a new static IP, updated DNS reservation, ensured stable switch port, and re-added printer to the workstation.

---

## 🔎 **Verification Steps**

- Successful ping to new IP  
- Web interface reachable  
- Test page printed  
- User printed invoice without issue  
- Printer available for other users on same VLAN  

---

## 🔁 **Escalation (If Needed)**

**Not required.**  
If needed, next steps would include:

- Checking VLAN assignment mismatch  
- Reviewing DHCP logs  
- Inspecting switch port logs  
- Escalating to network team  

---

## 🧾 **User Communication**

**Initial contact:**  
> “Hi L.T., I see you’re having issues printing. I’m going to check the printer’s network connection and follow up shortly.”

**Update:**  
> “I found a network/IP issue with the printer. I’m applying a fix now and will have you test shortly.”

**Resolution:**  
> “Your printer is back online with a new IP address, and everything is responding normally. I printed a test page and you should be good to go. Let me know if anything else comes up!”

---

## 📚 **Technician Notes**

- Identified static IP conflict affecting printer availability  
- Updated documentation with new IP and switch port mapping  
- Suggested migration to DHCP reservation to avoid future conflicts  
- Verified print functionality with several users

---

# 🟢 **Status: Closed**
