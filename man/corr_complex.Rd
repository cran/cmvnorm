\name{corr_complex}
\alias{corr_complex}
\alias{complex_CF}
\alias{interpolant.quick.complex}
\alias{scales.likelihood.complex}
\title{
Various utilities for complex emulation
}
\description{
Various utilities for investigating complex Gaussian processes
}
\usage{
corr_complex(z1, z2 = NULL, distance.function = complex_CF, means =
NULL, scales = NULL, pos.def.matrix = NULL)
complex_CF(z1,z2, means, pos.def.matrix)
scales.likelihood.complex(pos.def.matrix, scales, means,  zold, z,
               give_log = TRUE, func = regressor.basis)
interpolant.quick.complex(x, d, zold, Ainv, scales = NULL, pos.def.matrix = NULL,
               means=NULL, func = regressor.basis, give.Z = FALSE,
               distance.function = corr_complex, ...)
}
\arguments{
  \item{z, z1, z2}{Points in \eqn{C^n}}
  \item{distance.function}{Function giving the (complex) covariance
    between two points in \eqn{C^n} }
  \item{means, pos.def.matrix, scales}{In function \code{complex_CF()}, the mean
    and covariance matrix of the distribution whose characteristic
    function is used as to give the covariance matrix; \code{scales} is
    used to specify the diagonal of \code{pos.def.matrix} if the
    off-diagonal elements are zero}
  \item{zold, d, give_log, func, x, Ainv, give.Z,...}{Direct analogues of the
    arguments in \code{interpolant()} and \code{scales.likelihood()} in
    the \pkg{emulator} package}
}
\details{

Function \code{corr_complex()} is the complex analogue of
\code{corr.matrix()}, but includes only a single method, that of nested
calls to \code{apply()}.  I could not figure out how to generalize
method 1 does not have a nice complex generalization (AFAICS).

Function \code{complex_CF()} returns the characteristic function of a
complex Gaussian distribution.

Function \code{scales.likelihood.complex()} is a complex version of
\code{scales.likelihood()} which takes a positive definite matrix and a
mean.

Function \code{interpolant.quick.complex()} is a complex version of
\code{interpolant.quick()}.
}

\references{
Hankin, R. K. S. 2005.  "Introducing BACCO, an R bundle for Bayesian
Analysis of Computer Code Output", Journal of Statistical Software, 14(15)
}
\author{
Robin K. S. Hankin
}

\examples{


complex_CF(c(1,1i),c(1,-1i),means=c(1i,1i),pos.def.matrix=diag(2))

V <- latin.hypercube(7,2,complex=TRUE)

cm <- c(1,1+1i)                     # "complex mean"
cs <- matrix(c(2,1i,-1i,1),2,2)   # "complex scales"
tb <- c(1,1i,1-1i)                     # "true beta"

A <- corr_complex(V,means=cm,pos.def.matrix=cs)
Ainv <- solve(A)
z <- drop(rcmvnorm(n=1,mean=regressor.multi(V) \%*\% tb, sigma=A))


betahat.fun(V,Ainv,z)    # should be close to 'tb'

#scales.likelihood.complex(cs,cm,V,z)   # log-likelihood evaluated true parameters



interpolant.quick.complex(x=0.1i+V[1:3,],d=z,zold=V,Ainv=Ainv,pos.def.matrix=cs,means=cm)


}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
