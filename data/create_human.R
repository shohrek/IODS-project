## reading the dataset
# human_development
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
# gender inequality
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

## Str & dim
# inspecting the structure and dimension of hd 
str(hd)
dim(hd)
summary(hd)
# inspecting the structure and dimension of gii 
str(gii)
dim(gii)
summary(gii)

## renaming
#rename(hd,"Human.Development.Index..HDI." = "HDI")
#Human.Development.Index..HDI.
hd <- hd %>% rename(HDI = Human.Development.Index..HDI.,LEB = Life.Expectancy.at.Birth, 
                    EYE=Expected.Years.of.Education, MYE=Mean.Years.of.Education,
                    GNIC=Gross.National.Income..GNI..per.Capita, GNIR=GNI.per.Capita.Rank.Minus.HDI.Rank )

gii <- gii %>% rename(GII = Gender.Inequality.Index..GII.,MRR = Maternal.Mortality.Ratio , 
                    ABR=Adolescent.Birth.Rate , PRP=Percent.Representation.in.Parliament ,
                    PSEF= Population.with.Secondary.Education..Female., 
                    PSEM=Population.with.Secondary.Education..Male.,
                    LFPF=Labour.Force.Participation.Rate..Female.,
                    LFPM=Labour.Force.Participation.Rate..Male. )

## Creating new variables

gii <- mutate(gii, Ratio_PSE = PSEF / PSEM)
gii <- mutate(gii, Ratio_LFP =  LFPF/ LFPM)

# New data frame

human <- inner_join(hd, gii, by = "Country", copy = FALSE, suffix = c(".hd", ".gii"))
human <- write.csv(human,'human.csv')



