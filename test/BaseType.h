/*! \file
 * Description
 */
#ifndef _BASE_TYPE_H
#define _BASE_TYPE_H

//Type def 
typedef long long		S64;
typedef int                 S32;
typedef short			S16;
typedef char			S8;
typedef unsigned long long  U64;
typedef unsigned int        U32;
typedef unsigned short	    U16;
typedef unsigned char	    U8;

/* isoler le mot clef "long" : ne pas utiliser "long double" */
typedef long double         LDBL;

///FIXME pourquoi U16 ici ?
typedef U16 event_t;

/* Following types are deprecated (don't use; will be removed); only allowed usage in vxWorks OS system calls, with cast from equivalent not deprecated type */
typedef S32 MOT32;
typedef S16 MOT16;
typedef S8  MOT8;
typedef	 char TBOOL;

/* isoler le mot clef "long" */
#define U32_MAX 0xFFFFFFFFU

#if defined(WIN32) // vxWorks old predefined types; used for compatibility with vxWorks OS emulation.  
//typedef U8 UINT8;
//typedef U8  UCHAR;
//typedef U16 USHORT;
//typedef U16      UINT16;
//typedef S16      INT16;
//typedef S32 INT32;
//typedef S64      INT64;
//typedef U32      UINT32;
//typedef U64      UINT64;

// typedef U32 UINT;//windows = "unsigned int" type
// typedef U32 ULONG; //windows "long" type
typedef	S32				BOOL;//windows = "int" type
typedef char *PCHAR;
// ici les types définis par l'OS sont réécrits et centralisés. Leur usage est strictement réservé au *cast* de type DEV203 équivalents, et uniquement dans l'appel de l'API de l'OS
// on préfixe le type de l'OS par OS_
// exemple :
// U32 len;
// appelWindows((OS_PUINT) &len); si l'API est appelWindows(PUINT lg);
#define OS_PUINT PUINT
#define OS_UINT32 UINT32
#define OS_INT   int 
#define OS_PINT  int * 
#define OS_LONG  long 
#define OS_PLONG long *
#define OS_ULONG  unsigned long 
#define OS_PULONG unsigned long *
typedef S64 _Vx_usr_arg_t;
typedef unsigned int _Vx_event_t;
#endif // defined(WIN32)

//For VxWorks
#ifndef WIN32
	// Portage X64 - types generiques
#if defined(CALIA4)
	typedef U64		UINT_PTR;
	typedef S64		INT_PTR;
	typedef S64	SOCKET;
#elif defined(CALIA3)
	typedef U32		UINT_PTR;
	typedef S32		INT_PTR;
	typedef int		SOCKET;
#endif /* defined(CALIA3) */
#define OS_UINT32 UINT32
#define OS_PUINT  unsigned int *
#define OS_PINT   int *
#define OS_INT    int 

#endif /* !defined(WIN32) */
//Status
typedef	int STATUS;

//types generiques sur 32 bits utilises pour definir un champ de bit destine a stocker des id de vues/cameras.
typedef U32   BITFIELD;
typedef U32 * PTR_BITFIELD;
typedef volatile U32 * PTRV_BITFIELD;

///FIXME LHK types vxWorks prédéfinis; soit on renomme en Uxx, soit on inclus <vxWorks.h>
//typedef U8  UCHAR;
//typedef U16 USHORT;
//typedef U32 ULONG;


#ifndef ULONG_PTR
#	if defined(_WIN64)
typedef unsigned __int64 ULONG_PTR;
#	else /* !defined(_WIN64) */
#ifndef MODIF_TIAMA
typedef U32 ULONG_PTR;
#endif
#	endif /* !defined(_WIN64) */
#endif /* !defined(ULONG_PTR) */

#ifndef LONG_PTR
#if defined(_WIN64)
 typedef __int64 LONG_PTR; 
#else /* !defined(_WIN64) */
#ifndef MODIF_TIAMA
 typedef S32 LONG_PTR;
#endif
#endif /* !defined(_WIN64) */
#endif /* !defined(LONG_PTR) */

                        

//Basic values
#define PI	3.1415926536

//----------------------------------------------------------------------------
// CODES DE RETOUR
//----------------------------------------------------------------------------
#define CODE_OK			0
#define CODE_NOK		-1
#define CODE_OVERFLOW	-2


//IMAGE TREATMENT
// ------------- Enumerate ----------------

enum ENUM_FLAG_SOBEL
{
    SOBEL_VERTICAL,
    SOBEL_HORIZONTAL,
    SOBEL_VERTICAL_HORIZONTAL
};

enum ENUM_TYPE_TRAITEMENT_CANNY
{
    TYPE_TRAITEMENT_CANNY_SEUILLAGE = 1
};

// ------------- Structure  ----------------

typedef struct
{
	U16 X;
	U16 Y;
	U16 Length;
	U8  Transition;
	U8  Forme;
} STR_EMPAN_C2;


typedef struct
{
    U32 month;
    U32 year;
    U32 day;
} T_date;
typedef struct
{
    U32 hour;
    U32 minute;
    U32 second;
} T_time;

#endif
