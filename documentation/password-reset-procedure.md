# 🔐 Password Reset Procedure  
*IT Glue–style documentation for resetting user passwords and resolving related authentication issues.*

---

## 📌 Purpose
Provide a standardized, repeatable procedure for performing password resets, verifying identity, syncing credentials, and resolving common login issues for end users in a hybrid Active Directory + Azure AD environment.

This ensures security, consistency, and proper documentation.

---

## 📍 Applies To
- Windows 10 / 11  
- On-prem Active Directory accounts  
- Azure AD / Office 365 accounts  
- Hybrid identity environments  
- MFA-enabled accounts  
- Onsite and remote users  

---

## 🧩 Prerequisites

Technician must have:

- Access to **Active Directory Users & Computers (ADUC)**  
- Access to **Azure AD portal** (if hybrid)  
- RMM/remote access to user’s workstation  
- User available to confirm identity  

---

# 🛠️ Step-by-Step Procedure

---

## **1. Verify User Identity (Required)**

Ask the user one or more of the following:

- “Can you confirm your employee ID or department?”  
- “What was the last 4 digits of your previous ticket number?”  
- “Can you verify your manager’s name?”  
- “Can you confirm your username and workstation name?”  

**Do NOT perform a password reset until identity is verified.**

---

# **2. Confirm the Issue**

Ask the user:

- “Are you unable to log in to Windows, Office apps, or both?”  
- “Did you recently change your password?”  
- “Did you receive an incorrect password or MFA error?”  
- “Are you logging in onsite or remotely?”  

Document their answers.

---

# **3. Reset Password in Active Directory (Primary Step)**

In ADUC:

1. Right-click the user → **Reset Password**  
2. Enter temporary password that meets policy  
3. Check:  
   - ✔ “User must change password at next login”  
4. Click **OK**

### If account is locked:
- Right-click → **Properties** → *Account* tab → check **Unlock Account**

---

# **4. Verify Group Membership (Optional but Recommended)**

In ADUC → User Properties → *Member Of*:

Confirm user is still part of required groups:

- Department groups  
- Shared folder groups  
- VPN or RDP groups  
- MFA / security groups (hybrid only)

Incorrect membership can cause login & drive mapping issues.

---

# **5. Force Azure AD Password Sync (Hybrid Environments)**

If password reset in AD is not instantly working in cloud apps:

1. Open **Azure AD Connect** (if you have access)  
2. Run:

```
Start-ADSyncSyncCycle -PolicyType Delta
```

Or from Azure portal, verify:

- Password hash sync timestamp  
- Sign-in logs for failures  

---

# **6. Clear Cached Credentials on the User’s Workstation**

If the user changed password offsite, cached creds may conflict.

Have technician clear:

### Credential Manager:
1. Open **Credential Manager**  
2. Delete entries for:  
   - `domain.local`  
   - `AzureAD`  
   - Office apps  
   - VPN credentials  

### Flush Kerberos Ticket (optional):
```
klist purge
```

---

# **7. Instruct User to Reboot**

A full restart ensures:

- New password applies cleanly  
- Kerberos tickets refresh  
- MFA prompts reset  
- Cached tokens are cleared  

---

# **8. Have User Log In with New Password**

User enters the temporary password → then creates a new one.

Confirm:

- ✔ Login successful  
- ✔ MFA prompts appear correctly  
- ✔ Outlook connects  
- ✔ Teams logs in  
- ✔ File shares map correctly  

---

# 🧠 Common Causes & Fixes

### **1. Password Changed Offsite → Sync Delay**  
Fix: Reset password again + clear cached creds

### **2. MFA Not Loading**  
Fix: Reboot + sign out of Office apps + re-login

### **3. Account Locked**  
Fix: Unlock in ADUC

### **4. User Removed from Security Group**  
Fix: Re-add group membership → refresh token

### **5. Cached Credentials Conflicting**  
Fix: Clear Credential Manager

---

# 🧾 Escalation Path

Escalate if:

- Password resets successfully, but user still cannot sign in  
- Azure AD Connect shows sync errors  
- User MFA configuration shows corruption  
- User certificate mismatch occurs  
- Domain trust errors on workstation  

Escalate to:

- Systems Administrator (AD/Azure)  
- Security/Identity Team (MFA issues)  
- Networking Team (domain trust issues from VLAN mismatch)  

---

# 📚 Notes / Best Practices

- Always confirm identity before resetting.  
- Document whether user was onsite or remote.  
- Resetting password resolves 90% of login/MFA issues.  
- Always have user **restart** after a password reset.  
- Clear Credential Manager when offsite password resets fail.  

---

# ✔ Status: Published (Ready for Use)
