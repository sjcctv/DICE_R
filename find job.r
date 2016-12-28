#install required packages if needed
list.of.packages <- c("rvest")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
######


library(rvest)

## scraping function##

dic=function(x)
{ site=x
  DICE <- read_html(site)
  
  inf_h=html_nodes(DICE,"#jobdescSec ")
  info=html_text(inf_h)
  hed_h=html_nodes(DICE,"head title")
  tittle=html_text(hed_h)
  
  ####fix later####
  #RR=strsplit(strsplit(inf_t,"Responsibilities:")[[1]][2],split="[Requirements:,Qualifications:]",fixed=T)
  #resp=RR[[1]][1]
  #req=RR[[1]][2]
  ####fix later####
  
  l=cbind(info,tittle,site)
  dfl=data.frame(l)
  if (length(info)>0) return(l)
}
##scraping##


#obtain site###
site="http://service.dice.com/api/rest/jobsearch/v1/simple.html?text=java&country=US&age=21&page=1"
DICE_r <- read_html(site)

#scraping all the  job description url link##
k=html_nodes(DICE_r,"a") 
lst=html_attr(k,"href")
lst=lst[3:50]  #remove the api-like link

#read all the job job description
k=matrix(ncol =3)
for(n in seq(lst)) {
o=lst[n] 
k=rbind(dic(o),k)
}

View(k)

####
#bug log
# some job description  page could not read eg https://www.dice.com/jobs/detail/90967118/1712-Senior%20Java%20Developer%20Big%20DataAWS?src=19
# could not turn to next page in the api page
#could not remove api-like url link
#

