group_by_not <- function(.data, ..., add = FALSE) {
  group_by_not_(.data, .dots = lazyeval::lazy_dots(...), add = add)
}

group_by_not_ <- function(.data, ..., .dots, add = FALSE) {
  group_by_(.data, .dots = Filter(function(name) !(name %in% Map(function(lazy) lazy$expr, .dots)),
                                  names(.data)))
}
