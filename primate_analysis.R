rm(list=ls())

library(readr)
MRI_volume <- read_csv("/Users/mackcross/Documents/research_projects/primate_CNS_project/downloaded_data/Navarrete_MRI_volume.csv")
organ_size <- read_csv("/Users/mackcross/Documents/research_projects/primate_CNS_project/downloaded_data/Navarrete_brain_organ_size.csv", skip = 4)
sleep_data <- read_csv("/Users/mackcross/Documents/research_projects/primate_CNS_project/downloaded_data/Nunn_phylogenetic_sleep.csv", skip = 2)
eye_morphology <- read_csv("/Users/mackcross/Documents/research_projects/primate_CNS_project/downloaded_data/Ross_eye_morphology.csv")

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

# Changed species name 
MRI_volume$species <- sub(" ", "_", MRI_volume$species)

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
organ_size$body_mass_to_organ <- as.integer(organ_size$body_mass_to_organ_g)
organ_size$body_mass_to_bmr <- as.integer(organ_size$body_mass_to_bmr_g)
organ_size$fat_free_body_mass <- as.integer(organ_size$fat_free_body_mass_g)
organ_size$brain_mass <- as.integer(organ_size$brain_mass_g)
organ_size$heart_mass <- as.integer(organ_size$heart_mass_g)

print(organ_size, n=24) 


######################################################################################################################################
######################################################################################################################################
# CLEAN EYE MORPHOLOGY

# Changed data types 
sapply(eye_morphology, class)
eye_morphology$activity_code <- factor(eye_morphology$activity_code)

# Created genus/species column 
eye_morphology$genus_species <- paste(eye_morphology$genus, eye_morphology$species)

print(eye_morphology, n=60)


######################################################################################################################################
######################################################################################################################################
# CLEAN SLEEP DATA 

# Changed names 
names(sleep_data)[names(sleep_data) == "Species"] <- "species"
names(sleep_data)[names(sleep_data) == "TST"] <- "total_sleep_time"
names(sleep_data)[names(sleep_data) == "REM"] <- "rem"
names(sleep_data)[names(sleep_data) == "NREM"] <- "nrem"
names(sleep_data)[names(sleep_data) == "Endocranial Volume"] <- "endocranial_volume"
names(sleep_data)[names(sleep_data) == "Male Mass (kg)"] <- "male_mass_kg"
names(sleep_data)[names(sleep_data) == "Female_Mass (kg)"] <- "female_mass_kg"
names(sleep_data)[names(sleep_data) == "Folivory"] <- "folivory"
names(sleep_data)[names(sleep_data) == "N_Diet_Category"] <- "diet_category"
names(sleep_data)[names(sleep_data) == "Open_Habitat"] <- "open_habitat"
names(sleep_data)[names(sleep_data) == "Activity Period"] <- "activity_period"
names(sleep_data)[names(sleep_data) == "Terrestrial"] <- "terrestrial"
names(sleep_data)[names(sleep_data) == "Day Journey Length"] <- "day_journey_length"
names(sleep_data)[names(sleep_data) == "Group Size"] <- "group_size"
names(sleep_data)[names(sleep_data) == "Nocturnal"] <- "nocturnal"
names(sleep_data)[names(sleep_data) == "Cathemeral"] <- "cathemeral"

# Changed data types 
sleep_data$activity_period <- factor(sleep_data$activity_period)

print(sleep_data)


######################################################################################################################################
######################################################################################################################################
# Merging data frames 
df <- merge(sleep_data, MRI_volume, by.x = "species", by.y = "species")
print(df)

library(ggplot2)
p <- ggplot(data = df, aes(x=total_sleep_time, y=total_brain_vol_mm3, color=species))
p <- p + geom_point()
p <- p + facet_grid(.~activity_period)
p 






