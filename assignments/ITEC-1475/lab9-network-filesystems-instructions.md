# Lab 9 — Network Filesystems (NFS) — Quick Instructions

Purpose
- Export a directory on the NFS server and mount it on the client. Verify read/write access and gather the required screenshots for submission.

One-line goal![1761517349564](image/lab9-network-filesystems-instructions/1761517349564.png)![1761517354827](image/lab9-network-filesystems-instructions/1761517354827.png)![1761517363654](image/lab9-network-filesystems-instructions/1761517363654.png)![1761517374364](image/lab9-network-filesystems-instructions/1761517374364.png)![1761517376506](image/lab9-network-filesystems-instructions/1761517376506.png)![1761517391137](image/lab9-network-filesystems-instructions/1761517391137.png)![1761517396594](image/lab9-network-filesystems-instructions/1761517396594.png)
- On the server: export /srv/nfs_share. On the client: mount it at /mnt/nfs_share and prove read/write.

Prerequisites
- Use the vCenter console tab for screenshots (instructor flagged local VMware screenshots as incorrect).
- Know the server IP (example: 10.14.75.236) and the client IP.
- Have SSH access or open the vCenter VM console.

Quick checklist (do these in order)
1. Confirm you are on the correct vCenter VM(s): run `ip a` and `hostnamectl` on each VM and capture one screenshot showing the vCenter console tab.
2. On the server VM: install nfs-kernel-server, create `/srv/nfs_share`, export it, and verify `exportfs -v`.
3. On the client VM: install `nfs-common`, mount the server export to `/mnt/nfs_share`, verify with `mount` and `df -h`.
4. Test read/write by creating a text file on the client and showing it on the server (or vice versa).
5. Prepare a clean submission document: copy the lab questions into a fresh file, paste answers, and include only the requested screenshots.

Server commands (run on the NFS server VM)
```bash
sudo apt-get update -y
sudo apt-get install -y nfs-kernel-server
sudo mkdir -p /srv/nfs_share
sudo chown nobody:nogroup /srv/nfs_share
sudo chmod 0775 /srv/nfs_share

# Export for the lab network — adjust netmask to match your lab network
echo "/srv/nfs_share 10.14.0.0/16(rw,sync,no_subtree_check)" | sudo tee /etc/exports

sudo exportfs -a
sudo systemctl restart nfs-kernel-server
sudo exportfs -v

# Useful info for screenshots
ip a
hostnamectl
```

Client commands (run on the NFS client VM)
```bash
sudo apt-get update -y
sudo apt-get install -y nfs-common
sudo mkdir -p /mnt/nfs_share
# temporary mount for testing
sudo mount -t nfs 10.14.75.236:/srv/nfs_share /mnt/nfs_share
mount | grep nfs
df -h /mnt/nfs_share
# test read/write
echo "lab test from $(hostname)" | sudo tee /mnt/nfs_share/testfile.txt
sudo cat /mnt/nfs_share/testfile.txt
```

Optional: persist mount in `/etc/fstab` after testing
```
10.14.75.236:/srv/nfs_share  /mnt/nfs_share  nfs  defaults,_netdev  0  0
```

Verification commands
- On server: `sudo exportfs -v`
- On client: `showmount -e 10.14.75.236` and `mount | grep nfs` and `df -h /mnt/nfs_share`

Screenshots to capture (exact)
- Server console: `ip a` + `hostnamectl` (one screenshot showing vCenter console tab)
- Server console: `sudo exportfs -v` output
- Client console: `mount | grep nfs` or `df -h /mnt/nfs_share`
- Client console: `sudo cat /mnt/nfs_share/testfile.txt` showing the test file contents

Submission document checklist
- Use a fresh document. Copy/paste the lab questions at the top.
- Under each question, paste concise answers and include the screenshot(s) exactly where requested.
- Include the commands you ran (copy/paste) and short notes explaining the verification outputs.
- Add a short sentence: "Tests run on vCenter VMs; mount read/write verified." 

Common troubleshooting
- Mount fails: check server firewall/ufw. Temporarily allow client IP or disable UFW for testing:
```bash
sudo ufw allow from <client-ip>/32 to any port nfs
# or temporarily
sudo ufw disable
```
- Permission denied writing: check ownership and mode of `/srv/nfs_share` (should be owned by nobody:nogroup or accessible to chosen user).
- If `mount` hangs: ensure `nfs-kernel-server` is running and `exportfs -v` shows the export.

Time estimate
- If VMs are running and reachable: 45–90 minutes (including screenshots and submission doc).

Example DryRun preview command (to preview SSH-runner commands in the repo)
```powershell
pwsh -File .mcp/run-labs-3-8.ps1 -DryRun -Targets "10.14.75.236,10.14.75.255" -SshUser ubuntu -Choice 4 -HostnameMap "10.14.75.236:itec-deb-01,10.14.75.255:itec-deb-02"
```

Submission filename suggestions
- `lab9-network-filesystems-yourname.docx`
- `lab9-server-exports.png`, `lab9-server-ip.png`, `lab9-client-mount.png`, `lab9-client-testfile.png`

If you want, I can also:
- Generate a ready-to-fill submission document (Markdown or Word) with placeholders for screenshots and answers, or
- Produce a DryRun preview now (I will show the exact ssh command strings I would run)."