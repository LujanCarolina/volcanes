	title=Volcanes_Riesgo
	echo $title


	REGION=-76.6/-51.6/-57.1/-19.8


	PROJ=M15c
	PROZ=5c
	persp=160/40

	gmt set FONT_ANNOT_PRIMARY 8,Helvetica,black
	gmt set FONT_ANNOT_PRIMARY 8,Helvetica,green
	gmt set FONT_LABEL 8,Helvetica,black

gmt begin $title png


	gmt basemap -R$REGION -J$PROJ -B+n


	gmt coast -Df -G245/241/214 -S199/224/246 -A+ag		

 	gmt plot "IGN/pais.shp" -Gwhite

	gmt coast -Df -A+ag -W1/faint,9/148/221


	gmt plot "IGN/Capitales_Provinciales_Argentina.txt" -Sc0.10c -Gwhite -Wfaint
	gmt plot "IGN/Capitales_Provinciales_Argentina.txt" -Sc0.05c -Gblack


	gmt plot "IGN/Capitales_Mundo.txt" -Sc0.15c -Gwhite -Wfaint
	gmt plot "IGN/Capitales_Mundo.txt" -Sc0.10c -Gwhite -Wfaint
	gmt plot "IGN/Capitales_Mundo.txt" -Sc0.05c -Gblack
   

	gmt plot "IGN/linea_de_limite_FA004.shp" -Wfaint,dashed
	gmt plot "IGN/linea_de_limite_070111.shp" -Wfaint


	gmt basemap -Bg10 --MAP_GRID_PEN=18/151/221

 
	gmt plot "VolcanesRiesgo.csv" -Skvolcano/0.25 -Wthinner -i0,1,2,2 -Gyellow 
	gmt plot "VolcanesRiesgo2.csv" -Skvolcano/0.25 -Wthinner -i0,1,2,2 -Ggoldenrod 
	gmt plot "VolcanesRiesgo3.csv" -Skvolcano/0.25 -Wthinner -i0,1,2,2 -Gred 
	gmt plot "VolcanesRiesgo4.csv" -Skvolcano/0.25 -Wthinner -i0,1,2,2 -Gdarkred


	cat > tmp_leyenda <<- END
	H 10,AvantGardeDemi Referencias de Riesgo Volcnico
	D 0
	G 0.05
	N1
	G 0.05c
	S 0.2c t     0.5c darkred  0.40p       0.75c Riesgo Volcanico Muy Alto
	S 0.2c t     0.5c red  0.40p       0.75c Riesgo Volcanico Alto
	S 0.2c t     0.5c goldenrod  0.40p       0.75c Riesgo Volcanico Moderado
	S 0.2c t     0.5c yellow  0.40p       0.75c Riesgo Volcanico Bajo
	G 0.05c
	D 0
	H 10,AvantGardeDemi Alturas con Respecto al Nivel del Mar 
	D 0
	G 0.05
	N2
	G 0.05c
	S 0.2c c    0.5c orange1  0.40p    0.75c  Altura (7000-6000 KM) 
	S 0.2c c    0.5c yellow  0.40p    0.75c  Altura (6000-5000 KM) 
	S 0.2c c    0.5c green  0.40p    0.75c  Altura (5000-4000 KM) 
	S 0.2c C    0.5c aquamarine  0.40p   0.75c  Altura (4000-3000 KM) 
	S 0.2c c    0.5c cyan  0.40p    0.75c  Altura(3000-2000 KM)
	S 0.2c c    0.5c blue  0.40p    0.75c  Altura (2000-1000 KM) 
	S 0.2c C    0.5c blueviolet 0.40p    0.75c  Altura (1000-0 KM) 
	END

	gmt legend tmp_leyenda -DJCB+o0.9/0.8c+w19c/6.7c -F+p+i+r


	gmt basemap -Lg-74/-56:20+c+w200k+f+l+ar    -Fl+gwhite+p+i+r 

	gmt image "Volcanes_Activos.png" -DjTR+o0/15+w7.0c	


	gmt basemap -A > tmp_area

	gmt mapproject -WjCM 
	Lon=$(gmt mapproject -WjCM -o0)
	Lat=$(gmt mapproject -WjCM -o1)

	gmt inset begin -DjRB+w2.75c+o0.1c/0.1c

		gmt coast -Rg -JG$Lon/$Lat/? -Gwhite -Slightblue3 -C- -Bg
		gmt coast -W1/faint -N1
		gmt coast -EAR+ggray
		gmt plot tmp_area -Wthin,darkred
	gmt inset end

	gmt basemap -BWSNE -Bxa2f2 -Bya1f1		


gmt end 

	rm gmt.*
