# https://drmattg.github.io/SDGsR/articles/Introduction_to_SDGsR.html

# devtools::install_github("DrMattG/SDGsR", dependencies = TRUE)

library(tidyverse)
library(SDGsR)
library(readxl)
sdg <- readxl::read_excel("inst/Indicator_map.xlsx", sheet = "SDG_rev")
names(sdg)
sdgnnum <- sdg[ !(is.na(sdg$SDG_code)), c("SDG_code", #"SDG_indic" ,
                                          "EGRIS"  , "GCR", "GDS",  "Interagency", "RBM" ,
                                          "Is_Classificatory",  "SOLUTION" ,  "Dimension", "Tier" , "Comment" ,         
                                           "Reference",         "hint" ) ] %>%
          mutate( indicator = SDG_code)

## Filtering for Americas
ref <- unhcrdatapackage::reference
america <- ref[ which(ref$UNHCRBureau == "Americas" &
                        !(is.na(ref$M49_code)) &
                        ref$code_op != "USA RO ABC"&
                        ref$code_op != "RBAC" &
                       !(is.na(ref$code_op)) ) , ]
#names(america)

## looks like there's a 10K records limits to retrieve from API -
## need to filter by country and date 
## Let's pull from API by Indicator and Country and 
##initiate the frame
# Indall <- SDGsR::get_indicator(Country= paste(america[1, 34]) , indicator = sdgnnum[1,1] )
# 
# Indall <- Indall[NULL,]
# #Ind1all <- Indall1[NULL,]
# # indcheck <- Indall
# 
# for (j in 1:nrow(america)) {
#  # h <-1
#   cat(paste0("\n \n -------\n Pulling data for ", america[j, 3], " - code:", america[j, 3], "\n\n"))  
#   ### Loop around indic
#   for ( i in 1:nrow(sdgnnum)){
#       # i <- 4
#       cat(paste0("Retrieving now : ", sdgnnum[i,2], " for ", america[j, 3] , "\n"))
#       Ind1 <- SDGsR::get_indicator(Country= america[j, 34], indicator= sdgnnum[i,1])
#       
#       ## Remove rows when value is NaN
#       Ind1 <- Ind1[ !(is.nan(Ind1$value)), ]
#   
#       ## Replace NaN by NA for upper and lower Bound
#       Ind1$upperBound <- ifelse(is.nan(Ind1$upperBound), NA , Ind1$upperBound )
#       Ind1$lowerBound <- ifelse(is.nan(Ind1$lowerBound), NA , Ind1$lowerBound )
#       
#       
#       cat ("sleep 3 sec between each indicators...")
#       Sys.sleep(3) 
#       
#       # test if we got something... 
#       if(nrow(Ind1) > 0) {
#         Indall <- dplyr::bind_rows(Indall, Ind1)
#         cat(paste0("Done! ", nrow(Ind1), " records gathered for ", america[j, 3] , " ヽ(´▽`)/ \n\n"))
#       } else {
#         cat(paste0("\n No data for ", sdgnnum[i,2], " in country: ", america[j, 3] ,"ಠ_ಠ  \n\n"))
#       }
#   }
#   rm(Ind1)
#   ## Trying to avoid Timeout was reached: [unstats.un.org] Resolving timed out after 10000 milliseconds
#   cat ("sleep 10 sec between each country...")
#   Sys.sleep(10)
# }
# saveRDS(Indall, file = "Indall.rds")

# names(Indall)
# Indall$row.id = row.names(Indall)
# 
# indtest <- Indall %>%  
#   select(row.id  = row.id, attributes) %>% 
#   unnest(cols = c(attributes)) %>% 
#   dplyr::left_join(Indall %>% 
#                      select(row.id  = row.id, dimensions) %>% 
#                      unnest(cols = c(dimensions)), by = "row.id") 
# 
# indtest <- Indall %>%  
#   select(row.id  = row.id, goal, target,           
#          indicator, series,           
#          seriesDescription, seriesCount,      
#          geoAreaCode ,      geoAreaName,      
#          timePeriodStart ,  value,            
#          valueType ,        time_detail,      
#          timeCoverage,      upperBound,       
#          lowerBound,        basePeriod,       
#          source ,           geoInfoUrl,       
#          footnotes , attributes , dimensions) %>% 
#   unnest(cols = c(goal, target,           
#                   indicator, series,           
#                   seriesDescription, seriesCount,      
#                   geoAreaCode ,      geoAreaName,      
#                   timePeriodStart ,  value,            
#                   valueType ,        time_detail,      
#                   timeCoverage,      upperBound,       
#                   lowerBound,        basePeriod,       
#                   source ,           geoInfoUrl,       
#                   footnotes , attributes , dimensions))
# 
# 
# write.csv(indtest, "indtest.csv" )

indtest <- indtest %>%
  janitor::clean_names() 

names(indtest)

# import ggplot2, ggalt and tidyverse
library(ggplot2)  
library(ggalt)    
library(tidyverse)

indicref <- as.data.frame(unique(indtest[ ,c("goal","target","indicator", "series" ,
                                         "series_description",    "units" ,"observation_status"  )]))

Goals <- get_SDGs_goals() %>% 
      select(  code, description )  %>% 
      rename( target = code)

indicref  <- indicref %>%  
             dplyr::left_join(Goals, by="target")

indicref  <- indicref %>%  
             dplyr::left_join(sdgnnum, by="indicator")


Goals.this <- Goals %>% 
  filter(  target %in%  indicref$target)  

#levels(as.factor(indtest$units))

indicref$disag <- ""
indicref$disagt <- ""
indicref$nnature <- ""
indicref$nreporting_type <- ""
indicref$ngeo <- ""
indicref$ngeot <- ""

for (i in 1:nrow(Goals.this)){
    #  i <- 1
    this.target <- Goals.this[ i, c("target")]
    this.targetdesc <- Goals.this[ i, c("description")]
    this.indicref <- indicref [ indicref$target == this.target,   ]
    this.indicnum <- indicref [ indicref$target == this.target, c("indicator")  ]
    
    for (j in 1:nrow(this.indicref )) {
      # j <- 1
      this.series <- this.indicref[ j, c("series")]
      this.seriesdesc <- this.indicref[ j, c("series_description")]
      this.seriesunit <- this.indicref[ j, c("units")]
      
      # "EGRIS"  , "GCR", "GDS",  "Interagency", "RBM" ,
      # "Is_Classificatory",  "SOLUTION" ,  "Dimension", "Tier" , "Comment" ,         
      # "Reference",         "hint"
      
      this.seriesEGRIS <- this.indicref[ j, c("EGRIS")]
      this.seriesGCR <- this.indicref[ j, c("GCR")]
      this.seriesGDS <- this.indicref[ j, c("GDS")]
      this.seriesRBM <- this.indicref[ j, c("RBM")]
      this.seriesSOLUTION <- this.indicref[ j, c("SOLUTION")]
      this.seriesDimension <- this.indicref[ j, c("Dimension")]
      this.serieshint <- this.indicref[ j, c("hint")]
      
      # Shorten country name for better charts
      df <- indtest[ indtest$series == this.series, ]%>%  
             mutate ( geo_area_name = str_replace(geo_area_name, "Venezuela \\(Bolivarian Republic of\\)", "Venezuela"),
                      geo_area_name = str_replace(geo_area_name, "Bolivia \\(Plurinational State of\\)", "Bolivia"))
      
      ## remove all empty disaggregation
      dfna <- as.data.frame(df [ , colSums(is.na(df)) == 0])
      ## remove var with less than 2levels disaggregation
      disagg <- as.data.frame( disagg <- "dummy")  
      names(disagg)[1] <- "disagg"
      for (h in 14:ncol(dfna)) {
       # h <- 18 
      if ( nlevels(as.factor(dfna[ , h])) >= 2) {
          #dfna[ , h] <- dfna[ , h] 
          #cat(paste0(nlevels(as.factor(dfna[ , h])), " levesl for ", names(dfna)[h],"those are :",levels(as.factor(dfna[ , h])),  "\n" ))
           disagg <- rbind( disagg, as.character(names(dfna)[h]))
          } else {
          # dfna[ , h] <- NULL
          #cat(paste0("less than 2 levesl for for ", names(dfna)[h], "\n")) 
          }
      }
      
      ## We need a different type of plot if there's a disaggreagtion...
      # if(nrow(disagg)>1) {
      #   
      # }
      
      
      ##Identify potential disaggregation
      disagvar <-  names(dfna[ , 15:ncol(dfna)]) %in% c("nature" , "location", "reporting_type", "age", "sex" ,
             "quantile" , "activity" ,  "policy_domains" , "type_of_occupation" , "education_level" ,  
             "type_of_skill", "parliamentary_committees", "migratory_status", "disability_status" ,
             "grounds_of_discrimination", "counterpart")  
      
      
      ## Check number of level for Nature and reporting
      indicref[ indicref$series == this.series, c("disag")] <- ncol(dfna)
      indicref[ indicref$series == this.series, c("disagt")] <- stringr::str_c( (names(dfna[ , 16:ncol(dfna)])),collapse=',') 
      indicref[ indicref$series == this.series, c("nnature")] <- nlevels(as.factor(dfna$nature))
      indicref[ indicref$series == this.series, c("nreporting_type")]  <- nlevels(as.factor(dfna$reporting_type))
      indicref[ indicref$series == this.series, c("ngeo")]  <- nlevels(as.factor(dfna$geo_area_name))
      indicref[ indicref$series == this.series, c("ngeot")]  <- stringr::str_c( unique(dfna$geo_area_name),collapse=',') 
      
      # cat(paste0( "# of col: ", ncol(dfna), 
      #             " nature ", nlevels(as.factor(dfna$nature)),  
      #             " reporting type ",nlevels(as.factor(dfna$reporting_type)),
      #             " reporting country ", nlevels(as.factor(dfna$geo_area_name)), "\n\n"))


      #str(dfna$value)
      #dfna$value <- as.numeric(dfna$value)
      dfna1 <- dfna %>%  
                   select(series_description, geo_area_name, time_period_start,value ) %>% 
                  group_by(series_description, geo_area_name, time_period_start) %>% 
      ## Aggregate base on Unit type - aka sum or average 
        summarize(valmean = mean(as.numeric(value)),
                  valsum = sum(as.numeric(value))  )%>% 
           #So we overprint in the right order
            arrange(time_period_start) #%>% 
      
      if( this.seriesunit %in% c("NUM_TH" , "NUMBER") ) {
        dfna1$value <- dfna1$valsum
      } else {
        dfna1$value <- dfna1$valmean
      }
      
      sdval <-  sd(dfna1$value)
      ## Provide indication of indicator classificiation in the title
      
      plottitle <-  paste0(this.seriesdesc, "\nDimension: ", this.seriesDimension, " ",
        ifelse(this.seriesEGRIS=="EGRIS" , paste0("Tagged EGRIS Indicator. "),"" ),
      ifelse(this.seriesRBM=="RBM" , paste0("- Tagged RBM  Indicator. "),"" ),
      ifelse(this.seriesGDS=="GDS" , paste0("- Tagged SDG Indicator. "),"" ) ) 
      
      
      yearfocus <- tibble(year = 1990:2022,
                          decade = floor(year/5)*5,
                          value = max(dfna1$value)) 
      
      
      p <- ggplot(data = dfna1, 
             aes(x = time_period_start,
                 y = value,
                 group = 1)) +
        geom_line( size = 1.5, color = "blue" ) +
        geom_point(shape =15, size = 2, color = "blue") +  
         
        #  gghighlight::gghighlight(value >= mean(dfna1$value),
        # #value - sdval,
        #                  use_direct_label = FALSE) + 
        # geom_tile( data = yearfocus,
        #            aes(x = year, 
        #                y = value, 
        #                fill = as_factor((decade/10)%%2)),
        #            show.legend = FALSE) +
        # scale_fill_manual(values = c("0" = "white", 
        #                              "1" = "#99999922")) +  
        facet_wrap(~ geo_area_name ) +
         scale_y_continuous(labels = unhcRstyle::format_si()) +
        scale_x_continuous(limits = c(1990, 2022)) +
        geom_hline(yintercept = 0, size = 0.7, colour = "#333333") +
        unhcRstyle::unhcr_theme(base_size = 8) + ## Insert UNHCR Style
        theme(panel.grid.major.y  = element_line(color = "#cbcbcb"), 
              panel.grid.major.x  = element_blank(), 
              panel.grid.minor = element_blank(),
              #panel.grid.major.x = element_blank(),
              legend.position="none") +
        labs(title = paste0(plottitle), 
             subtitle = stringr::str_wrap( paste0(this.targetdesc), 320),
             x = " ", 
             y = paste0(this.seriesunit),
             caption = stringr::str_wrap( paste0("Data extracted from UNStat API.\n",
                                                 "\n Hint: ", this.serieshint), 320))
      
      #print(p)
      file <- paste0("sdg/",
                     ifelse(this.seriesRBM=="RBM" , paste0("Ind_RBM"),"Ind" ),"-", 
                     this.seriesDimension,"-",
                     this.indicnum,"-",
                     this.series,".png")
      cat(paste0(file, "\n"))
      ggsave(plot = p , filename= file, width = 12, height = 8, units = "in", device = "png")
      rm(p, df, dfna, dfna1)
      
    } 
    
}      



yearfocus <- tibble(year = 1999:2022,
       decade = floor(year/5)*5) %>%
  ggplot() +
  geom_tile( data = yearfocus,
            aes(year, 1, 
                fill = as_factor((decade/10)%%2)),
            show.legend = FALSE) +
  scale_fill_manual(values = c("0" = "white", 
                               "1" = "#99999922")) +
  theme_minimal()





      # Draw dumbbell plot
      ggplot() +
        geom_dumbbell(data = dfna, 
                      aes(y = geo_area_name,
                                           x = x1, 
                                           xend = x2),
                      size = 1.5, color = "blue", size_x = 7,
                      size_xend = 7, colour_x = "green",
                      colour_xend = "yellow")
      
      ggplot(dfna, aes(x = value, 
                     y = geo_area_name, 
                     color = as.factor(time_period_start), 
                     fill = as.factor(time_period_start), 
                     shape = as.factor(time_period_start))) +
        
                   geom_other_dotplot(
                     aes(value, 
                         geo_area_name, 
                         group = geo_area_name),
                     arrow = TRUE,
                     size = style$point_size,
                     stroke = style$point_stroke ) +
                   #scale_shape_manual(values = c(style$shapes$point, 99)) +
                   #scale_color_manual(values = c(style$colors$spot.primary.light, style$colors$spot.primary)) +
                   #scale_fill_manual(values = c(style$colors$spot.primary.light, style$colors$spot.primary)) +
                   scale_x_continuous(limits = c(0,105)) +
                   scale_y_discrete(labels = Hmisc::capitalize) +
                   # facet_wrap(~ iso3c, 
                   #            ncol = 1, 
                   #            labeller = as_labeller(wbgref$regions$labels)
                   #            ) +
                   unhcRstyle::unhcr_theme() +
                   theme(
                     panel.spacing.y = unit(0, "npc"),
                     strip.text.x = element_text(vjust = 0)
                   )+ 
               lab(
               title = "Rural dwellers are less likely than their urban counterparts to have access to at least basic water.",
               subtitle = wbg_name(indicator = "People using at least basic water services", denom = "%"),
               note = "Note: Data not available for North America (rural) for 2000.",
               source = paste("Source: WDI (SH.H2O.BASW.UR.ZS; SH.H2O.BASW.RU.ZS)."))
 



















agg3 <- as.data.frame(unique(indtest[ ,c("indicator", "series" ,
                                          "seriesDescription",    "Nature"  )])) %>%
   group_by(indicator , series , seriesDescription ) %>% 
  summarize( series1 = length(unique(Nature))) %>% 
  filter(series1  > 1) %>%
  left_join(as.data.frame(unique(indtest[ ,c(  "series" ,    "Units" ,     "Nature" )]),
                          by="series" )
    
  ) %>% 
  filter(series1  > 1)

agg4 <- as.data.frame(unique(indtest[ ,c("indicator", "series" ,
                                         "seriesDescription",               
                                         "Nature",    "Units" ,                   
                                         "Observation Status"  )]))

agg5 <- as.data.frame(unique(indtest[ ,c("indicator", "series" ,
                                         "seriesDescription",               
                                         "Nature",    "Units" ,                   
                                         "Observation Status" ,  "Location" ,                
                                         "Reporting Type",   "Age"  ,                    
                                         "Sex",       "Quantile"  ,               
                                         "Activity",    "Policy Domains" ,          
                                         "Type of occupation",   "Education level",          
                                         "Type of skill",     "Parliamentary committees" ,
                                         "Migratory status",    "Disability status" ,       
                                         "Grounds of discrimination", "Counterpart" )]))



write.csv(agg1,
          "sdgindicaggr.csv")
# if(nrow(Ind)>0) { 
#   Indi <- Ind %>% 
#           group_by(seriesDescription, geoAreaName) %>% 
#           select(geoAreaName, timePeriodStart,value, seriesDescription, geoAreaCode)
#   


## Doing the county aggregation for each country depending on the type of indic and available disaggregation
# Ind1all <-Ind %>% 
#   group_by(seriesDescription, geoAreaName) %>% 
#   select(geoAreaName, timePeriodStart,value, seriesDescription, geoAreaCode)


## Ploting a dumbell  chart over years for for each country and comparing indicators

# 
# Goals %>% 
#   select(goal, code, description ) %>% 
#   sample_n(.,3) %>% #randomly select three rows to display
#   kableExtra::kable()
# ind_lst<-get_indicator_list()

##
# 
# Panama_code <-lookup_country(code="M49", country = "Panama")
# Panama_code
# 
# runExample(example = "indicator.R")
# 
# Panama.7.1.1 <-get_indicator(Country = Panama_code, indicator = "7.1.1")
# 
# p1<- Panama %>% 
#       select(timePeriodStart,value,seriesDescription) %>% 
#       ggplot(aes(timePeriodStart, as.numeric(value)))+
#       geom_point(colour=SDGs_cols("Goal7"))+
#       labs(x="Year",
#            y="% Mountain Area Protected")+
#       ggtitle(label=paste0(Panama$seriesDescription[1])) +
#       ggpubr::theme_pubclean()+
#       theme(plot.title = element_text(size = 12))
# p1
# 
# ## We can use the SDGSR::get_indicator_data() to connect to the SDGs API and download the data we need.
# # Ind_all <-get_indicator_data(indicator = '11.1.1')  %>% 
# #   group_by(seriesDescription, geoAreaName) %>% 
# #   select(geoAreaName, timePeriodStart,value, seriesDescription, geoAreaCode)
# Ind_11.1.1 <-get_indicator_data(indicator = '11.1.1')
# Ind1_11.1.1 <-Ind_11.1.1 %>% 
#   group_by(seriesDescription, geoAreaName) %>% 
#   select(geoAreaName, timePeriodStart,value, seriesDescription, geoAreaCode)
# 
# 
# Ind_17.8.1 <-get_indicator_data(indicator = '17.8.1')
# Ind1_17.8.1 <-Ind_17.8.1 %>% 
#   group_by(seriesDescription, geoAreaName) %>% 
#   select(geoAreaName, timePeriodStart,value, seriesDescription, geoAreaCode)
# 
# Ind_1.1.1 <-get_indicator_data(indicator = '1.1.1')
# Ind1_1.1.1 <-Ind_1.1.1 %>% 
#   group_by(seriesDescription, geoAreaName) %>% 
#   select(geoAreaName, timePeriodStart,value, seriesDescription, geoAreaCode)
# 
# # Now we join the three datasets together and select the name of the country, 
# # the year, the Indicator value, the description of the series that the value 
# # relates to and the ISO three letter country code.
# 
# names(Ind_11.1.1)
# names(Ind_17.8.1)
# names(Ind_1.1.1)
# 
# Ind_15_data=rbind(Ind1_11.1.1,
#                   Ind1_17.8.1, 
#                   Ind1_1.1.1)
# 
# Ind_15_data$Indicator = c(rep("Ind_11.1.1", dim(Ind1_11.1.1)[1]), 
#                           rep("Ind_17.8.1", dim(Ind1_17.8.1)[1]), 
#                           rep("Ind_1.1.1", dim(Ind1_1.1.1)[1])
#                           )
# 
# Ind_15_data %>%
#   head(4) %>% 
#   kableExtra::kable()
# 
# 
# data("lookup_country_codes")
# 
# mapp_data <- Ind_15_data %>% 
#               mutate(region=tolower(geoAreaName)) %>% 
#               mutate(value=as.numeric(value))
# 
# mapp_data <- mapp_data %>% 
#             full_join(lookup_country_codes, copy=FALSE,by=c("geoAreaName"="country_or_area")) %>% 
#             select(iso_alpha3_code, geoAreaName, value, seriesDescription, Indicator, timePeriodStart) %>% 
#             drop_na(iso_alpha3_code) %>%
#             drop_na(Indicator)
# 
# p <-mapp_data %>% 
#   filter(Indicator=="Ind_11.1.1") %>%
#   filter(seriesDescription=="Countries that are contracting Parties to the International Treaty on Plant Genetic Resources for Food and Agriculture (PGRFA) (1 = YES; 0 = NO)") %>% 
#   drop_na(iso_alpha3_code) %>% 
#   plotly::plot_geo() %>% 
#   plotly::add_trace(
#     z = ~value, 
#     frame= ~timePeriodStart,
#     color = ~value, 
#     colors = 'Oranges',
#     text = ~geoAreaName, 
#     locations = ~iso_alpha3_code) #%>% 
#   
#  # layout(title="Countries that are  ")
# p
# 
# 
# 
# # https://github.com/search?l=R&q=https%3A%2F%2Funstats.un.org%2FSDGAPI%2Fv1&type=Code
# # https://unstats.un.org/sdgapi/swagger/
# 
# ## https://unstats.un.org/SDGAPI/v1
# # https://rpubs.com/angelamhkim/sdgapi
# 
# #you only need jsonlite to get data from API
# library(jsonlite)
# 
# #make an object and paste the URL you got from above
# url <- c("https://unstats.un.org/SDGAPI/v1/sdg/Series/Data?seriesCode=EG_ELC_ACCS&areaCode=4")
# datcall <- fromJSON(url) #depending on the data you are calling, you will get a list 
# names(datcall)
#  
# 
# dat <- datcall$data #select the data table from the list
# DT::datatable(dat, extensions = 'FixedColumns',
#               options = list(
#                 dom = 't',
#                 scrollX = TRUE,
#                 scrollCollapse = TRUE
#               ))
# 
# 
# library(rjson)
# library(jsonlite)
# #url <- 'https://data.un.org/ws/rest/data/DF_UNData_UNFCC'
# url <- 'https://unstats.un.org/SDGAPI/v1/sdg/GeoArea/Tree'
# url2 <- 'https://unstats.un.org/SDGAPI/v1/sdg/Series/SI_POV_DAY1/GeoArea/DE/DataSlice'
# 
# url3 <- 'https://unstats.un.org/SDGAPI/v1/sdg/Goal/DataCSV'
# 
# 
# url4 <- 'https://unstats.un.org/SDGAPI/v1/sdg/Series/Data?seriesCode=SH_STA_MORT'
# url(url3)
# url3
# read.csv(url3)
# close (url3)
# 
# result <- fromJSON(url3)
# 
# this <- jsonlite::fromJSON(url4)
# 
# View ( this$data )
# 
# indicators <- jsonlite::fromJSON('https://unstats.un.org/SDGAPI/v1/sdg/Indicator/List')
# indicators$series[[1]]
# 
# lapply ( indicators$series, rbind )
# 
# available_indicators <- do.call ( rbind, indicators$series)
# 
# try <- jsonlite::fromJSON (
#   paste0( 'https://unstats.un.org/SDGAPI/v1/sdg/Series/Data?seriesCode=', available_indicators$code[21])
# )
# 
# 
# #initiate the df
# SDGdata<- data.frame()
# # call to get the # elements with the years filter
# page1 <- fromJSON("https://unstats.un.org/SDGAPI/v1/sdg/Indicator/Data?timePeriod=2004&timePeriod=2007&timePeriod=2011", flatten = TRUE)
# perpage <- ceiling(page1$totalElements/10)
# ptm <- proc.time()
# for(i in 1:10){
#   SDGpage <- fromJSON(paste0("https://unstats.un.org/SDGAPI/v1/sdg/Indicator/Data?timePeriod=2004&timePeriod=2007&timePeriod=2011&pageSize=",perpage,"&page=",i), flatten = TRUE)
#   message("Retrieving page ", i, " :", (proc.time() - ptm) [3], " seconds")
#   SDGdata <- rbind(SDGdata,SDGpage$data[,1:16])
# }
# 
# fromJSON ("https://unstats.un.org/SDGAPI/v1/sdg/Indicator/SD_MDP_CSMP/Data?timePeriod=2004&timePeriod=2007&timePeriod=2011&pageSize=")