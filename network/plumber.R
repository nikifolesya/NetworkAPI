# plumber.R
library(plumber)
library(plotly)
library(htmlwidgets)

#* @filter cors
cors <- function(req, res) {
  res$setHeader("Access-Control-Allow-Origin", "*")
  res$setHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS")
  res$setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization")
  plumber::forward()
}

#* Plot an interactive histogram using plotly
#* @serializer html
#* @get /plot
function() {
  rand <- rnorm(100)
  p <- plot_ly(x = ~rand, type = "histogram")
  
  # Создаем временный файл для сохранения графика
  tmp <- tempfile(fileext = ".html")
  saveWidget(p, tmp, selfcontained = TRUE)
  
  # Читаем содержимое файла и возвращаем его
  readChar(tmp, file.info(tmp)$size)
}
