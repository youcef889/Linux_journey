+++
date = '2026-03-18T16:06:40+01:00'
draft = false
title = 'Split Zip File If Is To Big'
categories = ["Notes", "Reference"]
tags = ["notes"]
+++


The error:

```
mv: error writing '/mnt/as.zip': File too large
```

means that the destination file system (in this case, likely mounted at `/mnt/`) does **not support large files**, typically files over **2 GB** or **4 GB** in size.

### Common causes

1. **FAT32** file system — has a 4 GB file size limit.
2. **ext3** (with certain configurations) — may have issues with very large files.
3. **Filesystem is mounted with size limitations or quotas**.

---

### ✅ Solution Options

#### 🔍 1. Check the file system type:

Run:

```bash
df -T /mnt
```

Look at the `Type` column — if it's `vfat` (FAT32), it has a 4 GB file size limit.

#### 💡 2. Solutions:

##### ✅ a. Reformat the destination with a large-file-friendly filesystem:

* **Use `exFAT`**, **NTFS**, **ext4**, **XFS**, or **Btrfs**.

  ```bash
  # Example for reformatting to exFAT (after backing up data!)
  sudo mkfs.exfat /dev/sdX1
  ```

##### ✅ b. Compress or split the file before moving:

Split the file into parts:

```bash
split -b 2G as.zip as.zip.part-
```

Then move all parts:

```bash
mv as.zip.part-* /mnt/
```

To reassemble later:

```bash
cat as.zip.part-* > as.zip
```

##### ✅ c. Use a different destination:

Move the file to a location with an ext4, xfs, or exfat file system.

---

If you’re not sure about the filesystem or want help formatting safely, feel free to share the output of:

```bash
df -T /mnt
```

and I’ll guide you.

