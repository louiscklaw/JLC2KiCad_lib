@echo on

set TMP_FOOTPRINT_BASE_DIR=tmp\%1
set TMP_FOOTPRINT_DIR=%TMP_FOOTPRINT_BASE_DIR%\footprint

del /S /Q C:\Users\logic\_TODO\JLC2KiCad_lib\%TMP_FOOTPRINT_DIR%
rmdir  /S /Q C:\Users\logic\_TODO\JLC2KiCad_lib\%TMP_FOOTPRINT_DIR%

mkdir %TMP_FOOTPRINT_DIR%

mkdir C:\Users\logic\_workspace\kicad-playlist\library\footprint\LCSC.pretty
mkdir C:\Users\logic\_workspace\kicad-playlist\library\footprint\LCSC.pretty\packages3d

pipenv run python JLC2KiCad_lib.py %2 -dir %TMP_FOOTPRINT_BASE_DIR% 

pipenv run python check_footprint_pad.py %TMP_FOOTPRINT_DIR%
pipenv run python update_package_3d_path.py %TMP_FOOTPRINT_DIR%

pipenv run python update_descr.py %TMP_FOOTPRINT_DIR% %5 %6
pipenv run python update_tags.py %TMP_FOOTPRINT_DIR% %3 %4

copy C:\Users\logic\_TODO\JLC2KiCad_lib\%TMP_FOOTPRINT_DIR% C:\Users\logic\_workspace\kicad-playlist\library\footprint\LCSC.pretty\
copy C:\Users\logic\_TODO\JLC2KiCad_lib\%TMP_FOOTPRINT_DIR%\packages3d C:\Users\logic\_workspace\kicad-playlist\library\footprint\LCSC.pretty\packages3d\
