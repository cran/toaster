% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plotting.R
\name{createHistogram}
\alias{createHistogram}
\title{Create histogram type of plot.}
\usage{
createHistogram(data, x = "bin_start", y = "bin_count", fill = NULL,
  position = "dodge", facet = NULL, ncol = 1, facetScales = "free_y",
  baseSize = 12, baseFamily = "", xlim = NULL, breaks = NULL,
  text = FALSE, percent = FALSE, digits = 0, textVJust = -2,
  mainColour = "black", fillColour = "grey", scaleGradient = NULL,
  paletteValues = NULL, palette = "Set1", trend = FALSE,
  trendLinetype = "solid", trendLinesize = 1, trendLinecolour = "black",
  title = paste("Histgoram by", fill), subtitle = NULL, xlab = x,
  ylab = y, legendPosition = "right", coordFlip = FALSE,
  defaultTheme = theme_tufte(base_size = baseSize, base_family = baseFamily),
  themeExtra = NULL)
}
\arguments{
\item{data}{data frame contains computed histogram}

\item{x}{name of a column containing bin labels or interval values}

\item{y}{name of a column containing bin values or counts (bin size)}

\item{fill}{name of a column with values to colour bars}

\item{position}{histogram position parameter to use for overlapping bars: 
stack, dodge (defult), fill, identity}

\item{facet}{vector of 1 or 2 column names to split up data to plot the 
subsets as facets. If single name then subset plots are placed next to 
each other, wrapping with \code{ncol} number of columns (uses \code{\link{facet_wrap}}). 
When two names then subset plots vary on both horizontal and vertical 
directions (grid) based on the column values (uses \code{\link{facet_grid}}).}

\item{ncol}{number of facet columns (applies when single facet column supplied only 
- see parameter \code{facet}).}

\item{facetScales}{Are scales shared across all subset plots (facets): 
"fixed" - all are the same, "free_x" - vary across rows (x axis), 
"free_y" - vary across columns (Y axis, default), "free" - both rows and 
columns (see in \code{facet_wrap} parameter \code{scales} )}

\item{baseSize}{\code{\link{theme}} base font size}

\item{baseFamily}{\code{\link{theme}} base font family}

\item{xlim}{a character vector specifying the data range for the x scale and the default order of their display 
in the x axis.}

\item{breaks}{a character vector giving the breaks as they should appear on the x axis.}

\item{text}{if TRUE then display values above bars (default: FALSE) (this feature is in development)}

\item{percent}{format text as percent}

\item{digits}{number of digits to use in text}

\item{textVJust}{vertical justificaiton of text labels (relative to the top of bar).}

\item{mainColour}{Perimeter color of histogram bars}

\item{fillColour}{Fill color of histogram bars (applies only when 
\code{fill} is NULL)}

\item{scaleGradient}{control \code{ggplot2} scale fill gradient manually, 
e.g use \code{scale_colour_gradient} (if specified then parameter 
\code{palette} is ignored)}

\item{paletteValues}{actual palette colours for use with \code{scale_fill_manual}
(if specified then parameter \code{palette} is ignored)}

\item{palette}{Brewer palette name - see \code{display.brewer.all} in 
\code{RColorBrewer} package for names}

\item{trend}{logical indicates if trend line is shown.}

\item{trendLinetype}{trend line type.}

\item{trendLinesize}{size of trend line.}

\item{trendLinecolour}{color of trend line.}

\item{title}{plot title.}

\item{subtitle}{plot subtitle.}

\item{xlab}{a label for the x axis, defaults to a description of x.}

\item{ylab}{a label for the y axis, defaults to a description of y.}

\item{legendPosition}{the position of legends. ("left", "right", "bottom", "top", or two-element numeric 
vector). "none" is no legend.}

\item{coordFlip}{logical flipped cartesian coordinates so that horizontal becomes vertical, and vertical horizontal (see 
\link{coord_flip}).}

\item{defaultTheme}{plot theme settings with default value \code{\link[ggthemes]{theme_tufte}}. More themes
are available here: \code{\link[ggplot2]{ggtheme}} (by \href{http://ggplot2.org/}{ggplot2}) 
and \code{\link[ggthemes]{ggthemes}}.}

\item{themeExtra}{any additional \code{\link[ggplot2]{theme}} settings that override default theme.}
}
\value{
ggplot object
}
\description{
Create histogram plot from the pre-computed distribution of data. Parameter
\code{data} is a data frame containing intervals (bins) and counts obtained 
using \code{\link{computeHistogram}} or \code{\link{computeBarchart}}).
}
\examples{
if(interactive()){
# initialize connection to Lahman baseball database in Aster 
conn = odbcDriverConnect(connection="driver={Aster ODBC Driver};
                         server=<dbhost>;port=2406;database=<dbname>;uid=<user>;pwd=<pw>")

# AL teams pitching stats by decade
bc = computeBarchart(channel=conn, tableName="pitching_enh", category="teamid", 
                     aggregates=c("AVG(era) era", "AVG(whip) whip", "AVG(ktobb) ktobb"),
                     where="yearid >= 1990 and lgid='AL'", by="decadeid", withMelt=TRUE)

createHistogram(bc, "teamid", "value", fill="teamid", 
                facet=c("variable", "decadeid"), 
                legendPosition="bottom",
                title = "AL Teams Pitching Stats by decades (1990-2012)",
                themeExtra = guides(fill=guide_legend(nrow=2)))

# AL Teams Average Win-Loss Difference by Decade 
franchwl = computeBarchart(conn, "teams_enh", "franchid",
                           aggregates=c("AVG(w) w", "AVG(l) l", "AVG(w-l) wl"),
                           by="decadeid",
                           where="yearid >=1960 and lgid = 'AL'")

createHistogram(franchwl, "decadeid", "wl", fill="franchid",
                facet="franchid", ncol=5, facetScales="fixed",
                legendPosition="none",
                trend=TRUE,
                title="Average W-L difference by decade per team (AL)",
                ylab="Average W-L")  
                
# Histogram of team ERA distribution: Rangers vs. Yankees in 2000s
h2000s = computeHistogram(channel=conn, tableName='pitching_enh', columnName='era',
                          binsize=0.2, startvalue=0, endvalue=10, by='teamid',
                          where="yearID between 2000 and 2012 and teamid in ('NYA','TEX')")
createHistogram(h2000s, fill='teamid', facet='teamid', 
                title='TEX vs. NYY 2000-2012', xlab='ERA', ylab='count',
                legendPosition='none')                
                
}
}
\seealso{
\code{\link{computeHistogram}} and \code{\link{computeBarchart}} to
  compute data for histogram
}

