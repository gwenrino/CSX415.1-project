INPUTS
------

**DATA**

**As downloaded from [www.drivendata.org](www.drivendata.org):**  
Test set features: ~CSX415.1-project/dengue/data/dengue\_features\_test.csv  
Training set features: ~CSX415.1-project/dengue/data/dengue\_features\_train.csv  
Training set labels: ~CSX415.1-project/dengue/data/dengue\_labels\_train.csv  

**As munged for usage in project:**  
Training set with labels and season variable:  
~CSX415.1-project/dengue/cache/dengue.data.RData  
Training set with labels and season variable, filtered for San Juan data only:  
~CSX415.1-project/dengue/cache/dengue.sj.RData  

OUTPUTS
-------

**FORMAL PROBLEM STATEMENT**  
~CSX415.1-project/dengue/reports/FPS\_Dengue\_Fever.Rmd

**EXPLORATORY DATA ANALYSIS**  
~CSX415.1-project/dengue/src/EDA.R

**EDA VISUALIZATIONS**  
~CSX415.1-project/dengue/src/EDA.viz.R  
~CSX415.1-project/dengue/graphs/EDAviz

**MODELS**  
~CSX415.1-project/dengue/src/0.Naive.R  
~CSX415.1-project/dengue/src/1.Linear.R  
~CSX415.1-project/dengue/src/2.Tree.R

(more forthcoming)

**MODEL PERFORMANCE EVALS**  
~CSX415.1-project/dengue/reports/Model\_Performance/model-performance-naive.Rmd  
~CSX415.1-project/dengue/reports/Model\_Performance/model-performance-linear.Rmd  
~CSX415.1-project/dengue/reports/Model\_Performance/model-performance-rpart.Rmd

(more forthcoming)
