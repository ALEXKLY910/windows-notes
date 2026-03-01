In order for apps and files to be launched/opened on startup, you will need to place them in the special startup folder. Windows Explorer will then go over the files you put there and "open" them with the default policy applied.

That is, for example, it will launch a .exe, open a .txt with the default app, or even open a folder in a file explorer.

To access that folder, you can type into ther Run menu (Win+R) `shell:startup`. That is the user scope variant of that folder - that is whatever's inside will be executed if you log in into that user.

The actual location of the folder is `C:\Users\alex\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup`.

The system-wide equivalent can be launched with `shell:common startup`.

