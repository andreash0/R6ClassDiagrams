create_class_diagram <- function(x = ".") {
  x <- devtools::package_file(path = x)
  pkgload::load_all(x, export_all = TRUE, export_imports = FALSE, helpers = FALSE, attach_testthat = FALSE)
  package_name <- basename(x)
  package_env <- paste0("package:", package_name)
  all_object_names <- ls(package_env)
  all_objects <- lapply(all_object_names, getFromNamespace, package_name)

  all_R6_classes <- all_objects[vapply(all_objects, R6::is.R6Class, FUN.VALUE = logical(1L))]
  names(all_R6_classes) <- sapply(all_R6_classes, function(x) x$classname)
  inhertiances <- lapply(all_R6_classes, function(x) x$get_inherit()$classname)

  str_grViz <- list()
  for (i in seq_along(inhertiances)) {
    child <- names(inhertiances)[[i]]
    parent <- inhertiances[[i]]
    if (is.null(parent)) {
      str_grViz[[i]] <- child
    } else {
      str_grViz[[i]] <- paste(child, "->", parent)
    }
  }
  paste(str_grViz, collapse = "\n")
}

