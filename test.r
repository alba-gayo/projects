library(reticulate)
library(chron)
install.packages("flexdashboard")


variables <- function(informe){
  informe$Cliente <- as.factor(informe$Cliente)
  informe$Operario <- as.factor(informe$Operario)
  informe$Máquina <- as.factor(informe$Máquina)
  informe$Apero <- as.factor(informe$Apero)
  informe$Acción <- as.factor(informe$Acción)
  informe$Fecha <- as.Date(informe$Fecha)
  informe$Neto <- as.numeric(as.times(informe$Neto))
}
