## load package(s), script(s) ####
source("clean-data.R")

# Crystal System:
# source => https://en.wikipedia.org/wiki/Space_group#Table_of_space_groups_in_3_dimensions
#
getCrystalSystem <- function(space_group) {
  crystal_system <- NULL
  #if (space_group < 1) crystal_system <- "NA"
  #else if (space_group > 230) crystal_system <- "NA"
  ##if (space_group %in% c(1, 2)) crystal_system <- "Triclinic"
  if (space_group < 16) { crystal_system <- "Monoclinic"
  } else if (space_group < 75) { crystal_system <- "Orthorhombic"
  } else if (space_group < 143) { crystal_system <- "Tetragonal"
  } else if (space_group < 168) { crystal_system <- "Trigonal"
  } else if (space_group < 195) { crystal_system <- "Hexagonal"
  } else if (space_group < 231) { crystal_system <- "Cubic"
  } else {
    crystal_system <- "NA"
  }
  
  crystal_system
}
train_raw$crystal_system <- sapply(train_raw$spacegroup, getCrystalSystem)
test_raw$crystal_system <- sapply(test_raw$spacegroup, getCrystalSystem)


# Crystal Family:
# same as crystal system, except "Hexagonal" crystal family
# includes "Trigonal" and "Hexagonal" crystal systems
train_raw$crystal_family <- ifelse(train_raw$crystal_system == "Trigonal",
         "Hexagonal", train_raw$crystal_system)
test_raw$crystal_family <- ifelse(test_raw$crystal_system == "Trigonal",
         "Hexagonal", test_raw$crystal_system)


# Schonflies notation:
# implement as little as necessary since there are ~ 32 notations
getSchonflies <- function(space_group) {
  schonflies_notation <- NULL
  if (space_group < 16) { schonflies_notation <- "C_2h"
  } else if (space_group < 47) { schonflies_notation <- "C_2v"
  } else if (space_group < 168) { schonflies_notation <- "D_3d"
  } else if (space_group < 195) { schonflies_notation <- "D_6h"
  } else if (space_group < 207) { schonflies_notation <- "T_h"
  } else if (space_group < 231) { schonflies_notation <- "O_h"
  } else {
    schonflies_notation <- "NA"
  }
  
  schonflies_notation
}
train_raw$schonflies <- sapply(train_raw$spacegroup, getSchonflies)
test_raw$schonflies <- sapply(test_raw$spacegroup, getSchonflies)

# Hermann-Mauguin notation:
# implement as little as necessary since there are ~ 32 notations
getHermannMauguin <- function(space_group) {
  hermann_mauguin_notation <- NULL
  if (space_group < 16) { hermann_mauguin_notation <- "2/m"
  } else if (space_group < 47) { hermann_mauguin_notation <- "mm2"
  } else if (space_group < 168) { hermann_mauguin_notation <- "3bar_m"
  } else if (space_group < 195) { hermann_mauguin_notation <- "6/mmm"
  } else if (space_group < 207) { hermann_mauguin_notation <- "m3bar_"
  } else if (space_group < 231) { hermann_mauguin_notation <- "m3bar_m"
  } else {
    hermann_mauguin_notation <- "NA"
  }
  
  hermann_mauguin_notation
}
train_raw$hermann_mauguin <- sapply(train_raw$spacegroup, getHermannMauguin)
test_raw$hermann_mauguin <- sapply(test_raw$spacegroup, getHermannMauguin)


# convert to factor, (then integer???)
# as.factor, (as.integer???)
train_raw$crystal_system <- as.factor(train_raw$crystal_system)
train_raw$crystal_family <- as.factor(train_raw$crystal_family)
train_raw$schonflies <- as.factor(train_raw$schonflies)
train_raw$hermann_mauguin <- as.factor(train_raw$hermann_mauguin)
#
test_raw$crystal_system <- as.factor(test_raw$crystal_system)
test_raw$crystal_family <- as.factor(test_raw$crystal_family)
test_raw$schonflies <- as.factor(test_raw$schonflies)
test_raw$hermann_mauguin <- as.factor(test_raw$hermann_mauguin)


#getLatticeSystem <- function() {
#  NULL
#}



