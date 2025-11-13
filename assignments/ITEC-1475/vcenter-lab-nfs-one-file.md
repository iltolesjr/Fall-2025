# vcenter lab: network filesystems (nfs) (one-file)

objective: export a folder and mount it.

server quick block (already covered in all-in-one):
- see `week4_to_now_all_in_one.md` and run it (nfs section auto-runs)

client helper (from repo root script):
```bash
bash nfs_client_mount.sh
```
proof:
- server: `exportfs -v` and `ls -l /srv/nfs/shared`
- client: `mount | grep nfs` and `ls -l /mnt/nfs_shared`
