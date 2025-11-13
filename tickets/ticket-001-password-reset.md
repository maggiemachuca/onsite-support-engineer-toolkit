# 📝 Ticket 001 – Password Reset & MFA Sync Issue (Credential Mismatch)
*An anonymized recreation based on the types of identity & access tickets I handled during my internship.*

---

## 🆔 **Ticket Summary**

**Issue:** User unable to log into Windows; password not accepted. MFA failing on reauthentication.  
**User Impact:** Blocked from accessing workstation; productivity halted.  
**Priority:** P1/P2 depending on role (treated as P2 here).  
**SLA:** Response within 1 hour, resolution within 4 hours.

---

## 👤 **User Information**

- **User:** J.D.  
- **Department:** Accounting  
- **Device:** WIN-ACCT-044  
- **Location:** Building B, 2nd Floor  

---

## 📅 **Timeline**

| Time | Action |
|------|--------|
| 08:12 | Ticket received & acknowledged |
| 08:15 | Contacted user to confirm symptoms |
| 08:17 | Remoted into device via RMM |
| 08:23 | Performed AD password reset & MFA resync |
| 08:28 | Verified user login + app functionality |
| 08:33 | Ticket updated & closed |

---

## 🔍 **Initial Triage Questions**

- “When were you last able to log in?”  
  ➡️ *Yesterday after resetting password.*

- “Did you reset your password onsite or remotely?”  
  ➡️ *Reset at home.*

- “Does the login error say incorrect password?”  
  ➡️ *Yes.*

- “Does MFA fail as well?”  
  ➡️ *Yes, it doesn’t prompt correctly.*

This strongly suggested a **password sync delay** & **cached credentials conflict** between Azure AD and on-prem AD.

---

## 🛠️ **Troubleshooting Steps**

### **1. Verified AD Account Status**

Opened ADUC and confirmed:

- Account **not locked**  
- Password changed ~18 hours prior  
- Group membership correct  
- “User must change password at next logon” not checked  

Everything normal → likely sync delay.

---

### **2. Checked Azure Sync Status**

Reviewed:

- Azure AD Connect sync interval  
- Most recent password hash sync  
- MFA configuration status  

Noticed password sync timestamp was behind.

---

### **3. Reset Password in On-Prem AD**

- Reset password manually  
- Forced password hash sync  
- Verified MFA methods in Azure portal  
- Ensured no conflicting authentication methods  

---

### **4. Cleared Cached Credentials on Workstation**

Via remote tools:

- Opened Credential Manager  
- Removed entries for:  
  - `domain.local`  
  - `AzureAD`  
  - Office apps  
  - VPN credentials  

Cleared local credential conflicts.

---

### **5. Restarted Workstation**

Restarted device remotely to ensure clean authentication with new password.

After reboot:

- User able to log in  
- MFA prompt appeared correctly  
- Authentication succeeded  
- No further errors  

---

## ✔ **Issue Resolved**

**Cause:**  
Password reset offsite triggered **MFA + password sync mismatch**, compounded by **cached credentials** on local workstation.

**Fix:**  
Reset password on-prem, forced Azure AD sync, cleared cached creds, and verified MFA.

---

## 🔎 **Verification Steps**

- Successful Windows login  
- MFA functional  
- Outlook connected  
- Teams logged in  
- File shares mounting normally  
- No domain trust issues  

User confirmed full access.

---

## 🔁 **Escalation (If Needed)**

Not required.

Would escalate if:

- AD replication failed  
- Azure AD Connect was stuck  
- User certificate corrupt  
- MFA configuration mismatched  
- Workstation domain trust broken  

---

## 🧾 **User Communication**

**Initial:**  
> “Hi J.D., I see you’re unable to log in. I’m going to review your account and get this resolved quickly.”

**During troubleshooting:**  
> “It looks like your password didn’t sync correctly yesterday. I’m refreshing it now and clearing the cached information on your device.”

**Resolution:**  
> “You should now be able to log in with your updated password. I verified MFA, email, Teams, and file access. Please let me know if anything else comes up.”

---

## 📚 **Technician Notes**

- Password hash sync delay identified  
- Cleared conflicting cached credentials  
- Updated internal notes regarding MFA desync troubleshooting  
- Verified user access to all core applications  
- No additional tickets needed  

---

# 🟢 **Status: Closed**
