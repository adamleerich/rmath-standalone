# rmath-standalone

A project to merge Rmath and actuar packages for a complete actuarial distribution library.



## Environment variables

To grab the code needed from other places, define these environment variables

```cmd
setx R_SOURCE       "%XDG_CONFIG_HOME%\git\other\r-source-3efd684"
setx ACTUAR_SOURCE  "%XDG_CONFIG_HOME%\git\other\actuar-2fbed1a"
```



## VS Code configuration

Place this in `.vscode/c_cpp_properties.json` after editing `compilerPath`.

```json
{
    "configurations": [
        {
            "name": "Win32",
            "includePath": [
                "${workspaceFolder}/**"
            ],
            "defines": [
                "MATHLIB_STANDALONE",
                "HAVE_CONFIG_H"
            ],
            "compilerPath": "c:\\rtools44\\x86_64-w64-mingw32.static.posix\\bin\\gcc.exe",
            "cStandard": "c17",
            "cppStandard": "gnu++17",
            "intelliSenseMode": "windows-gcc-x64",
            "compilerArgs": [
                "-O3",
                "-Wall",
                "-pedantic",
                "-mfpmath=sse",
                "-msse2",
                "-mstackrealign"
            ]
        }
    ],
    "version": 4
}
```