set.seed(123)
options(digits = 3)

knitr::opts_chunk$set(
  # comment = "#>",
  collapse = TRUE,
  cache = TRUE,
  # echo = FALSE,
  message = FALSE,
  warning = FALSE,
  out.width = "80%",
  fig.align = "center",
  fig.width = 6,
  fig.asp = 0.618 # 1 / phi
)

# set base theme
ggplot2::theme_set(ggplot2::theme_minimal(base_size = 14))

# create default plot template for drawing functions
function_plot <- ggplot2::ggplot(
  data = tibble::tibble(x = 0),
  mapping = ggplot2::aes(x = x)
) +
  ggplot2::geom_hline(yintercept = 0, linetype = 2, alpha = .5) +
  ggplot2::geom_vline(xintercept = 0, linetype = 2, alpha = .5) +
  ggplot2::xlim(-4, 4) +
  ggplot2::labs(
    x = expression(x),
    y = expression(y)
  )
