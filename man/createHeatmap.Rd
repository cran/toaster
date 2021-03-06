% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plotting.R
\name{createHeatmap}
\alias{createHeatmap}
\title{Create Heat Map type of plot.}
\usage{
createHeatmap(data, x, y, fill, facet = NULL, ncol = 1, baseSize = 12,
  baseFamily = "sans", thresholdValue = NULL, thresholdName = fill,
  text = FALSE, textFill = fill, percent = FALSE,
  digits = ifelse(percent, 2, 4), divergingColourGradient = FALSE,
  lowGradient = ifelse(divergingColourGradient, muted("red"), "#56B1F7"),
  midGradient = "white", highGradient = ifelse(divergingColourGradient,
  muted("blue"), "#132B43"), title = paste("Heatmap by", fill),
  subtitle = NULL, xlab = x, ylab = y, legendPosition = "right",
  fillGuide = "colorbar", defaultTheme = theme_tufte(base_size = baseSize,
  base_family = baseFamily), themeExtra = NULL)
}
\arguments{
\item{data}{data frame contains data computed for heatmap}

\item{x}{name of a column containing x variable values (1st or horizontal dimenstion) in 2D matrix}

\item{y}{name of a column containing y variable values (2d or vertical dimension) in 2D matrix}

\item{fill}{name of a column with values to map to heatmap gradient colors (\code{lowGradient}, 
\code{highGradient}, and optionally \code{midGradient}).}

\item{facet}{vector of 1 or 2 column names to split up data to plot the 
subsets as facets. If single name then subset plots are placed next to 
each other, wrapping with \code{ncol} number of columns (uses \code{\link{facet_wrap}}). 
When two names then subset plots vary on both horizontal and vertical 
directions (grid) based on the column values (uses \code{\link{facet_grid}}).}

\item{ncol}{number of facet columns (applies when single facet column supplied only 
- see parameter \code{facet}).}

\item{baseSize}{\code{\link{theme}} base font size}

\item{baseFamily}{\code{\link{theme}} base font family}

\item{thresholdValue}{threshold to use to display data in heatmap (if NULL then do not use threshold)}

\item{thresholdName}{name of data attribute from \code{data} to use (by defult use \code{fill})}

\item{text}{if TRUE then display values in heatmap table (default: FALSE)}

\item{textFill}{text to display (applies only when \code{text} is TRUE), by defaul use \code{fill} values}

\item{percent}{format text as percent}

\item{digits}{number of digits to use in text}

\item{divergingColourGradient}{logical diverging colour gradient places emphasize on both low and high leaving
middle neutral. Use when both end grandient colours represent critical values such as negative and positive 
extremes (e.g. temprature, outliers, etc.).}

\item{lowGradient}{colour for low end of gradient.}

\item{midGradient}{colour for mid point.}

\item{highGradient}{colour for high end of gradient.}

\item{title}{plot title.}

\item{subtitle}{plot subtitle.}

\item{xlab}{a label for the x axis, defaults to a description of x.}

\item{ylab}{a label for the y axis, defaults to a description of y.}

\item{legendPosition}{the position of legends. ("left", "right", "bottom", "top", or two-element numeric 
vector). "none" is no legend.}

\item{fillGuide}{Name of guide object, or object itself for the \code{fill}. Typically \code{"colorbar"} name
or object \code{\link[ggplot2]{guide_colourbar}}.}

\item{defaultTheme}{plot theme settings with default value \code{\link[ggthemes]{theme_tufte}}. More themes
are available here: \code{\link[ggplot2]{ggtheme}} (by \href{http://ggplot2.org/}{ggplot2}) 
and \code{\link[ggthemes]{ggthemes}}.}

\item{themeExtra}{any additional \code{\link[ggplot2]{theme}} settings that override default theme.}
}
\value{
ggplot object
}
\description{
Create heat map visualization of 2D matrix from the data frame \code{data}
pre-computed with \code{\link{computeHeatmap}}.
}
\examples{
if(interactive()){
# initialize connection to Lahman baseball database in Aster 
conn = odbcDriverConnect(connection="driver={Aster ODBC Driver};
                         server=<dbhost>;port=2406;database=<dbname>;uid=<user>;pwd=<pw>")

hm = computeHeatmap(conn, "teams_enh", 'franchid', 'decadeid', 'avg(w) w', 
                    where="decadeid >= 1950")
hm$decadeid = factor(hm$decadeid)
createHeatmap(hm, 'decadeid', 'franchid', 'w')

# with diverging color gradient
hm = computeHeatmap(conn, "teams_enh", 'franchid', 'decadeid', 'avg(w-l) wl', 
                    where="decadeid >= 1950")
hm$decadeid = factor(hm$decadeid)
createHeatmap(hm, 'decadeid', 'franchid', 'wl', divergingColourGradient = TRUE)
}
}
\seealso{
\code{\link{computeHeatmap}} for computing data for heat map
}

