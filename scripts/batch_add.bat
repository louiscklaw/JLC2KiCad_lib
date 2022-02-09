@echo on

set TMP_FOOTPRINT_BASE_DIR=tmp\%1
set TMP_FOOTPRINT_DIR=%TMP_FOOTPRINT_BASE_DIR%\footprint
set KICAD_LIB_DIR=C:\temp\kicad-playlist\library\footprint

del /S /Q C:\Users\logic\_TODO\JLC2KiCad_lib\%TMP_FOOTPRINT_DIR%
rmdir  /S /Q C:\Users\logic\_TODO\JLC2KiCad_lib\%TMP_FOOTPRINT_DIR%

mkdir %TMP_FOOTPRINT_DIR%

mkdir %KICAD_LIB_DIR%\LCSC.pretty
mkdir %KICAD_LIB_DIR%\LCSC.pretty\packages3d

pipenv run python JLC2KiCad_lib.py %2 -dir %TMP_FOOTPRINT_BASE_DIR% 

pipenv run python check_footprint_pad.py %TMP_FOOTPRINT_DIR%
pipenv run python update_package_3d_path.py %TMP_FOOTPRINT_DIR%

pipenv run python update_descr.py %TMP_FOOTPRINT_DIR% %5 %6
pipenv run python update_tags.py %TMP_FOOTPRINT_DIR% %3 %4

copy C:\Users\logic\_TODO\JLC2KiCad_lib\%TMP_FOOTPRINT_DIR% %KICAD_LIB_DIR%\LCSC.pretty\
copy C:\Users\logic\_TODO\JLC2KiCad_lib\%TMP_FOOTPRINT_DIR%\packages3d %KICAD_LIB_DIR%\LCSC.pretty\packages3d\
