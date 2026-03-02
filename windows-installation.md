1. Update BIOS (through M_FLASH). Make sure you are in the UEFI mode. Enable Secure Boot. Enable TPM 2.0.

2. Install Windows:

    1. Download an official Windows 11 ISO from Microsoft. Download Rufus.

    2. Choose Windows 11 Pro.

    3. Select the partitions of the right disk. Remove every one of them. Then simply click Next.

    4. Shift+F10 opens up the Command Prompt. Type `OOBE\BYPASSNRO` to disable the Internet connection requirement.

3. Install AMD Chipset Driver and NVIDIA driver (Game Ready).

4. Install Chrome

5. Install Happ

6. Install VS Code

7. Istall git:
    >`winget install --id Git.Git -e --source winget`

    Clone the repo `https://github.com/ALEXKLY910/windows-notes.git`

7. Install PowerToys:
    >`winget install Microsoft.PowerToys -s winget`

    Configure them.

7. Install Flow Launcher.


8. Instsall a clipboard manager that supports clipboard history. **CopyQ**:
    >`winget install -e --id hluk.CopyQ`

9. Install Monitorian:
    >`winget install Monitorian -s msstore`

10. Install `AutoHotkey v2` for your custom shortcuts/keybindings. Reference `configs/main-hotkeys.ahk`.

11. Go to settings, reference `settings.md`

12. Configure the shortcuts. Reference `shortcuts.md`











Install Synchthing.





