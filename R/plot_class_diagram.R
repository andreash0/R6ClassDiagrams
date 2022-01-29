plot_class_diagram <- function() {
  str_grViz <- create_class_diagram()
  str_grViz <- paste(
    "
      digraph G {
        node [
          shape = 'record'
        ]
    ", str_grViz, "}")
  DiagrammeR::grViz(str_grViz)
}
