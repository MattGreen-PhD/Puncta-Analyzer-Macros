#@ File(label='Input filename') Input_File
#@ File(label='Output directory',style='directory') Output_File
#@ Boolean (value=false) debugging
#@UIService ui
#@ OpService ops
#@ DatasetService ds

import os 
import math
from ij import IJ, ImagePlus, ImageStack
from net.imglib2.img.display.imagej import ImageJFunctions
from loci.plugins import BF
from ij.gui import WaitForUserDialog
from ij.plugin.frame import RoiManager
from ij.plugin.filter import ParticleAnalyzer as PA
from ij.gui import PolygonRoi 
from ij.gui import Roi
from ij.plugin import ZProjector, HyperStackConverter
from ij.process import ImageStatistics as IS
from ij.process import ImageConverter as IC
from ij.plugin import Concatenator
from net.imagej.axis import Axes
from jarray import array
from net.imglib2.type.numeric.integer import UnsignedByteType
import net.imglib2.type.logic.BitType
import net.imglib2.algorithm.neighborhood.HyperSphereShape
from net.imglib2.type.numeric.real import FloatType,DoubleType
from ij.measure import ResultsTable
from net.imagej.ops import Ops
from loci.plugins.in import ImporterOptions
options = ImporterOptions()
options.setId(Input_File.getAbsolutePath())
from loci.formats import ImageReader
from loci.formats import MetadataTools
#get import ready and import
reader = ImageReader()
omeMeta = MetadataTools.createOMEXMLMetadata()
reader.setMetadataStore(omeMeta)
reader.setId(Input_File.getAbsolutePath())
seriesCount = reader.getSeriesCount()
reader.close()
#open image
imp, = BF.openImagePlus(options)
#get output path variable
outdir=Output_File.getAbsolutePath()
#get input path variable
inpu=Input_File.getAbsolutePath()
#convert to RGB
IC(imp).convertToRGB()
#show image
imp.show()
#Define ROI of whole image (basically)
imp.setRoi(1,1,478,479)


######OPTIONAL##############
IJ.run("Brightness/Contrast...")
IJ.run(imp, "Enhance Contrast", "saturated=.8")

#open and clear ROI manager 
rm = RoiManager.getInstance()
if not rm:
	rm = RoiManager()
rm.reset()

#If want to choose regions
#IJ.setTool("rectangle")
#waiting = WaitForUserDialog("Action required","Draw a single ROI with all puncta of interest inside! Then hit OK")
#waiting.show()

#set title variable of image
Title=imp.getTitle()
#make output as outpath and title
outdir=os.path.join(outdir,Title)
#run puncta analyzer
IJ.run(imp, "Puncta Analyzer", "condition=1 red green subtract save rolling=50 light");
#save results
IJ.selectWindow("Results")
IJ.saveAs("Results", outdir + ".csv")
#close for next image
imp.show()
imp.close()

