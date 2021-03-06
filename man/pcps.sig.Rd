% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/matrix.p.sig.R, R/pcps.sig.R
\encoding{UTF-8}
\name{matrix.p.sig}
\alias{matrix.p.sig}
\alias{pcps.sig}
\alias{matrix.p.sig}
\title{Association between phylogeny-weighted species composition and environmental predictors}
\usage{
matrix.p.sig(comm, phylodist, envir, analysis = c("adonis", "mantel"),
  method = "bray", squareroot = TRUE, method.envir = "euclidean",
  runs = 999, parallel = NULL, newClusters = TRUE, CL = NULL)

pcps.sig(comm, phylodist, envir, analysis = c("glm", "rda"),
  method = "bray", squareroot = TRUE, formula, family = stats::gaussian,
  AsFactors = NULL, pcps.choices = c(1, 2, 3, 4), runs = 999,
  parallel = NULL, newClusters = TRUE, CL = NULL)
}
\arguments{
\item{comm}{Community data, with species as columns and sampling units as rows. This matrix 
can contain either presence/absence or abundance data.}

\item{phylodist}{Matrix containing phylogenetic distances between species.}

\item{envir}{Environmental variables for each community, with variables as columns and 
sampling units as rows.}

\item{analysis}{Type of analysis. For the function pcps.sig \code{\link{glm}} or 
\code{\link{rda}}, for matrix.p.sig function \code{\link{adonis}} or \code{\link{mantel}}.
See Details.}

\item{method}{Dissimilarity index, as accepted by \code{\link{vegdist}} (Default dist = "bray").}

\item{squareroot}{Logical argument (TRUE or FALSE) to specify if use square root of 
dissimilarity index (Default squareroot = TRUE).}

\item{method.envir}{Resemblance index between communities based on environmental variables, 
as accepted by vegdist used in Mantel analysis (Default method.envir = "euclidean")}

\item{runs}{Number of permutations for assessing significance.}

\item{parallel}{Number of parallel processes.  Tip: use detectCores() (Default parallel = NULL).}

\item{newClusters}{Logical argument (TRUE or FALSE) to specify if make new parallel 
processes or use predefined socket cluster. Only if parallel is different of NULL (Default newClusters = TRUE).}

\item{CL}{A predefined socket cluster done with parallel package.}

\item{formula}{An object of class \code{\link{formula}} quotation marks used in GLM analysis. 
See Details.}

\item{family}{A description of the error distribution to be used in used in GLM analysis. 
See \code{\link{family}} (Dafault family = gaussian).}

\item{AsFactors}{Encode an environmental variable as factor used in GLM analysis. The sequence 
is the same that in the environmental data matrix. See Details.}

\item{pcps.choices}{PCPS used in RDA analysis (Default pcps.choices = c(1, 2, 3, 4)).}
}
\value{
\item{model}{The model, an object of class glm, rda, adonis or mantel.}
\item{envir_class}{The class of each variable in environmental data in glm.}
\item{formula}{The formula used in glm.} \item{statistic.obs}{Observed F value or r value.}
\item{p.site.shuffle}{The p value for the site shuffle null model.}
\item{p.taxa.shuffle}{The p value for the taxa shuffle null model.}
}
\description{
Analyses to relate an environmental gradient to the phylogenetic assembly of species 
across a metacommunity by means of phylogenetic fuzzy weighting.
}
\details{
Each metacommunity is submitted to phylogenetic fuzzy weighting, generating a matrix
that describing the phylogeny-weighted species composition of the communities
(\code{\link{matrix.p}}). The function matrix.p.sig test directly the association 
this matrix with the environmental predictors. The pairwise dissimilarities are 
submitted to Mantel test (\code{\link{mantel}}) or ADONIS test (\code{\link{adonis}})
to evaluate the influence of an environmental gradient on species dispersion across 
the communities. The function pcps.sig generates principal coordinates of phylogenetic
structure (\code{\link{pcps}}) and use a single axis for run a generalized linear 
model (GLM, \code{\link{glm}}) or use set of axis for run a distance-based redundancy
analysis (db-RDA, \code{\link{rda}}).

The significance is obtained via two null models, one that shuffles sites across the
environmental gradient and another that shuffles terminal tips (taxa) across the phylogenetic
tree. The first null model (site shuffle) shuffles the site position across the environmental
gradient and rerun the same model, generating a null F value (or r value in Mantel test). The
second null model (taxa shuffle), shuffles terminal tips across the phylogenetic tree and 
generates a null matrix containing phylogeny-weighted species composition and rerun the same
model, generating another null F value. In the pcps.sig function are generate set of null PCPS
and each null PCPS (or set of PCPS in RDA) is submitted to a procrustean adjustment 
(see \code{\link{procrustes}}), and the fitted values between observed PCPS and null PCPS is 
obtained. The adjusted null PCPS is used to rerun the model, generating another null F value. 
The observed F value (or r value) is compared independently with both null sets of F values 
(or r value) to generate a probability value of the original F value being generated merely by
chance according to each null model.

The item formula is an expression of the form pcps.1 ~ model. The response term must be the 
pcps name, for example pcps.1, pcps.2, pcps.12.

The item AsFactors changes a environmental variable for the class \code{\link{factor}}. The 
sequence is the same that in the environmental data matrix, not the order in the formula.
Use \code{\link{c}} to combine more that one variable.
}
\examples{

data(flona)
pcps.sig(flona$community, flona$phylo, flona$environment, analysis = "glm",
        formula = "pcps.1~alt", runs = 99)
matrix.p.sig(flona$community,flona$phylo,flona$environment[, 2, drop = FALSE],
        analysis = "adonis", runs = 99)


}
\references{
Duarte, L.S. (2011). Phylogenetic habitat filtering influences forest 
nucleation in grasslands. Oikos, 120, 208:215.
}
\seealso{
\code{\link{matrix.p}}, \code{\link{pcps}}, \code{\link{procrustes}}, 
\code{\link{glm}}, \code{\link{rda}}, \code{\link{adonis}}, \code{\link{mantel}}
}
\author{
Vanderlei Julio Debastiani <vanderleidebastiani@yahoo.com.br>
}
\keyword{PCPS}
