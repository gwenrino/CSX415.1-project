library('ProjectTemplate')
load.project()

dengue.features.train <- read_csv("~/Documents/Data_Science_Learning/CompSci415.1/CSX415.1-project/dengue/data/dengue_features_train.csv")
dengue.labels.train <- read_csv("~/Documents/Data_Science_Learning/CompSci415.1/CSX415.1-project/dengue/data/dengue_labels_train.csv")
hotel.guests.copy <- read_csv("~/Documents/Data_Science_Learning/CompSci415.1/CSX415.1-project/dengue/data/hotel_guests_copy.csv")