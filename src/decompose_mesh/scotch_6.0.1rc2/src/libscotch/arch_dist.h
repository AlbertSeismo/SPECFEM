/* Copyright 2011,2012 IPB, Universite de Bordeaux, INRIA & CNRS
**
** This file is part of the Scotch software package for static mapping,
** graph partitioning and sparse matrix ordering.
**
** This software is governed by the CeCILL-C license under French law
** and abiding by the rules of distribution of free software. You can
** use, modify and/or redistribute the software under the terms of the
** CeCILL-C license as circulated by CEA, CNRS and INRIA at the following
** URL: "http://www.cecill.info".
** 
** As a counterpart to the access to the source code and rights to copy,
** modify and redistribute granted by the license, users are provided
** only with a limited warranty and the software's author, the holder of
** the economic rights, and the successive licensors have only limited
** liability.
** 
** In this respect, the user's attention is drawn to the risks associated
** with loading, using, modifying and/or developing or reproducing the
** software by the user in light of its specific status of free software,
** that may mean that it is complicated to manipulate, and that also
** therefore means that it is reserved for developers and experienced
** professionals having in-depth computer knowledge. Users are therefore
** encouraged to load and test the software's suitability as regards
** their requirements in conditions enabling the security of their
** systems and/or data to be ensured and, more generally, to use and
** operate it in the same conditions as regards security.
** 
** The fact that you are presently reading this means that you have had
** knowledge of the CeCILL-C license and that you accept its terms.
*/
/************************************************************/
/**                                                        **/
/**   NAME       : arch_dist.h                             **/
/**                                                        **/
/**   AUTHOR     : Sebastien FOURESTIER (v6.0)             **/
/**                                                        **/
/**   FUNCTION   : These lines are the data declaration    **/
/**                for the distance multiplicator pseudo-  **/
/**                architecture functions. This pseudo-    **/
/**                architecture is used by graph reparti-  **/
/**                tioning routines to handle floating-    **/
/**                point migration costs.                  **/
/**                                                        **/
/**   DATES      : # Version 6.0  : from : 14 fev 2011     **/
/**                                 to   : 13 sep 2012     **/
/**                                                        **/
/************************************************************/

/*
**  The type and structure definitions.
*/

/*+ The distance graph definitions. +*/

typedef struct ArchDist_ {
  Arch *                    archptr;              /*+ Encapsulated architecture          +*/
  Anum                      crloval;              /*+ Coefficient load for regular edges +*/
} ArchDist;

typedef struct ArchDistDom_ {
  ArchDom                   domval;               /*+ Encapsulated architecture domain +*/
} ArchDistDom;

/*
**  The function prototypes.
*/

#ifndef ARCH_DIST
#define static
#endif

int                         archDistArchLoad   (ArchDist * restrict const, FILE * restrict const);
int                         archDistArchSave   (const ArchDist * const, FILE * restrict const);
#define archDistArchFree    NULL
int                         archDistArchBuild  (Arch * const, Arch * const, const Anum);
ArchDomNum                  archDistDomNum     (const ArchDist * const, const ArchDistDom * const);
int                         archDistDomTerm    (const ArchDist * const, ArchDistDom * restrict const, const ArchDomNum);
Anum                        archDistDomSize    (const ArchDist * const, const ArchDistDom * const);
Anum                        archDistDomWght    (const ArchDist * const, const ArchDistDom * const);
Anum                        archDistDomDist    (const ArchDist * const, const ArchDistDom * const, const ArchDistDom * const);
int                         archDistDomFrst    (const ArchDist * const, ArchDistDom * const);
int                         archDistDomLoad    (const ArchDist * const, ArchDistDom * const, FILE * const);
int                         archDistDomSave    (const ArchDist * const, const ArchDistDom * const, FILE * const);
int                         archDistDomBipart  (const ArchDist * const, const ArchDistDom * const, ArchDistDom * restrict const, ArchDistDom * restrict const);
int                         archDistDomIncl    (const ArchDist * const, const ArchDistDom * const, const ArchDistDom * const);
#ifdef SCOTCH_PTSCOTCH
int                         archDistDomMpiType (const ArchDist * const, MPI_Datatype * const);
#endif /* SCOTCH_PTSCOTCH */

#undef static
