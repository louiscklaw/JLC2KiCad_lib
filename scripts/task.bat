del /S /Q C:\Users\logic\_TODO\JLC2KiCad_lib\My_lib
rmdir  /S /Q C:\Users\logic\_TODO\JLC2KiCad_lib\My_lib

mkdir C:\Users\logic\_workspace\kicad-playlist\library\footprint\LCSC.pretty
mkdir C:\Users\logic\_workspace\kicad-playlist\library\footprint\LCSC.pretty\packages3d

pipenv run python JLC2KiCad_lib.py ^
  C191736 ^
  -dir My_lib 

copy C:\Users\logic\_TODO\JLC2KiCad_lib\My_lib\footprint C:\Users\logic\_workspace\kicad-playlist\library\footprint\LCSC.pretty\
copy C:\Users\logic\_TODO\JLC2KiCad_lib\My_lib\footprint\packages3d C:\Users\logic\_workspace\kicad-playlist\library\footprint\LCSC.pretty\packages3d\
