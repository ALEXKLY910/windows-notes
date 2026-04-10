1. Update BIOS (through M_FLASH). Make sure you are in the UEFI mode. Enable TPM 2.0.

2. Install Windows:

    1. Download an official Windows 10 (64-bit) ISO from Microsoft (it might show the MediaCreationTool as the only download option available. If you have a separate non-Windows setup, download from it. Because it pushes the broken MediaCretionTool only if you go to the official site from the Windows setup).

    2. Make your USB bootable by installing the system from ISO on it the right way:
        1. Plug it into the Arch setup
        2. Identify it by running 
            >`lsblk` 
        3. Unmount all the partitions: 
            >`sudo umount /dev/sdb1` 
        4. Remove old filesystem signatures:
            >`sudo wipefs -a /dev/sdb`
        5. Create a new GPT partition table: 
            > `sudo parted -s /dev/sdb mklabel gpt`
        6. Create one partition starting at 1MiB and going till the end of the drive. This doesn't format it as FAT32 though, we include it in this command as a hint/type for "parted" command later: 
            >`sudo parted -s /dev/sdb mkpart primary fat32 1MiB 100%`

            It might get mounted again, unmount it if needed.
            >`sudo umount /dev/sdb1` 
        7. Mark the partition with ESP flag making it bootable: 
            >`sudo parted -s /dev/sdb set 1 msftdata on`
        8. Format the partition: 
            >`sudo mkfs.fat -F32 -n WIN10 /dev/sdb1`
        9. Mount the ISO and USB:
            >`sudo mkdir -p /mnt/iso /mnt/usb`
            >`sudo mount -o loop,ro -t udf "/home/alex/Downloads/Win10_22H2_English_x64v1.iso" /mnt/iso`
            >`sudo mount /dev/sdb1 /mnt/usb`
        10. Check what the ISO contains in `sources/`: `ls -lh /mnt/iso/sources/install.*`. It should contain two big files: install.wim and install.esd.
        11. Now do the copy in a way that doesn’t instantly fail when it hits the >4GB file. We copy everything except install.wim and install.esd first:
            >`sudo rsync -a --no-owner --no-group --no-perms --info=progress2 --exclude='/sources/install.wim' --exclude='/sources/install.esd' /mnt/iso/ /mnt/usb/`

        12.1. If you have /mnt/iso/sources/install.wim, split it into FAT32-friendly chunks (Windows Setup understands .swm just fine): 
            >`sudo wimlib-imagex split /mnt/iso/sources/install.wim /mnt/usb/sources/install.swm 3800`

        12.2. If instead you have /mnt/iso/sources/install.esd, convert it to WIM first, then split: 
            > `sudo wimlib-imagex export /mnt/iso/sources/install.esd all /mnt/usb/sources/install.wim --compress=LZX`
            > `sudo wimlib-imagex split /mnt/usb/sources/install.wim /mnt/usb/sources/install.swm 3800`
            > `sudo rm /mnt/usb/sources/install.wim`
        13. Flush and unmount cleanly.
            > `sync`
            > `sudo umount /mnt/usb`
            > `sudo umount /mnt/iso`
    
    2. Choose Windows 10 Pro.

    3. Select the partitions of the right disk. Remove every one of them. Then simply click Next.

    4. Shift+F10 opens up the Command Prompt. Type `OOBE\BYPASSNRO` to disable the Internet connection requirement.

3. Install the latest Windows updates. Install AMD Chipset Driver and NVIDIA driver (Game Ready).

4. Install Chrome

5. Install Happ

6. Install VS Code

7. Istall git:
    >`winget install --id Git.Git -e --source winget`

    Clone the repo `https://github.com/ALEXKLY910/windows-notes.git`

7. Install PowerToys:
    >`winget install Microsoft.PowerToys -s winget`

    Configure them (leave only Text Extractor, Always-on-Top, File Locksmith and Light Switch)

    Remap the Text Extractor to `Win+Shift+X` (and make it not play a sound)

8. Install a clipboard manager that supports clipboard history. **CopyQ**:
    >`winget install -e --id hluk.CopyQ`

9. Install the Windows Terminal app:
    >`winget install --id Microsoft.WindowsTerminal -e`

10. Install Flow Launcher. Change the shortcut during the installation to Win+Shift+R

11. Download PicPick. Go to program options. In "Capture" change the output type to Image File. In "Auto Save" turn this feature on and change the folder to something like "C:\Users\alex\Pictures\Screenshots". In "Recording" change the hotkey to None. In hotkeys change all the hotkeys to None except for "Capture Region" for which use the Shift+PrintScreen hotkey.

12. Download VirtualDesktopAccessor.dll from `https://github.com/Ciantic/VirtualDesktopAccessor/releases/` for Windows 10. Put it in the same folder as your autohotkeys scripts. And then reference `workspaces.ahk`.

13. Install `AutoHotkey v2` for your custom shortcuts/keybindings. Reference `configs/main-hotkeys.ahk`.

14. Install Monitorian:
    >`winget install Monitorian -s msstore`

15. Install Syncthing.

16. Install VLC, Discord, Steam

17. Install fzf:
    >`winget install fzf`

18. Install a command-line enhancer `Clink` and a plugin for fzf `clink-fzf`.
    1. Download the installer from `https://github.com/chrisant996/clink/releases`. Run it.
    2. Go to `https://github.com/chrisant996/clink-fzf` and follow the instructions to install clink-fzf.







