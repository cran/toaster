% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/computeGraphClusters.R
\name{computeGraphClusters}
\alias{computeGraphClusters}
\title{Pefrom graph clustering of various types.}
\usage{
computeGraphClusters(channel, graph, type = "connected",
  createMembership = FALSE, includeMembership = FALSE, weight = FALSE,
  vertexWhere = graph$vertexWhere, edgeWhere = graph$edgeWhere,
  distanceTableName = NULL, membershipTableName = NULL, schema = NULL,
  allTables = NULL, test = FALSE, ...)
}
\arguments{
\item{channel}{connection object as returned by \code{\link{odbcConnect}}.}

\item{graph}{an object of class \code{'toagraph'} referencing graph 
tables in Aster database.}

\item{type}{specifies type of clustering or community detection to perform.}

\item{createMembership}{logical indicates if vertex cluster membership table should be created (see \code{membershipTableName}).
Currently, you must set it to \code{TRUE} if cluster membership data (see \code{includeMembership}) expected in the result.
Also, required if operations that create graphs corresponding to some of the clusters to be performed later.}

\item{includeMembership}{logical indicates if result should contain vertex cluster membership information. Currently,
only supported when \code{createMembership} is \code{TRUE}.
WARNING: including cluster membership may result in very large data set returned from Aster into memory.}

\item{weight}{logical or character: if logical then \code{TRUE} indicates using \code{'weight'} edge
attribute, otherwise no weight used. If character then use as a name for the edge weight attribute. 
The edge weight may apply with types \code{'clustering', 'shortestpath'} and centrality measures.}

\item{vertexWhere}{optionally, a \code{SQL WHERE} clause to subset vertex table. When not \code{NULL}
it overrides \code{vertexWhere} condition from the \code{graph}.}

\item{edgeWhere}{optionally, a \code{SQL WHERE} clause to subset edge table. When not \code{NULL}
it overrides \code{edgeWhere} condition from the \code{graph}.}

\item{distanceTableName}{this table will contain distances between vertices (or other corresponding metrics associated with 
community detection algorithm chosen). By default, random table name that begins with \code{toa_temp_graphcluster_distance}
is generated.}

\item{membershipTableName}{when \code{createMembership} is \code{TRUE} then this table will contain vertex cluster membership 
information. By default, random table name that begins with \code{toa_temp_graphcluster_membership} is generated. This 
argument is ignored when \code{createMembership} is \code{FALSE}.}

\item{schema}{name of Aster schema for the table name arguments \code{distanceTableName} and \code{membershipTableName}.
There are two distinct approaches to providing table names: one that uses explicity schema name using this argument and
another when table names already contain schema followed by dot and table name. The latter method is not applicable when
generating randon table name with schema.}

\item{allTables}{pre-built information about existing tables.}

\item{test}{logical: if TRUE show what would be done, only (similar to parameter \code{test} in \pkg{RODBC} 
functions: \link{sqlQuery} and \link{sqlSave}).}

\item{...}{other arguments passed on to Aster graph functions except for \code{EDGEWEIGHT} argument -
use argument \code{weight} instead. Aster function areguments are not case-sensetive.}
}
\value{
\code{computeGraphClusters} returns an object of class \code{"toacommunities"} (compatible with 
  both class \code{"\link[igraph]{communities}"} and the value returned by \code{\link[igraph]{clusters}} - 
  all from the package \pkg{igraph}). It is a list with the following components:
  \describe{
    \item{\code{membership}}{numeric vector giving the cluster (component or community) id to which each vertex belongs.}
    \item{\code{csize} and \code{sizes}}{numeric vector giving the sizes of the clusters.}
    \item{\code{no} and \code{length}}{numeric constant, the number of clusters.}
    
    \item{\code{algorithm}}{gives the name of the algorithm that was used to calculate the community structure.}
    
    \item{\code{id}}{integer vector of cluster ids from 1 to number \code{no}.}
    \item{\code{componentid}}{character vector of cluster names (or component ids) where names are derived from the 
      cluster elements and naming convention differs for each community type.}
    \item{\code{distance}}{numeric vector of average distances within clusters.}
    \item{\code{diameter}}{numeric vector of the maximum distances with clusters.}
    
    \item{\code{graph}}{original graph object that identifies a graph for which clusters are crated.}
    \item{\code{weight}}{see argument \code{weight} above.}
    \item{\code{vertexWhere}}{see argument \code{vertexWhere} above.}
    \item{\code{edgeWhere}}{see argument \code{edgeWhere} above.}
    \item{\code{distanceTableName}}{Aster table name containing graph distances (applies to connected components only).}
    \item{\code{membershipTableName}}{(optional) Aster table name containing graph vertex to cluster memberships.}
    \item{\code{time}}{An object of class \code{proc_time} with user, system, and total elapsed times
    for the \code{computeGraphClusters} function call.}
  }
}
\description{
Graph clustering (or decomposition) divides graph into
set of subgraphs that span whole graph. Depending on the \code{type} argument
the subgraphs coudl be either non-intersecting or overlapping.
Available types of decomposition include finding connected
componenets, modularity clustering.
}
\examples{
if(interactive()) {

# undirected graph
policeGraphUn = toaGraph("dallaspolice_officer_vertices", "dallaspolice_officer_edges_un", 
     directed = FALSE, key = "officer", source = "officer1", target = "officer2", 
     vertexAttrnames = c("offense_count"), edgeAttrnames = c("weight"))
     
communities = computeGraphClusters(conn, policeGraphUn, type="connected", 
                                   createMembership = TRUE, includeMembership = TRUE,
                                   distanceTableName = "public.shortestpathdistances",
                                   membershipTableName = "public.clustermembership")
                                   
# get first 5 largest connected components as graphs
cluster_graphs = computeGraphClustersAsGraphs(conn, communities = communities, ids = 1:5)

# visualize component 2
library(GGally)
ggnet2(cluster_graphs[[2]], node.label="vertex.names", node.size="offense_count", 
       node.color="color", legend.position="none")

# compute connected components for certain type of subgraph that 
# includes only verteics that start with the letters
communities2 = computeGraphClusters(conn, policeGraphUn, type="connected", membership = TRUE,
                                    distanceTableName = "public.shortestpathdistances",
                                    vertexWhere = "officer ~ '[A-Z].*'", 
                                    edgeWhere = "weight > 0.36")
}
}

