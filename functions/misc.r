
merge_by_group <- function(x, y){
  bind_rows(
    mutate(x, category="Asian"),
    mutate(y, category="Latino"))
}

                              