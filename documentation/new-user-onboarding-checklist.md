# 🆕 New User Onboarding Checklist  
*IT Glue–style documentation for setting up new user accounts, equipment, and access.*

---

## 📌 Purpose
Standardize the onboarding process for new hires to ensure every user receives the correct accounts, hardware, software, and permissions.  
This checklist helps avoid missed steps, escalations, and last-minute scrambling.

---

## 📍 Applies To
- All new employees and contractors  
- Windows 10 / 11 workstations  
- Onsite users (primary)  
- Hybrid AD + Azure AD environments  
- MSP-managed client environments  

---

## 🧩 Required Information (Collect Before Onboarding)

- Full name  
- Job title  
- Department  
- Start date  
- Manager  
- Required applications  
- Required network shares  
- Required security groups  
- Email alias needs  
- Phone/extension (if applicable)  
- Hardware type requested  

This information should be provided **at least 3–5 business days before start date**.

---

# 🛠️ Account Creation Steps

---

## **1. Create AD Account**

In **Active Directory Users & Computers (ADUC):**

1. Create new user in correct OU  
2. Fill in:
   - First/Last name  
   - Username  
   - Email (if synced with O365)  
   - Description (Employee title, department)  
3. Set temporary password  
4. Check:
   - ✔ “User must change password at next logon”  
5. Unlock account if required  

---

## **2. Assign Security Groups**

Add to appropriate groups:

- Department group  
- Shared drive groups  
- Printer groups  
- VPN access (if needed)  
- Remote access (if applicable)  
- Software license groups (e.g., Adobe, QuickBooks, etc.)

**Important:**  
Security groups determine the user's ability to access shared folders and apps.

---

## **3. Create/Verify Email Account**

If using Office 365 / Azure AD:

- Confirm user syncs from on-prem AD  
- Assign M365 license (Business Standard, E3, etc.)  
- Set mailbox policies  
- Add email alias(es) if needed  
- Enable MFA  

Wait for propagation (may take up to 30 minutes).

---

## **4. Setup Additional Access Requirements**

Examples:

- CRM/ERP access  
- Ticketing system access  
- Phone/extension provisioning  
- VOIP softphone login  
- Shared inbox permissions  
- Distribution group membership  
- OneDrive/SharePoint provisioning  

Document all requests.

---

# 💻 Workstation Preparation

---

## **5. Prep the Laptop/Desktop**

- Image device (if required)  
- Apply all Windows updates  
- Verify antivirus is healthy  
- Join to domain  
- Name device according to naming convention  
- Install required applications:
  - Office Suite  
  - Teams  
  - Browsers  
  - Industry-specific apps  
  - Secure remote tools  
- Confirm local admin restrictions (standard user unless approved otherwise)  

---

## **6. Configure User Profile**

After domain join:

- Log in as technician  
- Map required drives  
- Add default printers  
- Confirm browser policies apply  
- Pin frequently used apps to taskbar  
- Set email profile (optional)  
- Configure Teams startup  

---

# 🖨️ Devices & Accessories

---

## **7. Prepare Accessories**

- Monitor (compatible cable included)  
- Keyboard  
- Mouse  
- Docking station  
- USB headset  
- VOIP phone  
- Wireless adapter (if needed)  
- Printer access setup  

---

## **8. Label & Inventory Everything**

Record in inventory system:

- Laptop asset tag  
- Serial number  
- Charger  
- Docking station  
- Peripherals  
- Assigned to user  

---

# 🧑‍🏫 First-Day Setup (User Interaction)

---

## **9. In-Person Walkthrough**

When meeting the new user:

- Welcome them politely  
- Walk them through first logon  
- Ensure password change succeeds  
- Set up MFA (Authenticator app preferred)  
- Explain how to submit tickets  
- Show where shared drives live  
- Verify email and Teams sign-in  
- Test printer access  
- Help log into core business apps  

---

## **10. Verify Everything Works**

### Confirm:

- ✔ Login & MFA  
- ✔ Email + Calendar  
- ✔ Teams  
- ✔ Shared drive access  
- ✔ Printer status  
- ✔ VPN login (if needed)  
- ✔ Specialized software works  
- ✔ Wi-Fi connection  
- ✔ VOIP phone functioning  

Document anything that requires follow-up.

---

# 🧾 Escalation Path

Escalate if:

- AD replication delays  
- License provisioning errors  
- MFA fails repeatedly  
- Group membership not applying (GPO issues)  
- VPN accounts not syncing  
- Workstation not joining domain  
- Printer deployment errors  

Escalate to:

- Systems Administrator (AD/Azure)  
- Networking Team  
- Security/Identity Team  
- Phone/VOIP vendor (if needed)  

---

# 📚 Notes / Best Practices

- Start account creation **2–3 days before** the employee arrives.  
- Avoid creating accounts with missing information — it leads to permission issues later.  
- Always verify group membership before giving laptop to user.  
- Keep onboarding checklist updated with new apps/access requirements.  
- Document EVERYTHING in the ticket for auditing.  

---

# ✔ Status: Published (Ready for Use)
