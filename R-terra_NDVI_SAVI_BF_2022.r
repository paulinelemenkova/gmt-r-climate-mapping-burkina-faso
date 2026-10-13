# Computing vegetation indices
library(terra)
install.packages("pals")
library(pals)
library(RColorBrewer)
setwd("/Users/polinalemenkova/Documents/R/52_Image_Processing/LC08_L2SP_195051_20220513_20220519_02_T1")
# 1. Normalized Difference Vegetation Index (NDVI) = (NIR - R) / (NIR + R), i.e., NDVI = (Band 5 – Band 4) / (Band 5 + Band 4).
vi <- function(img, k, i) {
  bk <- img[[k]]
  bi <- img[[i]]
  vi <- (bk - bi) / (bk + bi)
  return(vi)
}
# For Landsat NIR = 5, red = 4.
filenames <- paste0('LC08_L2SP_195051_20220513_20220519_02_T1_SR_B', 1:7, ".tif")
filenames
landsat <- rast(filenames)
landsat
ndvi <- vi(landsat, 5, 4)

###############################
colors <- stepped()
plot(ndvi, col = colors, font.main = 1, main = "NDVI for Landsat-8 OLI/TIRS C1 image LC08_L2SP_195051_20220513_20220519_02_T1: central Burkina Faso", cex.main=0.9)
# Plotting histogram of the NDVI
hist(ndvi, font.main = 1, main = "NDVI values for Landsat-8 OLI/TIRS C1 image \nLC08_L2SP_195051_20220513_20220519_02_T1: central Burkina Faso", xlab = "NDVI", ylab= "Frequency",
    col = "springgreen2", xlim = c(-0.5, 0.5),  breaks = 30, xaxt = "n")
axis(side=1, at = seq(-0.6, 0.5, 0.1), labels = seq(-0.6, 0.5, 0.1))
#
# 2. Soil Adjusted Vegetation Index (SAVI) corrects NDVI for the influence of soil brightness in areas where vegetative cover is low
# SAVI = ((Band 5 – Band 4) / (Band 5 + Band 4 + 0.5)) * (1.5).
savi_fun = function(nir, red){
  ((nir - red) / (nir + red + 0.5)) * 1.5
}
savi = lapp(landsat[[c(4, 3)]],
            fun = savi_fun)
plot(savi, col = brewer.pal(11, "Spectral"), font.main = 2, main = "Soil Adjusted Vegetation Index (SAVI) for Landsat-8 OLI/TIRS C1 image \nLC08_L2SP_195051_20220513_20220519_02_T1: central Burkina Faso", cex.main=1.0)
hist(savi, font.main = 1, main = "SAVI values for Landsat-8 OLI/TIRS C1 image \nLC08_L2SP_195051_20220513_20220519_02_T1: central Burkina Faso", xlab = "SAVI", ylab= "Frequency",
    col = "firebrick2", xlim = c(-0.4, 0.4),  breaks = 30, xaxt = "n")
axis(side=1, at = seq(-0.4, 0.4, 0.1), labels = seq(-0.4, 0.4, 0.1))
