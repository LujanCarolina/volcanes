#!/usr/bin/env bash
clear


	title=Volcanes_Activos
	echo $title


	REGION=-76.6/-51.6/-57.1/-19.8



	PROJ=M15c
	PROZ=5c
	persp=160/40

	gmt set FONT_ANNOT_PRIMARY 8,Helvetica,black
	gmt set FONT_ANNOT_PRIMARY 8,Helvetica,green
	gmt set FONT_LABEL 8,Helvetica,black

	gmt set FORMAT_GEO_MAP ddd:mm:ssF


	gmt set GMT_VERBOSE w


	gmt set MAP_FRAME_TYPE fancy
	gmt set MAP_FRAME_WIDTH 0.1
	gmt set MAP_GRID_CROSS_SIZE_PRIMARY 0
	gmt set MAP_SCALE_HEIGHT 0.1618
	gmt set MAP_TICK_LENGTH_PRIMARY 0.1


gmt begin $title png


	T=$(gmt info VolcanesActivos.csv -T1 -i2)		
	Max=$(gmt info VolcanesActivos.csv -C -o5)		
	echo $T


	gmt basemap -R$REGION/0/$Max -J$PROJ -JZ$PROZ -p$persp -B+n


	gmt coast -p -Spaleturquoise1 -W1/0.25 

	gmt plot -p "IGN/pais.shp" -Gpink

	gmt coast -p -Df -A+ag -W1/faint,9/148/221

	gmt plot -p "IGN/Capitales_Mundo.txt" -Sc0.15c -Gwhite -Wfaint
	gmt plot -p "IGN/Capitales_Mundo.txt" -Sc0.10c -Gwhite -Wfaint
	gmt plot -p "IGN/Capitales_Mundo.txt" -Sc0.05c -Gblack

	gmt plot -p "IGN/Capitales_Provinciales_Argentina.txt" -Sc0.10c -Gwhite -Wfaint
	gmt plot -p "IGN/Capitales_Provinciales_Argentina.txt" -Sc0.05c -Gblack

	gmt plot -p "IGN/linea_de_limite_FA004.shp" -W1/0.25,dashed
	gmt plot -p "IGN/linea_de_limite_070111.shp" -W1/0.10,-.


	gmt basemap -p -B+t"Volcanes Alturas"


	gmt basemap -p -BWSneZ -Bxf -Byf -Bzafg+l"Altura"


	gmt makecpt -Crainbow $T 
	gmt plot3d -p "VolcanesActivos.csv" -So0.2c -Wthinner -i0,1,2,2 -G1yellow,2goldenrod,3red,4darkred


	gmt colorbar -p -C -DJRM+o0.3c/0+w20/0.618c -L0.1 -S+x"Altura en KM"

gmt end


rm gmt.*
