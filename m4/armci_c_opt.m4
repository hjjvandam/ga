# ARMCI_C_OPT()
# -------------
# Determine TARGET-/compiler-specific CFLAGS for optimization.
AC_DEFUN([ARMCI_C_OPT], [
AC_REQUIRE([GA_TARGET64])
AC_REQUIRE([GA_ENABLE_OPT])
AC_REQUIRE([GA_ARMCI_NETWORK])
AC_ARG_VAR([ARMCI_COPT], [ARMCI C optimization flags])
AC_CACHE_CHECK([for specific C optimizations], [armci_cv_c_opt], [
AS_IF([test "x$ARMCI_COPT" != x], [armci_cv_c_opt="$ARMCI_COPT"], [armci_cv_c_opt=])
AS_IF([test "x$armci_cv_c_opt" = x && test "x$enable_opt" = xyes], [
AS_CASE([$ga_cv_target:$ga_cv_c_compiler_vendor:$host_cpu:$ga_armci_network],
[CYGWIN:*:*:*],             [armci_cv_c_opt="-malign-double"],
[IBM64:*:*:*],              [armci_cv_c_opt="-O3 -qinline=100 -qstrict -qarch=auto -qtune=auto"],
[IBM:*:*:*],                [armci_cv_c_opt="-O3 -qinline=100 -qstrict -qarch=auto -qtune=auto"],
[LINUX64:fujitsu:x86_64:*], [armci_cv_c_opt="-Kfast"],
[LINUX64:gnu:x86_64:*],     [armci_cv_c_opt="-O3 -funroll-loops"],
[LINUX64:ibm:powerpc64:*],  [armci_cv_c_opt="-O3 -qinline=100 -qstrict -qarch=auto -qtune=auto"],
[LINUX64:ibm:ppc64:*],      [armci_cv_c_opt="-O3 -qinline=100 -qstrict -qarch=auto -qtune=auto"],
[LINUX64:ibm:x86_64:*],     [armci_cv_c_opt=""],
[LINUX64:unknown:alpha:*],  [armci_cv_c_opt="-assume no2underscore -fpe3 -check nooverflow -assume accuracy_sensitive -check nopower -check nounderflow"],
[LINUX:fujitsu:*:*],        [armci_cv_c_opt="-Kfast"],
[LINUX:gnu:686:*],          [armci_cv_c_opt="-O2 -finline-functions -funroll-loops -march=pentiumpro -malign-double"],
[LINUX:gnu:686:OPENIB],     [armci_cv_c_opt="-O2 -finline-functions -funroll-loops -march=pentiumpro"],
[LINUX:gnu:786:*],          [armci_cv_c_opt="-O2 -finline-functions -funroll-loops -march=pentiumpro -malign-double"],
[LINUX:gnu:786:OPENIB],     [armci_cv_c_opt="-O2 -finline-functions -funroll-loops -march=pentiumpro"],
[LINUX:gnu:x86:*],          [armci_cv_c_opt="-O2 -finline-functions -funroll-loops -malign-double"],
[LINUX:gnu:x86:OPENIB],     [armci_cv_c_opt="-O2 -finline-functions -funroll-loops "],
[LINUX:ibm:*:*],            [armci_cv_c_opt="-q32"],
[LINUX:intel:*:*],          [armci_cv_c_opt="-O3 -prefetch"],
[MACX64:*:*:*],             [armci_cv_c_opt=],
[MACX:*:*:*],               [armci_cv_c_opt=],
                            [armci_cv_c_opt=])
])])
AC_SUBST([ARMCI_COPT],  [$armci_cv_c_opt])
])dnl
