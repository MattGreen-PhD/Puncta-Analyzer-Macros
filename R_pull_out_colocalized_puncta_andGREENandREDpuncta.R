#Load package
library(stringr)

#Make function to pull out colocalized puncta number
get_colocalization=function(xy){
  rownum=which(xy%in%"Statistics for colocalized puncta:")
  coloc.puncta=xy[rownum+1]
  return(coloc.puncta)
}

#Make function to pull out colocalized puncta area
get_colocalization_area=function(xy){
  rownum=which(xy%in%"Statistics for colocalized puncta:")
  coloc.puncta.area=xy[rownum+2]
  return(coloc.puncta.area)
}

#function for red puncta number 
get_red=function(xy){
  rownum2=which(xy%in%"Statistics for red channel puncta:")
  red.puncta=xy[rownum2+1]
  return(red.puncta)
}

#function for red puncta area
get_red_area=function(xy){
  rownum2=which(xy%in%"Statistics for red channel puncta:")
  red.puncta.area=xy[rownum2+2]
  return(red.puncta.area)
}

#function for green puncta number
get_green=function(xy){
  rownum3=which(xy%in%"Statistics for green channel puncta:")
  green.puncta=xy[rownum3+1]
  return(green.puncta)
}

#function for green puncta area
get_green_area=function(xy){
  rownum3=which(xy%in%"Statistics for green channel puncta:")
  green.puncta.area=xy[rownum3+2]
  return(green.puncta.area)
}

#Make data frame to add data to
Results.compiled=data.frame(File="", Coloc_Puncta="", Coloc_Area="", red_puncta="", Red_Area="", green_puncta="", Green_Area="")

#Loop through files

###specify path to folder that contains all files here
files=list.files(path='C:/Users/mattg/Desktop/Fiji automation files/Output files/P21/', pattern = '.csv', full.names=TRUE, recursive=FALSE)

#apply function for colocalized puncta
colocalized.puncta=lapply(files,function(x){
  readfile=read.csv(x, stringsAsFactors=FALSE, header=TRUE)
  file.column=readfile[,1]
  return.value=get_colocalization(file.column)
  return(return.value)
})

#apply function for colocalized puncta area
colocalized.puncta.area=lapply(files,function(x){
  readfile=read.csv(x, stringsAsFactors=FALSE, header=TRUE)
  file.column=readfile[,1]
  return.value=get_colocalization_area(file.column)
  return(return.value)
})

#apply function for red puncta
red.puncta=lapply(files,function(x){
  readfile=read.csv(x, stringsAsFactors=FALSE, header=TRUE)
  file.column=readfile[,1]
  return.value=get_red(file.column)
  return(return.value)
})

#apply function for red puncta
red.puncta.area=lapply(files,function(x){
  readfile=read.csv(x, stringsAsFactors=FALSE, header=TRUE)
  file.column=readfile[,1]
  return.value=get_red_area(file.column)
  return(return.value)
})

#apply function for green puncta
green.puncta=lapply(files,function(x){
  readfile=read.csv(x, stringsAsFactors=FALSE, header=TRUE)
  file.column=readfile[,1]
  return.value=get_green(file.column)
  return(return.value)
})

#apply function for green puncta
green.puncta.area=lapply(files,function(x){
  readfile=read.csv(x, stringsAsFactors=FALSE, header=TRUE)
  file.column=readfile[,1]
  return.value=get_green_area(file.column)
  return(return.value)
})

#Get values ready and add to dataframe
colocalized.puncta=unlist(colocalized.puncta)
colocalized.puncta.area=unlist(colocalized.puncta.area)
red_puncta=unlist(red.puncta)
red_puncta_area=unlist(red.puncta.area)
green_puncta=unlist(green.puncta)
green_puncta_area=unlist(green.puncta.area)
colocalized.puncta=str_remove_all(colocalized.puncta,"[Number:]")
colocalized.puncta.area=str_remove_all(colocalized.puncta.area,"Avg. Area:")
red_puncta=str_remove_all(red_puncta,"[Number:]")
red_puncta_area=str_remove_all(red_puncta_area,"Avg. Area:")
green_puncta=str_remove_all(green_puncta,"[Number:]")
green_puncta_area=str_remove_all(green_puncta_area,"Avg. Area:")
### Specify first part of path that's the same in every file to chop off
files_only=str_remove_all(files,"C:/Users/mattg/Desktop/Fiji automation files/Output files/")
Results.compiled=data.frame(files_only,colocalized.puncta,colocalized.puncta.area,red_puncta,red_puncta_area,green_puncta,green_puncta_area)

#export dataframe as csv
###CHANGE OUTPUT PATH HERE
write.csv(Results.compiled, "C:/Users/mattg/Desktop/Fiji automation files/Output files/Compiled_results.csv", row.names=FALSE)
