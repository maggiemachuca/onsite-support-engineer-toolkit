# 🔄 Ticket Handoff Procedure  
*A structured process for handing off in-progress tickets to ensure seamless continuity and SLA compliance.*

---

## 📌 Purpose
Ensure that any in-progress ticket can be picked up by another technician without confusion, delays, or repeated troubleshooting.

This is critical for MSP operations, where multiple support engineers may touch a single ticket.

---

## 📍 Applies To
- Onsite Support Engineer I  
- Remote support engineers  
- Escalation teams  
- All ticketing systems  

---

# 🛠️ Handoff Requirements

A proper handoff must include:

- Clear issue summary  
- Steps already completed  
- Root cause (if known)  
- What still needs to be done  
- Any blockers or approvals needed  
- Files, logs, or screenshots  
- Current ticket status  
- Estimated urgency (related to SLA)  

---

# 🔁 Handoff Procedure

---

## **1. Update Ticket Summary**

Write a simple, clear summary:

> “User unable to log into VPN — password mismatch suspected. Cleared creds, reset password, MFA confirmed working. VPN client still failing with ‘Connection Timeout.’ Requires Tier 2 review.”

---

## **2. Document Steps Already Taken**

Include:

- Troubleshooting actions  
- Commands run  
- Tests performed (ping, nslookup, reboot, reinstall, etc.)  
- Logs reviewed  

Example:

- Cleared Credential Manager  
- Reset MFA  
- Verified AD group membership  
- Tested VPN on hotspot  
- Reinstalled VPN client  

---

## **3. Document Remaining Steps**

Clearly state what’s pending:

- “Needs firewall allow rule check”  
- “Waiting for vendor response”  
- “Requires network admin access to check switch port”  
- “Pending user to be available tomorrow at 9 AM”  

---

## **4. Add Relevant Attachments**

Examples:

- Screenshots of error messages  
- Event Viewer logs  
- VPN client logs  
- Output from networking tests  
- Config files (if applicable)  

---

## **5. Update Status & Assign Appropriately**

Ticket status should reflect:

- “Waiting on user”  
- “Waiting on vendor”  
- “Waiting on escalation team”  
- “In progress”  

Assign to:

- Next available tech  
- Escalation team  
- Networking team  
- Vendor queue  

---

## **6. Notify the Next Technician or Team**

Send internal note or tag in ticket:

Example:

> “@TechName — handing this off. All workstation-side troubleshooting completed. Likely firewall/tunnel issue. Please continue from VPN gateway logs.”

---

## **7. Communicate with the User (If Needed)**

Example message:

> “Hi [User],  
> I’ve completed all workstation-side troubleshooting and escalated your case to our network team. You do not need to take any further action for now. We will update you as soon as the next step is completed.”

Users LOVE clarity.

---

# 📚 Notes / Best Practices

- Never leave a ticket with vague notes (“troubleshooting ongoing”).  
- Assume another technician will continue where you left off.  
- Always communicate delays early.  
- Good handoffs prevent duplicate work and repeated user questions.  

---

# ✔ Status: Published (Ready for Use)
