library(rgdal)
library(raster)
library(terra)
library(RColorBrewer)
library(pals)
library(colorspace)
library(RStoolbox)
library(graphics)

#-------------------- Burkina Faso-2022: START-----------------#
# Set up working directory
setwd("/Users/polinalemenkova/Documents/R/52_Image_Processing/LC08_L2SP_195051_20220513_20220519_02_T1")
# Importing data
Landsat_BF2022 <- list.files("/Users/polinalemenkova/Documents/R/52_Image_Processing/LC08_L2SP_195051_20220513_20220519_02_T1")
# Printing the list
list.files()
#
# Stacking the data to create a RasterStack. 
Landsat_BF2022_stack <- stack(Landsat_BF2022)
# Turning a stack into a brick. 
Landsat_BF2022_brick <- brick(Landsat_BF2022_stack)
# Viewing brick attributes
Landsat_BF2022_brick
#
# Running the classification
set.seed(25)
unC <- unsuperClass(Landsat_BF2022_brick, nSamples = 100, nClasses = 10, nStarts = 5)
unC
#
# Creating color palette
colors <- rainbow(10)
# plotting a map
plot(unC$map, main = "K-means Clustering for Landsat-8 OLI/TIRS C1 image of Burkina Faso  \nLC08_L2SP_195051_20220513_20220519_02_T1 (2022)", font.main=1, cex.main = 0.85, col = colors, axes = FALSE, box = FALSE, legend = FALSE)
# adding legend
legend(x = "topleft", inset = 0.03, legend=c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10"), fill = colors, title = "LULC ID Classes", horiz = FALSE,  bty = "n", text.font=3, ncol=1)

#-------------------- Burkina Faso-2022: END-----------------#
