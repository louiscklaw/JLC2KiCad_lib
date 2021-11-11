import requests 
import json
import os
import logging
import argparse


from KicadModTree import *

import helper
from footprint.footprint import create_footprint, get_footprint_info
from schematic.schematic import create_schematic


def add_component(component_id, args):

	logging.info(f'creating library for component {component_id}')
	data = json.loads(requests.get(f"https://easyeda.com/api/products/{component_id}/svgs").content.decode())

	if not data["success"]:
		logging.error("failed to get component uuid")
		return()

	footprint_component_uuid = data["result"][-1]["component_uuid"]
	schematic_component_uuid = [i["component_uuid"] for i in data["result"][:-1]]
		
	if args.footprint_creation :
		footprint_name, datasheet_link = create_footprint(footprint_component_uuid = footprint_component_uuid, 
														  component_id = component_id, 
														  footprint_lib = args.footprint_lib, 
														  output_dir = args.output_dir)
	else :
		_, datasheet_link, _ = get_footprint_info(component_id)
		footprint_name = ""
		
	if args.schematic_creation :
		create_schematic(schematic_component_uuid = schematic_component_uuid, 
						 footprint_name = footprint_name, 
						 datasheet_link = datasheet_link,
						 library_name = args.schematic_lib,
						 output_dir = args.output_dir)


if __name__ == '__main__': 

	parser = argparse.ArgumentParser(description="take a JLCPCB part # and create the according component's kicad's library",
									 epilog = "exemple use : \n	python3 JLC2KiCad_lib.py C1337258 C24112 -dir My_lib -schematic_lib My_Schematic_lib --no_footprint",
									 formatter_class=argparse.RawDescriptionHelpFormatter)

	parser.add_argument('components', metavar='JLCPCB_part_#', type=str, nargs='+',
						help='list of JLCPCB part # from the components you want to create')

	parser.add_argument('-dir', dest='output_dir', type=str,
						default="JLC2KiCad_lib",
						help='base directory for output library files')

	parser.add_argument('--no_footprint', dest='footprint_creation', action = 'store_false',					
						help = 'use --no_footprint if you do not want to create the footprint')
	parser.add_argument('--no_schematic', dest='schematic_creation', action = 'store_false',					
						help = 'use --no_schematic if you do not want to create the schematic')

	parser.add_argument('-schematic_lib', dest='schematic_lib', type=str,
						default = "default_lib",
						help='set schematic library name, default is "default_lib"')
	parser.add_argument('-footprint_lib', dest='footprint_lib', type=str,
						default = "modules",
						help='set footprint library name,  default is "modules"')

	parser.add_argument('-logging_level', dest='logging_level', type=str,
						default = "INFO",
						help='set logging level')
	parser.add_argument('--log_file', dest='log_file', action = 'store_true',					
						help = 'use --no_schematic if you want logs to be written in a file')

	args = parser.parse_args()

	helper.set_logging(args.logging_level, args.log_file)

	for component in args.components:
		add_component(component, args)