@echo off

copy /Y "%R_SOURCE%\src\nmath\standalone\sunif.c"     ".\src\nmath\"
copy /Y "%R_SOURCE%\src\nmath\standalone\test.c"      ".\src\nmath\"
copy /Y "%R_SOURCE%\src\nmath\*.c"                    ".\src\nmath\"
copy /Y "%R_SOURCE%\src\nmath\*.h"                    ".\src\nmath\"
copy /Y "%R_SOURCE%\src\gnuwin32\fixed\h\config.h"    ".\include\"
copy /Y "%R_SOURCE%\src\gnuwin32\fixed\h\Rconfig.h"   ".\include\"
copy /Y "%R_SOURCE%\src\include\Rmath.h"              ".\include\"
copy /Y "%R_SOURCE%\src\include\R_ext\Boolean.h"      ".\include\R_ext\"
copy /Y "%R_SOURCE%\src\include\R_ext\Print.h"        ".\include\R_ext\"
copy /Y "%R_SOURCE%\src\include\R_ext\Random.h"       ".\include\R_ext\"
copy /Y "%R_SOURCE%\src\include\R_ext\RS.h"           ".\include\R_ext\"

