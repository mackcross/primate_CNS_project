rm(list=ls())

library(readr)
MRI_volume <- read_csv("/Users/mackcross/Documents/research_projects/primate_CNS_project/raw_data/Navarrete_MRI_volume.csv")
organ_size <- read_csv("/Users/mackcross/Documents/research_projects/primate_CNS_project/raw_data/Navarrete_brain_organ_size.csv", skip = 4)
eye_morphology <- read_csv("/Users/mackcross/Documents/research_projects/primate_CNS_project/raw_data/Kirk_eye_morphology.csv")

######################################################################################################################################
######################################################################################################################################
# CLEAN MRI VOLUME
# Changed names and removed unnecessary columns 
colnames(MRI_volume)
MRI_volume[,27:66] <- NULL
MRI_volume$Source <- NULL
MRI_volume$Identifier <- NULL
MRI_volume$Storage <- NULL
MRI_volume$`Post-mortem (h)` <- NULL
MRI_volume$Infraorder <- NULL
MRI_volume$Superfamily <- NULL
MRI_volume$Family <- NULL
MRI_volume$Subfamily <- NULL
MRI_volume$Sex <- NULL
MRI_volume$`Age (years)` <- NULL
names(MRI_volume)[names(MRI_volume) == "Species"] <- "species"
names(MRI_volume)[names(MRI_volume) == "Body mass (kg)"] <- "body_mass_kg"
names(MRI_volume)[names(MRI_volume) == "Brain mass (g)"] <- "brain_mass_kg"
names(MRI_volume)[names(MRI_volume) == "Total brain volume (mm3)"] <- "total_brain_vol_mm3"
names(MRI_volume)[names(MRI_volume) == "Telencephalon (mm3)"] <- "telencephalon_mm3"
names(MRI_volume)[names(MRI_volume) == "Hemispheres (mm3)"] <- "hemisphers_mm3"
names(MRI_volume)[names(MRI_volume) == "Body mass (kg)"] <- "body_mass_kg"
names(MRI_volume)[names(MRI_volume) == "Right hemisphere  (mm3)"] <- "r_hemisphere_mm3"
names(MRI_volume)[names(MRI_volume) == "Left hemisphere  (mm3)"] <- "l_hemisphere_mm3"
names(MRI_volume)[names(MRI_volume) == "Corpus callosum (mm3)"] <- "corpus_callosum_mm3"
names(MRI_volume)[names(MRI_volume) == "Neocortical grey (mm3)"] <- "neocortical_grey_mm3"
names(MRI_volume)[names(MRI_volume) == "Right neocortical grey (mm3)"] <- "r_neocortical_grey_mm3"
names(MRI_volume)[names(MRI_volume) == "Left neocortical grey (mm3)"] <- "l_neocrotical_grey_mm3"
names(MRI_volume)[names(MRI_volume) == "Lateral geniculate nucleii (mm3)"] <- "lateral_geniculate_nucleii_mm3"
names(MRI_volume)[names(MRI_volume) == "Right lateral geniculate nucleus (mm3)"] <- "r_lateral_geniculate_nucleus_mm3"
names(MRI_volume)[names(MRI_volume) == "Left lateral geniculate nucleus (mm3)"] <- "l_lateral_geniculate_nucleus_mm3"
names(MRI_volume)[names(MRI_volume) == "Cerebellum (mm3)"] <- "cerebellum_mm3"

print(MRI_volume)


######################################################################################################################################
######################################################################################################################################
# CLEAN ORGAN SIZE
# Removed animals which weren't primates or scandentians 
colnames(organ_size)
organ_size <- subset(organ_size, Order=="Primates" | Order=="Scandentia")

# Changed names and removed unnecessary columns 
organ_size$Provenience <- NULL
organ_size$Habitat <- NULL
organ_size$`Source BMR` <- NULL
organ_size$`AD measure` <- NULL
names(organ_size)[names(organ_size) == "BMOrg [g]"] <- "body_mass_to_organ_g"
names(organ_size)[names(organ_size) == "FFBM [g]"] <- "fat_free_body_mass_g"
names(organ_size)[names(organ_size) == "Brain mass [g]"] <- "brain_mass_g"
names(organ_size)[names(organ_size) == "Heart mass [g]"] <- "heart_mass_g"
names(organ_size)[names(organ_size) == "Lungs mass [g]"] <- "lung_mass_g"
names(organ_size)[names(organ_size) == "Kidneys mass [g]"] <- "kidneys_mass_g"
names(organ_size)[names(organ_size) == "Liver mass [g]"] <- "liver_mass_g"
names(organ_size)[names(organ_size) == "Digestive tract mass [g]"] <- "digestive_tract_mass_g"
names(organ_size)[names(organ_size) == "Stomach mass [g]"] <- "stomach_mass_g"
names(organ_size)[names(organ_size) == "Intestine mass [g]"] <- "intestine_mass_g"
names(organ_size)[names(organ_size) == "Spleen mass [g]"] <- "spleen_mass_g"
names(organ_size)[names(organ_size) == "Visc. mass [g]"] <- "visceral_mass_g"
names(organ_size)[names(organ_size) == "Adipose depots [g]"] <- "adipose_g"
names(organ_size)[names(organ_size) == "BMBMR [g]"] <- "body_mass_to_bmr_g"
names(organ_size)[names(organ_size) == "BMR [mLO2/h]"] <- "bmr"
names(organ_size)[names(organ_size) == "Substitute species"] <- "species_sub_bmr"
names(organ_size)[names(organ_size) == "Order"] <- "order"
names(organ_size)[names(organ_size) == "Species"] <- "species"

# Changed data types 
organ_size$order <- factor(organ_size$order)
organ_size$body_mass_to_organ <- as.integer(organ_size$body_mass_to_organ)
organ_size$body_mass_to_bmr <- as.integer(organ_size$body_mass_to_bmr)
organ_size$fat_free_body_mass <- as.integer(organ_size$fat_free_body_mass)
organ_size$brain_mass <- as.integer(organ_size$brain_mass)
organ_size$heart_mass <- as.integer(organ_size$heart_mass)

print(organ_size, n=24) 


######################################################################################################################################
######################################################################################################################################
# CLEAN EYE MORPHOLOGY
# Removed animals which weren't primates or scandentians
eye_morphology <- eye_morphology[c(1:55, 99:102), ]

# Changed names and removed unnecessary columns
colnames(eye_morphology)
names(eye_morphology)[names(eye_morphology) == "Taxon"] <- "species"
names(eye_morphology)[names(eye_morphology) == "N"] <- "specimen_number"
names(eye_morphology)[names(eye_morphology) == "AP"] <- "activity_pattern"
names(eye_morphology)[names(eye_morphology) == "TD"] <- "eye_diameter"
names(eye_morphology)[names(eye_morphology) == "CD"] <- "corneal_diameter"
names(eye_morphology)[names(eye_morphology) == "CD:TD"] <- "ratio_corneal_eye"
eye_morphology$SD...5 <- NULL
eye_morphology$SD...7 <- NULL

# Changed data types 
eye_morphology$activity_pattern <- factor(eye_morphology$activity_pattern)
eye_morphology$specimen_number <- as.integer(eye_morphology$specimen_number)

# Renamed activity levels 
levels(eye_morphology$activity_pattern) <- c("cathemeral", "diurnal", "nocturnal")

print(eye_morphology, n=60)


######################################################################################################################################
######################################################################################################################################


df <- merge(organ_size, MRI_volume, by.x = "species", by.y = "species")
print(df)

library(ggplot2)
p <- ggplot(data = df, aes(x=fat_free_body_mass, y=total_brain_vol_mm3, color=species))
p <- p + geom_point()
p 























