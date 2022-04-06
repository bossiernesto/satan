 /*
  * open_limit - determine the current open file limit
  * 
  * Environment: POSIX, 44BSD, 43BSD
  * 
  * Author: Wietse Venema.
  */

#include <sys/types.h>
#include <sys/time.h>
#include <sys/resource.h>

/* 44BSD compatibility. */
#ifndef RLIMIT_NOFILE
# ifdef RLIMIT_OFILE
#  define RLIMIT_NOFILE RLIMIT_OFILE
# endif
#endif

int     open_limit()
{
#ifdef RLIMIT_NOFILE
    struct rlimit rl;

    getrlimit(RLIMIT_NOFILE, &rl);
    return (rl.rlim_cur);
#else
    return (getdtablesize());
#endif
}

