# Systems Group #4 - ITEC 1475

**Assignment**: vCenter Lab: Create User Accounts and SSH  
**Discussion Topic**: Post your StarID and IP address of your Mint system  
**Group**: Systems Group #4  

---

## Group Member Information

Please post your StarID and IP address in the format: `IP Address` followed by `StarID-mint`

### Current Group Members

**Brian Huilman** - *Posted Sep 1, 2025 5:24 PM*
- **IP Address**: 10.14.75.205
- **Hostname**: gf4321yk-mint
- **Status**: Posted ✅

**Ira Toles** - *Posted Sep 7, 2025 11:51 PM*
- **IP Address**: 10.74.14.86  
- **Hostname**: fj3453rb-mint
- **Status**: Posted ✅
- **Last Update**: September 11 at 10:27 AM

**Mohamed Salat** - *Posted Sep 4, 2025 12:08 PM*
- **IP Address**: 10.14.75.226
- **Hostname**: sx3671qy-mint  
- **Status**: Posted ✅

**Mohamed Salat** - *Posted Sep 3, 2025 3:41 AM* (Earlier Post)
- **IP Address**: 10.14.75.224/24
- **Hostname**: sx3671qy-mint
- **Status**: Updated ✅

**Berit Haugen** - *Posted Sep 3, 2025 3:41 PM*
- **IP Address**: 10.14.74.25
- **Hostname**: ex9784un-mint
- **Status**: Posted ✅

**Suhayb Arab** - *Posted Sep 6, 2025 4:18 PM*
- **IP Address**: 10.14.74.255
- **Hostname**: ex7347gl-mint
- **Status**: Posted ✅

---

## Instructions for Lab Completion

1. **Post Your Information**: Add your StarID and IP address above
2. **Update Your /etc/hosts File**: Use the information from all group members
3. **Test Connectivity**: Ping each group member's system using their hostname

### Example /etc/hosts Entries

```bash
# Group member entries for Systems Group #4
10.14.75.205    gf4321yk-mint
10.74.14.86     fj3453rb-mint  
10.14.75.226    sx3671qy-mint
10.14.74.25     ex9784un-mint
10.14.74.255    ex7347gl-mint
```

### Connectivity Testing Commands

```bash
# Test connectivity to each group member
ping -c 2 gf4321yk-mint
ping -c 2 fj3453rb-mint
ping -c 2 sx3671qy-mint
ping -c 2 ex9784un-mint
ping -c 2 ex7347gl-mint
```

---

## Group Coordination Notes

- **Keep Systems Running**: Ensure your Linux system stays powered on during the week so group members can ping your system
- **IP Address Changes**: If your IP address changes (DHCP reassignment), update your information here
- **Technical Issues**: Contact group members or instructor if you encounter connectivity problems

## Assignment Integration

This information directly supports the [vCenter Lab: Change Hostname](../../assignments/ITEC-1475/vcenter-lab-hostname.md) assignment requirements:
- Step 4: Share and Add Group Members to `/etc/hosts`
- Step 5: Ping Other Systems for connectivity testing

---

*Last Updated: September 11, 2025*